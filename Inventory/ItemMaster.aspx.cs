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
using System.Web.Script.Serialization;
using System.Xml.Linq;
using System.Web.Services;


namespace Inventory
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        bool a = true;
        bool aa = true;
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
                DropDownList2.Items.Insert(0, new ListItem("-Select Item Category-", ""));
                DropDownList2.SelectedIndex = 0;
                DropDownList3.Items.Insert(0, new ListItem("-Select Model-", ""));
                DropDownList3.SelectedIndex = 0;
                DropDowncolor.Items.Insert(0, new ListItem("-Select Color-", ""));
                DropDowncolor.SelectedIndex = 0;
            }
        }
        protected void DropDownList1_SelectedIndexChanged1(object sender, EventArgs e)
        {
            string selectedValue = DropDownList1.SelectedValue;
            string selectedText = DropDownList1.SelectedItem.Text;
            // For example, display the selected value in a label
            //label1.Text = "You selected: " + selectedText + " (Value: " + selectedValue + ")";
            SqlCommand cmd = new SqlCommand("sp_itemcategory", con);
            SqlCommand cmd2 = new SqlCommand("sp_model", con);
            SqlCommand cmd3 = new SqlCommand("SP_colors", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "Getspecific");
            cmd.Parameters.AddWithValue("@unitcod", DropDownList1.SelectedValue);
            cmd2.CommandType = System.Data.CommandType.StoredProcedure;
            cmd2.Parameters.AddWithValue("@Mode", "Getspecific");
            cmd2.Parameters.AddWithValue("@unitcod", DropDownList1.SelectedValue);
            cmd3.CommandType = System.Data.CommandType.StoredProcedure;
            cmd3.Parameters.AddWithValue("@Mode", "get");
            con.Open();
            DropDownList2.DataSource = cmd.ExecuteReader();
            DropDownList2.DataTextField = "CategoryName";
            DropDownList2.DataValueField = "Itemid";
            DropDownList2.DataBind();
            con.Close();
            con.Open();
            DropDownList3.DataSource = cmd2.ExecuteReader();
            DropDownList3.DataTextField = "Modelname";
            DropDownList3.DataValueField = "Modelid";
            DropDownList3.DataBind();
            con.Close();
            con.Open();
            DropDowncolor.DataSource = cmd3.ExecuteReader();
            DropDowncolor.DataTextField = "Name";
            DropDowncolor.DataValueField = "ID";
            DropDowncolor.DataBind();
            con.Close();
            DropDownList2.Items.Insert(0, new ListItem("-Select Item Category-", ""));
            DropDownList2.SelectedIndex = 0;
            DropDownList3.Items.Insert(0, new ListItem("-Select Model-", ""));
            DropDownList3.SelectedIndex = 0;
            DropDowncolor.Items.Insert(0, new ListItem("-Select Color-", ""));
            DropDowncolor.SelectedIndex = 0;
            bindGrid();


        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = DropDownList2.SelectedValue;
            string selectedText = DropDownList2.SelectedItem.Text;
            // For example, display the selected value in a label
            //label2.Text = "You selected: " + selectedText + " (Value: " + selectedValue + ")";
        }

        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = DropDownList3.SelectedValue;
            string selectedText = DropDownList3.SelectedItem.Text;
            // For example, display the selected value in a label
            //label3.Text = "You selected: " + selectedText + " (Value: " + selectedValue + ")";
        }

        protected void DropDowncolor_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = DropDowncolor.SelectedValue;
            string selectedText = DropDowncolor.SelectedItem.Text;
            // For example, display the selected value in a label
            //label4.Text = "You selected: " + selectedText + " (Value: " + selectedValue + ")";
        }
        protected void CustomCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CustomDelete")
            {
                int rowIndex = int.Parse((string)e.CommandArgument);
                Label lblid = (Label)GridView.Rows[rowIndex].FindControl("griditemCode");
                SqlCommand cmd;
                cmd = new SqlCommand("SP_tblitem", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "delete");
                cmd.Parameters.AddWithValue("@itemcode", lblid.Text);
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
        public void bindGrid()
        {
            con.Open();
            SqlCommand cmd;
            cmd = new SqlCommand("SP_tblitem", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "get");
            cmd.Parameters.AddWithValue("@unitcod", DropDownList1.SelectedValue);
            var da = new SqlDataAdapter(cmd);
            var ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0)
            {
                GridView.DataSource = ds.Tables[0];
                GridView.DataBind();
            }
            con.Close();
            GridView.Columns[3].Visible = false;
            GridView.Columns[6].Visible = false;
            GridView.Columns[12].Visible = false;
            GridView.Columns[2].Visible = false;
        }

        protected void submitbtn_Click(object sender, EventArgs e)
        {
            try
            {
                string unitcode = DropDownList1.SelectedValue;
                if (unitcode == "")
                {
                    string script1 = "toastr.warning('Please select Unit Code first!', '', { closeButton: true, timeOut: 3000 });";
                    ClientScript.RegisterStartupScript(this.GetType(), "showToast", script1, true);
                }
                else
                {
                    string categcode = DropDownList2.SelectedValue;
                    string modelcode = DropDownList3.SelectedValue;
                    string colorcode = DropDowncolor.SelectedValue;
                    string mesaureunit = DropDownmeasure.SelectedValue;
                    string unitmeasure = dropdownum.SelectedValue;
                    string itemname = txtitemname.Text;
                    string qty = txtqty.Text;
                    string length = txtlegnth.Text;
                    string breadth = txtbreadth.Text;
                    string height = txtheight.Text;
                    string boxqty = txtboxqty.Text;
                    string boxmssg = txtboxmssg.Text;
                    //if (string.IsNullOrEmpty(name))
                    //{
                    //    ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Department can not be empty')", true);
                    //    txtdepartment.Focus();
                    //    return;
                    //}
                    //if (!string.IsNullOrEmpty(salary))
                    //{
                    //    empsalary = Convert.ToDouble(txtsalary.Text);
                    //}
                    if (!string.IsNullOrEmpty(itemname))
                    {
                        itemname = itemname.Trim();
                    }
                    if (!string.IsNullOrEmpty(boxmssg))
                    {
                        boxmssg = boxmssg.Trim();
                    }

                    //string query = string.Empty;
                    //query = string.Format(@"UPDATE tbLemp SET Name={1},Department={2},Designation={3},
                    //Salary={4},DOJ={5} WHERE Empcode={0}", empcode, name, depart, desgi, empsalary, date);

                    //query = string.Format(@"INSERT INTO tbLemp(Empcode,Name,Department,Designation,
                    //Salary,DOJ) VALUES('{0}','{1}','{2}','{3}','{4}','{5}')", empcode, name, depart, desgi, empsalary, date);
                    //SqlCommand cmd = new SqlCommand(query, con);
                    SqlCommand cmd = new SqlCommand("SP_tblitem", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@unitcod", unitcode);

                    cmd.Parameters.AddWithValue("@itemcategcode", categcode);

                    cmd.Parameters.AddWithValue("@modelcod", modelcode);

                    cmd.Parameters.AddWithValue("@colorid", colorcode);

                    cmd.Parameters.AddWithValue("@uniqty", qty);
                    cmd.Parameters.AddWithValue("@itemname", itemname);
                    cmd.Parameters.AddWithValue("@lengt", length);
                    cmd.Parameters.AddWithValue("@breadth", breadth);
                    cmd.Parameters.AddWithValue("@height", height);
                    cmd.Parameters.AddWithValue("@boxqty", boxqty);
                    cmd.Parameters.AddWithValue("@itemdescip", boxmssg);
                    cmd.Parameters.AddWithValue("@measunit", mesaureunit);
                    cmd.Parameters.AddWithValue("@unitmeasu", unitmeasure);
                    if (submitbtn.Text == "Update")
                    {
                        //if (string.IsNullOrEmpty(Session["UserID"].ToString()))
                        //{
                        //    cmd.Parameters.AddWithValue("@updatedby", "Notloggedin");
                        //}
                        //else
                        //{
                        //    cmd.Parameters.AddWithValue("@updatedby", Session["UserID"].ToString());
                        //}
                        cmd.Parameters.AddWithValue("@updatedby", Session["UserID"].ToString());
                        cmd.Parameters.AddWithValue("@itemcode", iddetail.Text);


                        cmd.Parameters.AddWithValue("@updateddate", DateTime.Now.ToString("yyyy-MM-dd"));
                        cmd.Parameters.AddWithValue("@Mode", "update");

                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@Mode", "save");
                        cmd.Parameters.AddWithValue("@createdby", Session["UserID"].ToString());


                    }
                    con.Open();
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
                        bindGrid();
                    }
                    else if (status == "Updated")
                    {
                        string script1 = "toastr.success('Updated Successfully!', '', { closeButton: true, timeOut: 3000 });";
                        ClientScript.RegisterStartupScript(this.GetType(), "showToast", script1, true);
                        bindGrid();
                    };
                    submitbtn.Text = "Save";
                    a = false;
                    clear_Click(sender, e);
                }
            }
            catch (Exception)
            {

                throw;
            }

        }
        protected void GridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lablemssg.Text = " ";
            Label lblid = (Label)GridView.Rows[e.NewEditIndex].FindControl("griditemCode");
            iddetail.Text = lblid.Text;
            Label lblunitcode = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridunitCode");
            Label lblcategcode = (Label)GridView.Rows[e.NewEditIndex].FindControl("griditemcategory");
            Label lblitemname = (Label)GridView.Rows[e.NewEditIndex].FindControl("griditemname");
            Label lblmodelcode = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridmodelcode");
            Label lbllength = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridlength");
            Label lblbreadth = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridbreadth");
            Label lblheight = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridheight");
            Label lblmeasureunit = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridmeasureunit");
            Label lblcolorcode = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridcolorcode");
            Label lblunitqty = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridunitqty");
            Label lblunitmeasure = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridunitmeasure");
            Label lblboxqty = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridboxqty");
            Label lblitemdescip = (Label)GridView.Rows[e.NewEditIndex].FindControl("griditemdescription");
            txtitemname.Text = lblitemname.Text;
            txtqty.Text = lblunitqty.Text;
            txtlegnth.Text = lbllength.Text;
            txtbreadth.Text = lblbreadth.Text;
            txtheight.Text = lblheight.Text;
            txtboxqty.Text = lblboxqty.Text;
            txtboxmssg.Text = lblitemdescip.Text;
            DropDownList1.ClearSelection();
            DropDownList2.ClearSelection();
            DropDownList3.ClearSelection();
            DropDowncolor.ClearSelection();
            DropDownmeasure.ClearSelection();
            dropdownum.ClearSelection();
            DropDownList1.Items.FindByValue(lblunitcode.Text).Selected = true;
            try
            {
                DropDownList2.Items.FindByValue(lblcategcode.Text).Selected = true;
            }
            catch
            {
                DropDownList2.SelectedIndex = 0;

            }
            try
            {
                DropDownList3.Items.FindByValue(lblmodelcode.Text).Selected = true;
            }
            catch
            {
                DropDownList3.SelectedIndex = 0;
            }
            try
            {
                DropDowncolor.Items.FindByValue(lblcolorcode.Text).Selected = true;
            }
            catch
            {
                DropDowncolor.SelectedIndex = 0;
            }
            try
            {
                DropDownmeasure.Items.FindByValue(lblmeasureunit.Text).Selected = true;
            }
            catch
            {
                DropDownmeasure.SelectedIndex = 0;
            }
            try
            {
                dropdownum.Items.FindByValue(lblunitmeasure.Text).Selected = true;
            }
            catch
            {
                dropdownum.SelectedIndex = 0;
            }
            submitbtn.Text = "Update";
            //clear.Enabled = false;


        }
        protected void gridview_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (aa)
            {

                GridView.PageIndex = e.NewPageIndex;
                bindGrid();
            }
            else
            {

                GridView.PageIndex = e.NewPageIndex;
                search_TextChanged(sender, e);
            }
        }

        void ClearInputs(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is TextBox)
                    ((TextBox)ctrl).Text = string.Empty;
                ClearInputs(ctrl.Controls);
            }
        }
        protected void clear_Click(object sender, EventArgs e)
        {
            if (submitbtn.Text == "Update")
            {
                submitbtn.Text = "Save";
            }
            if (!aa)
            {
                search_TextChanged(sender, e);

            }
            else
            {
                string script = @"toastr.info('Cleared Fields!', 'Info', { closeButton: true, timeOut: 3000 });";
                ClientScript.RegisterStartupScript(this.GetType(), "showToast", script, true);
                if (a)
                {
                    DropDownList1.ClearSelection();
                }
                DropDownList2.ClearSelection();
                DropDownList3.ClearSelection();
                DropDowncolor.ClearSelection();
                DropDownmeasure.ClearSelection();
                dropdownum.ClearSelection();
                bindGrid();
                ClearInputs(Page.Controls);
            }
        }
       

        protected void search_TextChanged(object sender, EventArgs e)
        {
            aa = false;
            con.Open();
            SqlCommand cmd;
            string a = searchid.Text;
            if (!string.IsNullOrEmpty(a))
            {
                a = a.Trim();
            }
            cmd = new SqlCommand("SP_tblitem", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "get");
            cmd.Parameters.AddWithValue("@unitcod", DropDownList1.SelectedValue);
            cmd.Parameters.AddWithValue("@search", a);
            var da = new SqlDataAdapter(cmd);
            var ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0)
            {
                GridView.DataSource = ds.Tables[0];
                GridView.DataBind();
            }
            con.Close();
            aa = false;
            Page_Load(sender, e);


        }
    }
}