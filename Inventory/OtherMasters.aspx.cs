using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Reflection.Emit;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Label = System.Web.UI.WebControls.Label;
using System.Web.Configuration;
using System.Xml.Linq;
namespace Inventory
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(
    WebConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string a = Session["UserID"].ToString();
            }
            catch (Exception)
            {
                Response.Redirect("~/login.aspx");
            }
            if (!IsPostBack)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_unit", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MODE", "Getcodespecific");
                DropDownList1.DataSource = cmd.ExecuteReader();
                DropDownList1.DataTextField = "Unitname";
                DropDownList1.DataValueField = "Unitcode";
                DropDownList1.DataBind();
                con.Close();
                DropDownList1.Items.Insert(0, new ListItem("-Select Unit Name-", ""));
                DropDownList1.SelectedIndex = 0;
            }

        }

        protected void DropDownList1_SelectedIndexChanged1(object sender, EventArgs e)
        {
            string selectedValue = DropDownList1.SelectedValue;
            string selectedText = DropDownList1.SelectedItem.Text;
            // For example, display the selected value in a label
            label1.Text = "You selected: " + selectedText + " (Value: " + selectedValue + ")";
            bindGrid();
        }
        public void bindGrid()
        {
            con.Open();
            SqlCommand cmd;
            if (!itemcategbtn.Enabled)
            {
                cmd = new SqlCommand("sp_itemcategory", con);
                cmd.Parameters.AddWithValue("@unitcod", DropDownList1.SelectedValue);

            }
            else if (!colorbtn.Enabled)
            {
                cmd = new SqlCommand("SP_colors", con);
            }
            else
            {
                cmd = new SqlCommand("sp_model", con);
                cmd.Parameters.AddWithValue("@unitcod", DropDownList1.SelectedValue);

            }
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "Get");
            var da = new SqlDataAdapter(cmd);
            var ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0)
            {
                GridView2.DataSource = ds.Tables[0];
                GridView2.DataBind();
            }
            con.Close();
        }

        protected void addbtn_Click(object sender, EventArgs e)
        {
            string value = DropDownList1.SelectedValue;
            if (!itemcategbtn.Enabled)
            {
                categ.Text = "Item Category";
                name.Attributes.Add("placeholder", "Enter Category");
            }
            else if (!colorbtn.Enabled)
            {
                categ.Text = "Color Name";
                name.Attributes.Add("placeholder", "Enter Color Name");
            }
            else
            {
                categ.Text = "Model Name";
                name.Attributes.Add("placeholder", "Enter Model Name");
            }
            if (value == "" & colorbtn.Enabled)
            {
                string script1 = "toastr.warning('Please select Unit Code first!', '', { closeButton: true, timeOut: 3000 });";
                ClientScript.RegisterStartupScript(this.GetType(), "showToast", script1, true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "showModal", "var myModal = new bootstrap.Modal(document.getElementById('mymodal')); myModal.show();", true);

            }
        }

        protected void save_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd;
            if (!itemcategbtn.Enabled)
            {
                cmd = new SqlCommand("sp_itemcategory", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@unitcod", DropDownList1.SelectedValue);
                cmd.Parameters.AddWithValue("@categname", name.Text);
            }
            else if (!colorbtn.Enabled)
            {
                cmd = new SqlCommand("SP_colors", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@colorname", name.Text);

            }
            else
            {
                cmd = new SqlCommand("sp_model", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@unitcod", DropDownList1.SelectedValue);
                cmd.Parameters.AddWithValue("@modelname", name.Text);
            }
            if (save.Text == "Update")
            {
                cmd.Parameters.AddWithValue("@Mode", "Update");
                cmd.Parameters.AddWithValue("@updatedby", Session["UserID"].ToString());
                cmd.Parameters.AddWithValue("@updateddate", DateTime.Now.ToString("yyyy-MM-dd"));
                if (!itemcategbtn.Enabled)
                {
                    cmd.Parameters.AddWithValue("@itemcod", entryid.Text);
                }
                else if (!colorbtn.Enabled)
                {
                    cmd.Parameters.AddWithValue("@colorcod", entryid.Text);
                }
                else
                {
                    cmd.Parameters.AddWithValue("@modelcod", entryid.Text);
                }
            }
            else
            {
                cmd.Parameters.AddWithValue("@Mode", "save");
                cmd.Parameters.AddWithValue("@createdby", Session["UserID"].ToString());
            }
            string status = Convert.ToString(cmd.ExecuteScalar());
            con.Close();
            if (status == "exists")
            {
                string script1 = "toastr.warning('Entry already exists!', '', { closeButton: true, timeOut: 3000 });";
                ClientScript.RegisterStartupScript(this.GetType(), "showToast", script1, true);
            }
            else if (status == "saved")
            {
                string script1 = "toastr.success('Saved Successfully!', '', { closeButton: true, timeOut: 3000 });";
                ClientScript.RegisterStartupScript(this.GetType(), "showToast", script1, true);
                name.Text = "";
                bindGrid();
            }
            else if (status == "Updated")
            {
                string script1 = "toastr.success('Updated Successfully!', '', { closeButton: true, timeOut: 3000 });";
                ClientScript.RegisterStartupScript(this.GetType(), "showToast", script1, true);
                name.Text = "";
                save.Text = "Save";
                bindGrid();
            }
        }

        protected void GridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lablemssg.Text = " ";
            Label lblid = (Label)GridView2.Rows[e.NewEditIndex].FindControl("gridunitCode");
            Label lblName = (Label)GridView2.Rows[e.NewEditIndex].FindControl("griditemcategory");
            name.Text = lblName.Text;
            entryid.Text = lblid.Text;
            save.Text = "Update";
            addbtn_Click(sender, e);
            //clear.Enabled = false;


        }
        protected void gridview_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView2.PageIndex = e.NewPageIndex;
            bindGrid();
        }
        protected void CustomCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CustomDelete")
            {
                int rowIndex = int.Parse((string)e.CommandArgument);
                Label lblid = (Label)GridView2.Rows[rowIndex].FindControl("gridunitCode");
                SqlCommand cmd;
                if (!itemcategbtn.Enabled)
                {
                    cmd = new SqlCommand("sp_itemcategory", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Mode", "Delete");
                    cmd.Parameters.AddWithValue("@itemcod", lblid.Text);
                }
                else if (!colorbtn.Enabled)
                {
                    cmd = new SqlCommand("SP_colors", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Mode", "Delete");
                    cmd.Parameters.AddWithValue("@colorcod", lblid.Text);
                }
                else
                {
                    cmd = new SqlCommand("sp_model", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Mode", "Delete");
                    cmd.Parameters.AddWithValue("@modelcod", lblid.Text);
                }
                con.Open();
                //lablemssg.Text = Convert.ToString(cmd.ExecuteScalar());
                //ClientScript.RegisterStartupScript(this.GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lablemssg.ClientID + "').innerText = ' ';\",2000)</script>");
                string script = @"toastr.error('Deleted!', 'Info', { closeButton: true, timeOut: 3000 });";
                ClientScript.RegisterStartupScript(this.GetType(), "showToast", script, true);
                cmd.ExecuteNonQuery();
                con.Close();
                bindGrid();
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            name.Text = "";
            save.Text = "Save";
            entryid.Text = "";
        }

        protected void itemcategbtn_Click1(object sender, EventArgs e)
        {
            heading1.Text = "Item Category";
            itemcategbtn.Enabled = false;
            modelbtn.Enabled = true;
            itemcategbtn.Font.Underline = true;
            DropDownList1.Enabled = true;
            colorbtn.Enabled = true;
            modelbtn.Font.Underline = false;
            bindGrid();
        }

        protected void modelbtn_Click(object sender, EventArgs e)
        {
            heading1.Text = "Model";
            itemcategbtn.Enabled = true;
            modelbtn.Enabled = false;
            itemcategbtn.Font.Underline = false;
            DropDownList1.Enabled = true;

            colorbtn.Enabled = true;
            modelbtn.Font.Underline = true;
            bindGrid();

        }

        protected void colorbtn_Click(object sender, EventArgs e)
        {
            heading1.Text = "Colors";
            DropDownList1.Enabled = false;
            itemcategbtn.Enabled = true;
            modelbtn.Enabled = true;
            colorbtn.Enabled = false;
            itemcategbtn.Font.Underline = false;
            modelbtn.Font.Underline = true;
            bindGrid();

        }
    }
}