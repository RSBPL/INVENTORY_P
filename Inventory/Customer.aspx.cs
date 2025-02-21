using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebSockets;
using System.Xml.Linq;
using Lable = System.Web.UI.WebControls.Label;

namespace Inventory
{
    public partial class Customer : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_unit", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "ddunitcode");
                SqlDataReader dr = cmd.ExecuteReader();
                ddunit.DataSource = dr;
                ddunit.DataTextField = "Unitname";
                ddunit.DataValueField = "Unitcode";
                ddunit.DataBind();
                ddunit.Items.Insert(0, new ListItem("--Select--", ""));
                con.Close();
                gridviewbind();
            }
        }

        public void gridviewbind()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_customers", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "getdata");
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataTable DT = new DataTable();
                DA.Fill(DT);
                if (DT.Rows.Count > 0)
                {
                    gridviewtable.DataSource = DT;
                    gridviewtable.DataBind();
                }
                con.Close();
            }
            catch (Exception)
            {

                throw;
            }

        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            try
            {
                if (btn_save.Text == "Save")
                {
                    if (string.IsNullOrEmpty(txtcustomername.Text))
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", " alert(' Enter Customer Name ')  ", true);
                        txtcustomername.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtcity.Text))
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "alert(' Enter City ') ", true);
                        txtcity.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtaddress.Text))
                    {
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", "alert(' Enter Address ') ", true);
                        txtaddress.Focus();
                        return;
                    }

                    con.Open();
                    SqlCommand cmd = new SqlCommand("sp_customers", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@unitcode", Convert.ToString(ddunit.SelectedValue));
                    cmd.Parameters.AddWithValue("@customername", txtcustomername.Text.Trim());
                    cmd.Parameters.AddWithValue("@country", ddcountry.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@state", ddstate.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@city", txtcity.Text);
                    cmd.Parameters.AddWithValue("@gstno", txtgstno.Text);
                    cmd.Parameters.AddWithValue("@pan", txtpanno.Text);
                    cmd.Parameters.AddWithValue("@contactno", txtcontactno.Text);
                    cmd.Parameters.AddWithValue("@bankno", txtbankAccountNo.Text);
                    cmd.Parameters.AddWithValue("@ifsccode", txtIFSC.Text);
                    cmd.Parameters.AddWithValue("@Address", txtaddress.Text);
                    cmd.Parameters.AddWithValue("@createdby", Session["UserID"].ToString());
                    cmd.Parameters.AddWithValue("@Mode", "insertdata");
                    string response = cmd.ExecuteScalar().ToString();
                    //txtcustomercode.ReadOnly = true;
                    if (response == "successfully insertdata")
                    {
                        ddunit.SelectedIndex = 0;
                        txtcustomername.Text = " ";
                        //txtcustomercode.ReadOnly = true;
                        ddcountry.SelectedIndex = 0;
                        ddstate.SelectedIndex = 0;
                        txtcity.Text = "";
                        txtgstno.Text = "";
                        txtpanno.Text = "";
                        txtcontactno.Text = "";
                        txtbankAccountNo.Text = "";
                        txtIFSC.Text = "";
                        txtaddress.Text = "";

                        string successtoastr = "toastr.success(' Insert successfully!! ', 'success', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "toastr", successtoastr, true);
                    }
                    else
                    {
                        string errortoastr = "toastr.error(' Not Insert data!! ','error',{ closebutton: true , timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "toastr", errortoastr, true);
                    }
                    con.Close();
                    gridviewbind();
                }
                else
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("sp_customers", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@unitcode", Convert.ToString(ddunit.SelectedValue));
                    cmd.Parameters.AddWithValue("@customername", txtcustomername.Text.Trim());
                    cmd.Parameters.AddWithValue("@country", ddcountry.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@state", ddstate.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@city", txtcity.Text);
                    cmd.Parameters.AddWithValue("@gstno", txtgstno.Text);
                    cmd.Parameters.AddWithValue("@pan", txtpanno.Text);
                    cmd.Parameters.AddWithValue("@contactno", txtcontactno.Text);
                    cmd.Parameters.AddWithValue("@bankno", txtbankAccountNo.Text);
                    cmd.Parameters.AddWithValue("@ifsccode", txtIFSC.Text);
                    cmd.Parameters.AddWithValue("@Address", txtaddress.Text);
                    cmd.Parameters.AddWithValue("@id", ViewState["lblid"]);
                    cmd.Parameters.AddWithValue("@updatedby", Session["UserID"].ToString());
                    cmd.Parameters.AddWithValue("@Mode", "update");

                    string response = cmd.ExecuteScalar().ToString();
                    btn_save.Text = "Save";
                    btn_save.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");

                    if (response == "successfully update")
                    {
                        ddunit.SelectedIndex = 0;
                        txtcustomername.Text = " ";
                        //txtcustomercode.ReadOnly = true;
                        ddcountry.SelectedIndex = 0;
                        ddstate.SelectedIndex = 0;
                        txtcity.Text = "";
                        txtgstno.Text = "";
                        txtpanno.Text = "";
                        txtcontactno.Text = "";
                        txtbankAccountNo.Text = "";
                        txtIFSC.Text = "";
                        txtaddress.Text = "";
                        string updatetoastr = @"toastr.success(' updated successfully!! ', 'success', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", updatetoastr, true);
                    }
                    con.Close();
                    gridviewbind();
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            ClearInputs(Page.Controls);
            ddcountry.SelectedItem.Text = "---Select---";
            ddstate.SelectedItem.Text = "---Select---";
            ddunit.SelectedIndex = 0;
            btn_save.Text = "Save";
            btn_save.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");
          
        }

        public void ClearInputs(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is TextBox)
                    ((TextBox)ctrl).Text = String.Empty;
                ClearInputs(ctrl.Controls);

            }
        }

        protected void gridviewtable_RowEditing(object sender, GridViewEditEventArgs e)
        {

            Label unitcode = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblunitcode");
            Label customercode = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblcustomercode");
            Label id = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblid");
            Label customername = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblcustomername");
            Label country = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblcountry");
            Label state = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblstate");
            Label city = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblcity");
            Label gstno = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblgst");
            Label panno = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblpanno");
            Label contactno = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblcontactno");
            Label bankno = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblBankAccountno");
            Label IFSCcode = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblIFSC");
            Label Address = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lbladdress");

            btn_save.Text = "Update";
            btn_save.BackColor = System.Drawing.Color.Green;
            ViewState["lblid"] = id.Text;

            ddunit.SelectedValue = Convert.ToString(unitcode.Text);
            txtcustomercode.Text = customercode.Text;
            txtcustomername.Text = customername.Text;
            ddcountry.SelectedItem.Text = Convert.ToString(country.Text);
            ddstate.SelectedItem.Text = Convert.ToString(state.Text);
            txtcity.Text = city.Text;
            txtgstno.Text = gstno.Text;
            txtpanno.Text = panno.Text;
            txtcontactno.Text = contactno.Text;
            txtbankAccountNo.Text = bankno.Text;
            txtIFSC.Text = IFSCcode.Text;
            txtaddress.Text = Address.Text;


        }

        protected void gridviewtable_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Label id = (Label)gridviewtable.Rows[e.RowIndex].FindControl("lblid");

                ViewState["lblid"] = id.Text;

                con.Open();
                SqlCommand cmd = new SqlCommand("sp_customers", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@id", ViewState["lblid"]);
                cmd.Parameters.AddWithValue("@Mode", "Delete");
                string response = cmd.ExecuteScalar().ToString();
                if (response == "successfully Delete")
                {
                    string Deletetoastr = @"toastr.error(' Delete successfully!! ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", Deletetoastr, true);
                }
                con.Close();
                gridviewbind();

            }
            catch (Exception)
            {

                throw;
            }


        }

        protected void gridviewtable_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridviewtable.PageIndex = e.NewPageIndex;
            gridviewbind();
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_customers", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            string a = txtsearch.Text;
            if (!string.IsNullOrEmpty(a))
            {
                a = a.Trim();
            }
            cmd.Parameters.AddWithValue("@customername", a);
            cmd.Parameters.AddWithValue("@country", a);
            cmd.Parameters.AddWithValue("@city", a);
            cmd.Parameters.AddWithValue("@gstno", a);
            cmd.Parameters.AddWithValue("@pan", a);
            cmd.Parameters.AddWithValue("@contactno", a);
            cmd.Parameters.AddWithValue("@bankno", a);
            cmd.Parameters.AddWithValue("@ifsccode", a);
            cmd.Parameters.AddWithValue("@Address", a);
            cmd.Parameters.AddWithValue("@Mode", "filter");
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataTable DT = new DataTable();
            DA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                gridviewtable.DataSource = DT;
                gridviewtable.DataBind();
            }
            con.Close();
        }
    }
}