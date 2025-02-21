using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Reflection.Emit;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Label = System.Web.UI.WebControls.Label;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Inventory
{
    public partial class UserMaster : System.Web.UI.Page
    {

            SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);


        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string a = Convert.ToString(Session["UserID"]);

            }
            catch (Exception)
            {

                Response.Redirect("~/login.aspx");
            }
            if (!IsPostBack)
            {
                gridbinddata();
            }
            lblmassage.Text = " ";

        }

        public void gridbinddata()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_USERMASTER", con);
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@MODE", "GetDate");
                //SqlDataReader rdr = cmd.ExecuteReader();
                DataTable DT = new DataTable();
                DA.Fill(DT);
                if (DT.Rows.Count > 0)
                {
                    GridViewdata.DataSource = DT;
                    GridViewdata.DataBind();
                }

                con.Close();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void txtsave_Click(object sender, EventArgs e)
        {
            try
            {
                

                con.Open();
                SqlCommand cmd = new SqlCommand("SP_USERMASTER", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                if (rbtnISActive.Checked)
                {
                    cmd.Parameters.AddWithValue("@Flag", "Y");
                }
                else if (rbtnISActive.Checked)
                {
                    cmd.Parameters.AddWithValue("@Flag", "Y");
                }
                else
                {
                    cmd.Parameters.AddWithValue("@Flag", "N");
                }
                if (btn_save.Text == "Save")
                {
                    if (string.IsNullOrEmpty(txtusername.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alertify.alert(' Enter User Name ')", true);
                        txtusername.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtfullname.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alertify.alert(' Enter FullName ')", true);
                        txtfullname.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtuserpass.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alertify.alert(' Enter Userpassword ')", true);
                        txtuserpass.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtmobile.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alertify.alert(' Enter Mobile Number ')", true);
                        txtmobile.Focus();
                        return;
                    }
                    if (string.IsNullOrEmpty(txtemail.Text))
                    {
                        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alert", " alertify.alert(' Enter Email ')", true);
                        txtmobile.Focus();
                        return;
                    }
                    cmd.Parameters.AddWithValue("@USERNAME", txtusername.Text);
                    cmd.Parameters.AddWithValue("@FULLNAME", txtfullname.Text);
                    cmd.Parameters.AddWithValue("@USERPASSWORD", txtuserpass.Text);
                    cmd.Parameters.AddWithValue("@MOBILE", txtmobile.Text);
                    cmd.Parameters.AddWithValue("@EMAIL", txtemail.Text);
                    cmd.Parameters.AddWithValue("@CREATEBY", Session["UserID"].ToString());
                    cmd.Parameters.AddWithValue("@MODE", "Save");

                    string response = cmd.ExecuteScalar().ToString();

                    if (response == "Sucessfully inserted")
                    {
                        //lblmassage.Text = " successfull inserted ";
                        //ClientScript.RegisterStartupScript(this.GetType(), "HideLabel", "<script type='text/javascript'>setTimeout('document.getElementById('" + lblmassage.ClientID + "').innerText = ' '; ",2000)</script>");
                        string inserttoastr = @"toastr.success(' Insert successfully!! ', 'success', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", inserttoastr, true);
                        txtusername.Text = "";
                        txtfullname.Text = "";
                        txtuserpass.Text = "";
                        txtmobile.Text = "";
                        txtemail.Text = "";

                    }
                    else
                    {
                        lblmassage.Text = " Not insert data ";
                        
                    }
                }
                else
                {
                    cmd.Parameters.AddWithValue("@USERNAME", txtusername.Text);
                    cmd.Parameters.AddWithValue("@FULLNAME", txtfullname.Text);
                    cmd.Parameters.AddWithValue("@MOBILE", txtmobile.Text);
                    cmd.Parameters.AddWithValue("@EMAIL", txtemail.Text);
                    cmd.Parameters.AddWithValue("@USERID", ViewState["lblid"]);
                    cmd.Parameters.AddWithValue("@UPDATEBY", Session["UserID"].ToString());
                    cmd.Parameters.AddWithValue("@MODE", "update");

                    string response = cmd.ExecuteScalar().ToString();
                    //btn_clear_Click(sender, e);
                    btn_save.Text = "Save";
                    //ClientScript.RegisterStartupScript(this.GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblmassage.ClientID + "').innerText = ' ';\",2000)</script>");

                    if (response == "Sucessfully update")
                    {
                        txtusername.Text = "";
                        txtfullname.Text = "";
                        txtuserpass.Text = "";
                        txtuserpass.Attributes["value"] = null;
                        txtmobile.Text = "";
                        txtemail.Text = "";
                        string updatetoastr = @"toastr.success(' updated successfully!! ', 'success', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", updatetoastr, true);
                    }
                    else
                    {
                        lblmassage.Text = " ";
                    }
                }
                con.Close();
                gridbinddata();
            }
            catch (Exception)
            {

                throw;
            }

        }

        protected void GridViewdata_RowEditing(object sender, GridViewEditEventArgs e)
        {
            try
            {
                con.Open();
                Label lblid = (Label)GridViewdata.Rows[e.NewEditIndex].FindControl("lblid");
                Label Username = (Label)GridViewdata.Rows[e.NewEditIndex].FindControl("lblusername");
                Label Fullname = (Label)GridViewdata.Rows[e.NewEditIndex].FindControl("lblfullname");
                Label Userpassword = (Label)GridViewdata.Rows[e.NewEditIndex].FindControl("lbluserpass");
                Label Mobile = (Label)GridViewdata.Rows[e.NewEditIndex].FindControl("lblmobile");
                Label Email = (Label)GridViewdata.Rows[e.NewEditIndex].FindControl("lblemail");
                Label Active = (Label)GridViewdata.Rows[e.NewEditIndex].FindControl("lblactive");

                ViewState["lblid"] = lblid.Text;
                btn_save.Text = "Update";
                btn_save.BackColor = System.Drawing.Color.Green;

                txtusername.Text = Username.Text;
                txtfullname.Text = Fullname.Text;
                txtuserpass.Attributes["value"] = Convert.ToString(Userpassword.Text);
                txtuserpass.ReadOnly = true;
                txtmobile.Text = Mobile.Text;
                txtemail.Text = Email.Text;

                if(Active.Text == "N")
                {
                    rbtnnotactive.Checked = true;
                    rbtnISActive.Checked = false;
                }
                else
                {
                    rbtnnotactive.Checked = false;
                    rbtnISActive.Checked = true;
                }

                con.Close();
                gridbinddata();
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void GridViewdata_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                Label Userid = (Label)GridViewdata.Rows[e.RowIndex].FindControl("lblid");

                con.Open();
                SqlCommand cmd = new SqlCommand("SP_USERMASTER", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@USERID", Userid.Text);
                //cmd.Parameters.AddWithValue("@username", "");
                //cmd.Parameters.AddWithValue("@fullname", "");
                //cmd.Parameters.AddWithValue("@userpassword", "");
                //cmd.Parameters.AddWithValue("@mobile", "");
                //cmd.Parameters.AddWithValue("@email", "");
                cmd.Parameters.AddWithValue("@MODE", "Delete");

                string response = cmd.ExecuteScalar().ToString();

                if (response == "Sucessfully Delecte")
                {
                    //lblmassage.Text = " Sucessfully Delecte ";
                    //ClientScript.RegisterStartupScript(this.GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblmassage.ClientID + "').innerText = ' ';\",2000)</script>");

                    string Deletetoastr = @"toastr.error(' Delete successfully!! ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", Deletetoastr, true);

                }
                con.Close();
                gridbinddata();

            }
            catch (Exception)
            {

                throw;
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

        protected void btn_clear_Click1(object sender, EventArgs e)
        {
            ClearInputs(Page.Controls);
            btn_save.Text = "Save";
            btn_save.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");
            string toastr = @"toastr.info(' Clear successfully!! ', ' ', { closebutton: true, timeout: 3000 });";
            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", toastr, true);
            txtuserpass.ReadOnly = false;
        }

        protected void GridViewdata_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridViewdata.PageIndex = e.NewPageIndex;
            gridbinddata();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("SP_USERMASTER", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            string a = txtsearch.Text;
            if (!string.IsNullOrEmpty(a))
            {
                a = a.Trim();
            }
            cmd.Parameters.AddWithValue("@USERNAME", a);
            cmd.Parameters.AddWithValue("@MODE", "Filter");
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataTable DT = new DataTable();
            DA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                GridViewdata.DataSource = DT;
                GridViewdata.DataBind();
            }
            con.Close();
        }
    }
}