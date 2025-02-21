using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.Reflection.Emit;
using System.Security.Cryptography;
using System.Xml.Linq;
using Label = System.Web.UI.WebControls.Label;
using System.Configuration;

namespace Inventory
{
    public partial class unitmaster : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
        bool aa = false;
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
                bindGrid();
            }
            lablemssg.Text = " ";
        }
        public void bindGrid()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_unit", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "Getdata");
            var da = new SqlDataAdapter(cmd);
            var ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0)
            {
                GridView.DataSource = ds.Tables[0];
                GridView.DataBind();
            }
            //SqlDataReader dr = cmd.ExecuteReader().ToList();
            ////SqlCommand look = new SqlCommand("Select empcode,Name,DOJ from tblemp;", con);
            ////SqlDataAdapter sd = new SqlDataAdapter(look);
            ////DataTable dt = new DataTable();
            ////sd.Fill(dt);
            //if (dr.HasRows)
            //{
            //    GridView.DataSource = dr;
            //    GridView.DataBind();
            //}
            con.Close();
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
                searchButton_Click(sender, e);
            }
        }

        protected void CustomCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CustomDelete")
            {
                int rowIndex = int.Parse((string)e.CommandArgument);
                Label lblid = (Label)GridView.Rows[rowIndex].FindControl("gridunitCode");
                int empcode = Convert.ToInt32(lblid.Text);

                SqlCommand cmd = new SqlCommand("sp_unit", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "Delete");
                cmd.Parameters.AddWithValue("@code", empcode);
                con.Open();
                //lablemssg.Text = Convert.ToString(cmd.ExecuteScalar());
                //ClientScript.RegisterStartupScript(this.GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lablemssg.ClientID + "').innerText = ' ';\",2000)</script>");
                string script = @"toastr.error('Deleted!', 'Info', { closeButton: true, timeOut: 3000 });";
                ClientScript.RegisterStartupScript(this.GetType(), "showToast", script, true);
                cmd.ExecuteNonQuery();
                con.Close();
                reset_Click(sender, e);
            }
        }

        protected void GridView_RowEditing(object sender, GridViewEditEventArgs e)
        {
            lablemssg.Text = " ";
            Label lblid = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridunitCode");
            Label lblName = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridunitName");

            Label lbladdress1 = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridadd1");
            Label lbladdress2 = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridadd2");

            Label lblgstin = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridgstno");
            Label lblmobile = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridmobileno");
            Label lblmail = (Label)GridView.Rows[e.NewEditIndex].FindControl("gridemail");
            lblunitcode.Text = "RS" + lblid.Text;
            lblunitname.Text = lblName.Text;
            lblemail.Text = lblmail.Text;
            lblmobileno.Text = lblmobile.Text;
            lblgstno.Text = lblgstin.Text;
            lbladd1.Text = lbladdress1.Text;
            lbladd2.Text = lbladdress2.Text;
            savebtn.Text = "Update";
            //clear.Enabled = false;
            reset_Click(sender, e);

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
            if (savebtn.Text == "Update")
            {
                savebtn.Text = "Save";
            }
            string script = @"toastr.info('Cleared Fields!', 'Info', { closeButton: true, timeOut: 3000 });";
            ClientScript.RegisterStartupScript(this.GetType(), "showToast", script, true);
            ClearInputs(Page.Controls);
        }
        protected void savebtn_Click(object sender, EventArgs e)
        {
            try
            {
                string code = lblunitcode.Text;
                string name = lblunitname.Text;
                string email = lblemail.Text;
                string mobileno = lblmobileno.Text;
                string gstno = lblgstno.Text;
                string add1 = lbladd1.Text;
                string add2 = lbladd2.Text;
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
                if (!string.IsNullOrEmpty(name))
                {
                    name = name.Trim();
                }
                if (!string.IsNullOrEmpty(email))
                {
                    email = email.Trim();
                }
                if (!string.IsNullOrEmpty(mobileno))
                {
                    mobileno = mobileno.Trim();
                }
                if (!string.IsNullOrEmpty(gstno))
                {
                    gstno = gstno.Trim();
                }
                if (!string.IsNullOrEmpty(add1))
                {
                    add1 = add1.Trim();
                }
                if (!string.IsNullOrEmpty(add2))
                {
                    add2 = add2.Trim();
                }
                //string query = string.Empty;
                //query = string.Format(@"UPDATE tbLemp SET Name={1},Department={2},Designation={3},
                //Salary={4},DOJ={5} WHERE Empcode={0}", empcode, name, depart, desgi, empsalary, date);

                //query = string.Format(@"INSERT INTO tbLemp(Empcode,Name,Department,Designation,
                //Salary,DOJ) VALUES('{0}','{1}','{2}','{3}','{4}','{5}')", empcode, name, depart, desgi, empsalary, date);
                //SqlCommand cmd = new SqlCommand(query, con);
                SqlCommand cmd = new SqlCommand("sp_unit", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@utname", name);

                cmd.Parameters.AddWithValue("@utaddress_1", add1);

                cmd.Parameters.AddWithValue("@utaddress_2", add2);

                cmd.Parameters.AddWithValue("@gstno", gstno);

                cmd.Parameters.AddWithValue("@mobileno", mobileno);

                cmd.Parameters.AddWithValue("@emailid", email);
                string script = "";
                if (savebtn.Text == "Update")
                {
                    if (string.IsNullOrEmpty(Session["UserID"].ToString()))
                    {
                        cmd.Parameters.AddWithValue("@updatedby", "Notloggedin");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@updatedby", Session["UserID"].ToString());
                    }
                    code = code.Remove(0, 2);
                    cmd.Parameters.AddWithValue("@code", code);


                    cmd.Parameters.AddWithValue("@updateddate", DateTime.Now.ToString("yyyy-MM-dd"));
                    cmd.Parameters.AddWithValue("@Mode", "Updatedata");
                    script = @"toastr.success('Updated Successfully!', 'Notice', { closeButton: true, timeOut: 3000 });";

                }
                else
                {
                    cmd.Parameters.AddWithValue("@Mode", "insertdata");
                    if (string.IsNullOrEmpty(Session["UserID"].ToString()))
                    {
                        cmd.Parameters.AddWithValue("@createdby", "Notloggedin");
                    }
                    else
                    {
                        cmd.Parameters.AddWithValue("@createdby", Session["UserID"].ToString());
                    }

                    script = @"toastr.success('Saved Successfully!', 'Notice', { closeButton: true, timeOut: 3000 });";

                }

                ClientScript.RegisterStartupScript(this.GetType(), "showToast", script, true);
                con.Open();
                //lablemssg.Text = Convert.ToString(cmd.ExecuteScalar());
                //ClientScript.RegisterStartupScript(this.GetType(), "HideLabel", "<script type=\"text/javascript\">setTimeout(\"document.getElementById('" + lablemssg.ClientID + "').innerText = ' ';\",2000)</script>");
                cmd.ExecuteNonQuery();
                con.Close();
                bindGrid();
                savebtn.Text = "Save";
                clear_Click(sender, e);
            }
            catch (Exception)
            {

                throw;
            }

        }

        protected void savesuccess_Click(object sender, EventArgs e)
        {
            string script = @"t=t||toastr.info('Clear itself?<br /><br /><button type='button' class='btn btn-primary clear'>Yes</button>','Clear Toast Button',{closeButton:!0,timeOut:0,extendedTimeOut:0,tapToDismiss:!1,rtl:o})).find(''.clear').length&&t.delegate('.clear','click',function(){toastr.clear(t,{force:!0}),t=void 0})})";
            ClientScript.RegisterStartupScript(this.GetType(), "showToast", script, true);
        }

        protected void searchButton_Click(object sender, EventArgs e)
        {
            aa = true;
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_unit", con);
            cmd.CommandType = CommandType.StoredProcedure;
            string a = searchBox.Text;
            if (!string.IsNullOrEmpty(a))
            {
                a = a.Trim();
            }
            cmd.Parameters.AddWithValue("@utname", a);
            cmd.Parameters.AddWithValue("@Mode", "Getdataspecific");
            var da = new SqlDataAdapter(cmd);
            var ds = new DataSet();
            da.Fill(ds);

            if (ds.Tables.Count > 0)
            {
                GridView.DataSource = ds.Tables[0];
                GridView.DataBind();
            }
            con.Close();



        }

        protected void reset_Click(object sender, EventArgs e)
        {
            aa = false;
            searchBox.Text = "";
            bindGrid();

        }
    }
}