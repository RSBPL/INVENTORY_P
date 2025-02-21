using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Reflection.Emit;
using System.Data;
using System.Xml.Linq;
using System.CodeDom;

namespace Inventory
{
    public partial class login : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //string a = session["userid"].tostring();
                //response.redirect("~/dashboard.aspx");
            }
            catch (Exception)
            {

            }
        }

        protected void login_Click(object sender, EventArgs e)
        {
            try
            {
                con.Open();

                txtuserpass.Text = "ADMIN@123";
                SqlCommand cmd = new SqlCommand("sp_INV", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@PARANAME", txtUserName.Text);
                cmd.Parameters.AddWithValue("@PARAPASS", txtuserpass.Text);
                cmd.Parameters.AddWithValue("@Mode", "PARALOGIN");
                Session["UserID"] = Convert.ToString(txtUserName.Text);

                string response = cmd.ExecuteScalar().ToString();
                //cmd.ExecuteNonQuery();

                //ClientScript.RegisterStartupScript(this.GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lblMEssage.ClientID + "').innerText = ' ';\",2000)</script>");
                if (response == "OK")
                {
                    string inserttoastr = @"toastr.success(' login successfully... ', 'success', { closebutton: true, timeout: 3000 });";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", inserttoastr, true);
                    Response.Redirect("~/dashboard.aspx");

                }
                else if (response == "Invalid User Id and Password")
                {
                    SqlCommand cmd1 = new SqlCommand("SP_USERMASTER", con);
                    cmd1.CommandType = System.Data.CommandType.StoredProcedure;
                    cmd1.Parameters.AddWithValue("@USERNAME", txtUserName.Text);
                    cmd1.Parameters.AddWithValue("@USERPASSWORD", txtuserpass.Text);
                    cmd1.Parameters.AddWithValue("@MODE", "userlogin");

                    response = cmd1.ExecuteScalar().ToString();
                    if (response == "OK")
                    {
                        string inserttoastr = @"toastr.success(' login successfully... ', 'success', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", inserttoastr, true);
                        Response.Redirect("~/dashboard.aspx");
                        
                    }
                    else
                    {
                        //lblMEssage.Text = "Invalid User Id and Password";
                        string Deletetoastr = @"toastr.error(' Invalid User Id and Password... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", Deletetoastr, true);
                    }
                }
                else
                {
                    //lblMEssage.Text = "Invalid User Id and Password";
                    string Deletetoastr = @"toastr.error(' Invalid User Id and Password.... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", Deletetoastr, true);
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