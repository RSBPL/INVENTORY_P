using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.EnterpriseServices;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Label = System.Web.UI.WebControls.Label;

namespace Inventory
{

    public partial class supplier : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
        
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    gridviewbind();
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        public void gridviewbind()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_supplier", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "getdata");
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataTable DT = new DataTable();
                DA.Fill(DT);
                if (DT.Rows.Count > 0)
                {
                    gridviewdata.DataSource = DT;
                    gridviewdata.DataBind();
                }
                con.Close();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void txt_save_Click(object sender, EventArgs e)
        {

            try
            {
                if(btn_save.Text == "Save")
                {
                    string suppliercode = txtsuppliercode.Text;
                    string name = txtname.Text;
                    string mobile = txtmobile.Text;
                    string address = txtaddress.Text;
                    string email = txtemail.Text;
                    string gst = txtgstno.Text;

                    if (string.IsNullOrEmpty(txtsuppliercode.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alert(' Enter SupplierCode ')", true);
                        txtsuppliercode.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtname.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alert(' Enter Name ')", true);
                        txtname.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtaddress.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alert(' Enter Address ')", true);
                        txtaddress.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtemail.Text))
                    {

                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alert(' Enter Email ')", true);
                        txtemail.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtmobile.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alert(' Enter Mobile ')", true);
                        txtmobile.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtgstno.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alert(' Enter GST Number ')", true);
                        txtgstno.Focus();
                        return;
                    }

                    con.Open();
                    SqlCommand cmd = new SqlCommand("sp_supplier", con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@supper_code",suppliercode);
                    cmd.Parameters.AddWithValue("@name", name);
                    cmd.Parameters.AddWithValue("@email", email);
                    cmd.Parameters.AddWithValue("@mobile", mobile);
                    cmd.Parameters.AddWithValue("@address", address);
                    cmd.Parameters.AddWithValue("@gst", gst);
                    cmd.Parameters.AddWithValue("@createdby", Session["UserID"].ToString());
                    cmd.Parameters.AddWithValue("@Mode", "insertdata");

                    string response = cmd.ExecuteScalar().ToString();

                    if (response == "Successfully inserted")
                    {
                        txtsuppliercode.Text = "";
                        txtname.Text = "";
                        txtemail.Text = "";
                        txtmobile.Text = "";
                        txtaddress.Text = "";
                        txtgstno.Text = "";

                        string successtoastr = "toastr.success(' Insert successfully!! ', 'success', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "toastr", successtoastr, true);
                    }
                    else
                    {
                        string Notsuccesstoastr = "toastr.error(' Not Insert data ', 'success', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "toastr", Notsuccesstoastr, true);
                    }

                    con.Close();
                    gridviewbind();
                }
                else
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("sp_supplier",con);
                    cmd.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@supper_code",txtsuppliercode.Text);
                    cmd.Parameters.AddWithValue("@name", txtname.Text);
                    cmd.Parameters.AddWithValue("@email", txtemail.Text);
                    cmd.Parameters.AddWithValue("@mobile",txtmobile.Text);
                    cmd.Parameters.AddWithValue("@address", txtaddress.Text);
                    cmd.Parameters.AddWithValue("@gst", txtgstno.Text);
                    cmd.Parameters.AddWithValue("@supper_id", ViewState["lblid"]);
                    cmd.Parameters.AddWithValue("@updatedby", Session["UserID"].ToString());
                    cmd.Parameters.AddWithValue("@Mode", "updatedata");

                    string response = cmd.ExecuteScalar().ToString();
                    btn_save.Text = "Save";
                    btn_save.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");

                    if (response == "update successfully")
                    {
                        txtsuppliercode.Text = "";
                        txtname.Text = "";
                        txtmobile.Text = "";
                        txtaddress.Text = "";
                        txtemail.Text = "";
                        txtgstno.Text = "";
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

        protected void txt_clear_Click(object sender, EventArgs e)
        {
            ClearIputs(Page.Controls);
            btn_save.Text = "Save";
            btn_save.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");
            string toastr = @"toastr.info(' Clear successfully!! ', ' ', { closebutton: true, timeout: 3000 });";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", toastr, true);
        }

        public void ClearIputs(ControlCollection ctrls)
        {
            foreach (Control ctrl in ctrls)
            {
                if (ctrl is TextBox)
                    ((TextBox)ctrl).Text = String.Empty;
                ClearIputs(ctrl.Controls);

            }
        }

        protected void gridviewdata_RowEditing(object sender, GridViewEditEventArgs e)
        {
            Label supplierid = (Label)gridviewdata.Rows[e.NewEditIndex].FindControl("lblid");
            Label suppliercode = (Label)gridviewdata.Rows[e.NewEditIndex].FindControl("lblsuppliercode");
            Label suppliername = (Label)gridviewdata.Rows[e.NewEditIndex].FindControl("lblname");
            Label supplieremail = (Label)gridviewdata.Rows[e.NewEditIndex].FindControl("lblemail");
            Label suppliermobile = (Label)gridviewdata.Rows[e.NewEditIndex].FindControl("lblmobile");
            Label supplieraddress = (Label)gridviewdata.Rows[e.NewEditIndex].FindControl("lbladdress");
            Label suppliergst = (Label)gridviewdata.Rows[e.NewEditIndex].FindControl("lblgst");

            ViewState["lblid"] = supplierid.Text;
            btn_save.Text = "Update";
            btn_save.BackColor = System.Drawing.Color.Green;

            txtsuppliercode.Text = suppliercode.Text;
            txtname.Text = suppliername.Text;
            txtemail.Text = supplieremail.Text;
            txtmobile.Text = suppliermobile.Text;
            txtaddress.Text = supplieraddress.Text;
            txtgstno.Text = suppliergst.Text;
        }

        protected void gridviewdata_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Label supplierID = (Label)gridviewdata.Rows[e.RowIndex].FindControl("lblid");

                ViewState["lblid"] = supplierID.Text;

                con.Open();
                SqlCommand cmd = new SqlCommand("sp_supplier", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@supper_id", ViewState["lblid"]);
                cmd.Parameters.AddWithValue("@Mode", "delete");
                string response = cmd.ExecuteScalar().ToString();
                if( response == "delete successfully")
                {
                    string Deletetoastr = @"toastr.error(' Delete successfully!! ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "toastr", Deletetoastr, true);
                }
                con.Close();
                gridviewbind();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void gridviewdata_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridviewdata.PageIndex = e.NewPageIndex;
            gridviewbind();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_supplier", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                string a = txtsearch.Text;
                if (string.IsNullOrEmpty(a))
                {
                    a = a.Trim();
                }
                if (int.TryParse(a,out _)){
                    cmd.Parameters.AddWithValue("@supper_code", a);
                }
                cmd.Parameters.AddWithValue("@name", a);
                cmd.Parameters.AddWithValue("@email", a);
                cmd.Parameters.AddWithValue("@mobile", a);
                cmd.Parameters.AddWithValue("@address", a);
                cmd.Parameters.AddWithValue("@gst", a);
                cmd.Parameters.AddWithValue("@Mode", "Filter");
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataTable DT = new DataTable();
                DA.Fill(DT);
                if (DT.Rows.Count > 0)
                {
                    gridviewdata.DataSource = DT;
                    gridviewdata.DataBind();
                }
                con.Close();
            }
            catch (Exception)
            {

                throw;
            }

        }
    }
}