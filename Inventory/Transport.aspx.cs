using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Emit;
using System.Web;
using System.Web.DynamicData;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;
using AjaxControlToolkit;
using Label = System.Web.UI.WebControls.Label;

namespace Inventory
{
    public partial class Transport : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Unitcodedropdown();
                gridviewbind();
                columnadd();

            }

        }
        public void Unitcodedropdown()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_transportor", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "ddunitcode");
            SqlDataReader sdr = cmd.ExecuteReader();
            ddunit.DataSource = sdr;
            ddunit.DataTextField = "Unitname";
            ddunit.DataValueField = "Unitcode";
            ddunit.DataBind();
            ddunit.Items.Insert(0, new ListItem("--Select--", "0"));
            con.Close();
        }

        public void gridviewbind()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_transportor", con);
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
                getGridInfo();
                DataTable dt = ViewState["AddVehicel"] as DataTable;
                dt.Columns.Remove("AutoId");
                if (btn_save.Text == "Save")
                {
                    if (ViewState["AddVehicel"] != null)
                    {
                        if (ddunit.SelectedValue == "0")
                        {
                            string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);
                            string scriptstoastr = @"toastr.error(' Enter Unit code... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", scriptstoastr, true);
                            ddunit.Focus();
                            return;
                        }
                        if (string.IsNullOrEmpty(txttransportname.Text))
                        {
                            string scripts = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", scripts, false);
                            string script = @"toastr.error(' Enter Transportor Name... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", script, true);
                            txttransportname.Focus();
                            return;
                        }
                        if (string.IsNullOrEmpty(txttransportPhonenumber.Text))
                        {
                            string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);
                            string scriptstoastr = @"toastr.error(' Enter Transportor Phone Number... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", scriptstoastr, true);
                            txttransportPhonenumber.Focus();
                            return;
                        }
                        if (string.IsNullOrEmpty(txtcontactperson.Text))
                        {
                            string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);
                            string scriptstoastr = @"toastr.error(' Enter Contact Person... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", scriptstoastr, true);
                            txtcontactperson.Focus();
                            return;
                        }
                        if (string.IsNullOrEmpty(txtmobile.Text))
                        {
                            string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);
                            string scriptstoastr = @"toastr.error(' Enter Mobile No... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", scriptstoastr, true);
                            txtmobile.Focus();
                            return;
                        }
                        if (string.IsNullOrEmpty(txtgstno.Text))
                        {
                            string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);
                            string scriptstoastr = @"toastr.error(' Enter GST No... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", scriptstoastr, true);
                            txtgstno.Focus();
                            return;
                        }
                        if (string.IsNullOrEmpty(txtemail.Text))
                        {
                            string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);
                            string scriptstoastr = @"toastr.error(' Enter Email... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", scriptstoastr, true);
                            txtemail.Focus();
                            return;
                        }
                        if (string.IsNullOrEmpty(txtaddress.Text))
                        {
                            string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                            ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);
                            string scriptstoastr = @"toastr.error(' Enter Address... ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", scriptstoastr, true);
                            txtaddress.Focus();
                            return;
                        }

                        con.Open();
                        SqlCommand cmd = new SqlCommand("sp_transportor", con);
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@unicode", Convert.ToString(ddunit.SelectedValue));
                        cmd.Parameters.AddWithValue("@transportor_name", txttransportname.Text);
                        cmd.Parameters.AddWithValue("@transportor_number", txttransportPhonenumber.Text);
                        cmd.Parameters.AddWithValue("@contact_person", txtcontactperson.Text);
                        cmd.Parameters.AddWithValue("@moblie", txtmobile.Text);
                        cmd.Parameters.AddWithValue("@gstno", txtgstno.Text);
                        cmd.Parameters.AddWithValue("@email", txtemail.Text);
                        cmd.Parameters.AddWithValue("@address", txtaddress.Text);
                        cmd.Parameters.AddWithValue("@Trsan", dt);
                        cmd.Parameters.AddWithValue("@createdby", Session["UserID"].ToString());
                        cmd.Parameters.AddWithValue("@Mode", "insertdata");
                        string response = cmd.ExecuteScalar().ToString();
                        if (response == "insert successfully")
                        {
                            ddunit.SelectedIndex = 0;
                            txttransportname.Text = "";
                            txttransportPhonenumber.Text = "";
                            txtcontactperson.Text = "";
                            txtmobile.Text = "";
                            txtgstno.Text = "";
                            txtemail.Text = "";
                            txtaddress.Text = "";

                            string successtoastr = "toastr.success(' Insert successfully!! ', 'success', { closebutton: true, timeout: 3000 });";
                            ClientScript.RegisterClientScriptBlock(this.GetType(), "toastr", successtoastr, true);
                        }
                        con.Close();
                        gridviewbind();
                    }

                }
                else
                {

                    try
                    {

                        if (ViewState["AddVehicel"] != null)
                        {
                            con.Open();
                            SqlCommand cmd = new SqlCommand("sp_transportor", con);
                            cmd.CommandType = System.Data.CommandType.StoredProcedure;
                            cmd.Parameters.AddWithValue("@unicode", Convert.ToString(ddunit.SelectedValue));
                            cmd.Parameters.AddWithValue("@transportor_name", txttransportname.Text);
                            cmd.Parameters.AddWithValue("@transportor_number", txttransportPhonenumber.Text);
                            cmd.Parameters.AddWithValue("@contact_person", txtcontactperson.Text);
                            cmd.Parameters.AddWithValue("@moblie", txtmobile.Text);
                            cmd.Parameters.AddWithValue("@gstno", txtgstno.Text);
                            cmd.Parameters.AddWithValue("@email", txtemail.Text);
                            cmd.Parameters.AddWithValue("@address", txtaddress.Text);
                            cmd.Parameters.AddWithValue("@Trsan", dt);
                            cmd.Parameters.AddWithValue("@updatedby", Session["UserID"].ToString());
                            cmd.Parameters.AddWithValue("@createdby", ViewState["transportorCode"].ToString());
                            cmd.Parameters.AddWithValue("@Mode", "updatedata");
                            string response = cmd.ExecuteScalar().ToString();
                            btn_save.Text = "Save";
                            btn_save.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");
                            if (response == "Successfully updated")
                            {
                                ddunit.SelectedIndex = 0;

                                txttransportname.Text = "";
                                txttransportPhonenumber.Text = "";
                                txtcontactperson.Text = "";
                                txtmobile.Text = "";
                                txtgstno.Text = "";
                                txtemail.Text = "";
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

            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            ClearInputs(Page.Controls);
            ddunit.SelectedIndex = 0;
            btn_save.Text = "Save";
            btn_save.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");

            // Clear the data source
            DataTable dt = new DataTable();
            dt.Columns.Add("Vehicel_types");
            dt.Columns.Add("vehicel_no");
            dt.Columns.Add("AutoId");

            // Assign empty DataTable to ViewState or GridView's data source
            ViewState["AddVehicel"] = dt;

            // Bind the GridView to the empty DataTable
            BindGrid();

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
            try
            {
                Label unitcode = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblunitcode");
                Label transportorCode = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lbltransportcode");
                Label transportorname = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lbltranpname");
                Label transportorphoneno = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lbltranpphoneno");
                Label Contactperson = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblcontactperson");
                Label mobile = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblmobile");
                Label gstno = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblgstno");
                Label email = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblemail");
                Label address = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lbladdress"); ;
                Label id = (Label)gridviewtable.Rows[e.NewEditIndex].FindControl("lblid");
                ViewState["lblid"] = id.Text;
                ViewState["transportorCode"] = transportorCode.Text;

                ddunit.SelectedValue = Convert.ToString(unitcode.Text);
                txttransportname.Text = transportorname.Text;
                txttransportPhonenumber.Text = transportorphoneno.Text;
                txtcontactperson.Text = Contactperson.Text;
                txtmobile.Text = mobile.Text;
                txtgstno.Text = gstno.Text;
                txtemail.Text = email.Text;
                txtaddress.Text = address.Text;
                SetVehicelGrid(transportorCode.Text);
                string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); });</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);

                btn_save.Text = "Update";
                btn_save.BackColor = System.Drawing.Color.Green;

            }
            catch (Exception)
            {

                throw;
            }

        }

        protected void gridviewtable_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label id = (Label)gridviewtable.Rows[e.RowIndex].FindControl("lblidii");
            Label transportid = (Label)gridviewtable.Rows[e.RowIndex].FindControl("lbltransportcode");

            ViewState["lblidii"] = transportid.Text;
         

            con.Open();
            SqlCommand cmd = new SqlCommand("sp_transportor", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@createdby", transportid.Text);
            cmd.Parameters.AddWithValue("@Mode", "Delete");
            string respone = cmd.ExecuteScalar().ToString();
            if (respone == "Successfully Delete")
            {
                string Deletetoastr = @"toastr.error(' Delete successfully!! ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", Deletetoastr, true);
            }
            con.Close();
            gridviewbind();

        }

        protected void gridviewtable_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridviewtable.PageIndex = e.NewPageIndex;
            gridviewbind();
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_transportor", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            string a = txtsearch.Text;
            if (!string.IsNullOrEmpty(a))
            {
                a = a.Trim();
            }
            cmd.Parameters.AddWithValue("@transportor_name", a);
            cmd.Parameters.AddWithValue("@transportor_number", a);
            cmd.Parameters.AddWithValue("@contact_person", a);
            cmd.Parameters.AddWithValue("@moblie", a);
            cmd.Parameters.AddWithValue("@gstno", a);
            cmd.Parameters.AddWithValue("@email", a);
            cmd.Parameters.AddWithValue("@address", a);
            cmd.Parameters.AddWithValue("@Mode", "Filter");
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

        protected void txtsearch_TextChanged(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_transportor", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            string a = txtsearch.Text;
            if (!string.IsNullOrEmpty(a))
            {
                a = a.Trim();
            }
            cmd.Parameters.AddWithValue("@transportor_name", a);
            cmd.Parameters.AddWithValue("@transportor_number", a);
            cmd.Parameters.AddWithValue("@contact_person", a);
            cmd.Parameters.AddWithValue("@moblie", a);
            cmd.Parameters.AddWithValue("@gstno", a);
            cmd.Parameters.AddWithValue("@email", a);
            cmd.Parameters.AddWithValue("@address", a);
            cmd.Parameters.AddWithValue("@vehicel_type", a);
            cmd.Parameters.AddWithValue("@vehicel_number", a);
            cmd.Parameters.AddWithValue("@Mode", "Filter");
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

        public void gridviewbind2()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_addvehicel", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "gatdata");
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataTable DT = new DataTable();
            DA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                gridviewtable2.DataSource = DT;
                gridviewtable2.DataBind();

            }
            con.Close();
        }

        private void SetVehicelGrid(string Id)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_transportor", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "Vehiclebind");
                cmd.Parameters.AddWithValue("@transportor_number", Id);
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataTable DT = new DataTable();
                DA.Fill(DT);
                if (DT.Rows.Count > 0)
                {
                    gridviewtable2.DataSource = DT;
                    gridviewtable2.DataBind();

                }
                else
                {
                    gridviewtable2.DataSource = null;
                    gridviewtable2.DataBind();
                }
                con.Close();
            }
            catch (Exception ex)
            {
                //ex.Message();
            }
        }
        public void columnadd()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Vehicel_types");
            dt.Columns.Add("vehicel_no");
            dt.Columns.Add("AutoId");
            ViewState["AddVehicel"] = dt;
            BindGrid();
        }

        protected void BindGrid()
        {

            DataTable dt = ViewState["AddVehicel"] as DataTable;

            if (dt == null)
            {
                dt = new DataTable();
                dt.Columns.Add("Vehicel_types");
                dt.Columns.Add("vehicel_no");
               
                ViewState["AddVehicel"] = dt;
            }

            // Only add an empty row if there is NO data
            if (dt.Rows.Count == 0)
            {
                dt.Rows.Add("", ""); // Temporary empty row
                gridviewtable2.DataSource = dt;
                gridviewtable2.DataBind();

                // Hide the empty row to prevent it from being visible
                gridviewtable2.Rows[0].Visible = false;
            }
            else
            {
                gridviewtable2.DataSource = dt;
                gridviewtable2.DataBind();
            }

            // Ensure Footer is always visible
            gridviewtable2.ShowFooter = true;
        }

        protected void gridviewtable2_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);

                if (e.CommandName == "Save")
                {
                    DropDownList ddlVehicle = (DropDownList)gridviewtable2.FooterRow.FindControl("ddvehicletypes");
                    TextBox txtVehicleNo = (TextBox)gridviewtable2.FooterRow.FindControl("txtvehicelnos");

                    if (ddlVehicle != null && txtVehicleNo != null)
                    {
                        string vehicleType = ddlVehicle.SelectedItem.Text;
                        string vehicleNo = txtVehicleNo.Text;

                        DataTable dt = ViewState["AddVehicel"] as DataTable;

                        // 🔹 Remove the empty row before adding new data
                        if (dt.Rows.Count > 0 && string.IsNullOrEmpty(dt.Rows[0]["Vehicel_types"].ToString()))
                        {
                            dt.Rows.RemoveAt(0);
                        }

                        // 🔹 Add new data
                        dt.Rows.Add(vehicleType, vehicleNo);
                        ViewState["AddVehicel"] = dt;

                        BindGrid();
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void gridviewtable2_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dt = ViewState["AddVehicel"] as DataTable;

            if (dt != null && dt.Rows.Count > e.RowIndex)  // Ensure row exists
            {
                dt.Rows.RemoveAt(e.RowIndex); // Remove the row
                ViewState["AddVehicel"] = dt; // Update ViewState
                BindGrid(); // Refresh the GridView
            }
            else
            {
                Label transportid = (Label)gridviewtable2.Rows[e.RowIndex].FindControl("lblidii");
                Label lblvehiceltypes = (Label)gridviewtable2.Rows[e.RowIndex].FindControl("lblvehiceltypes");
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_transportor", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "deletevechicle");
                cmd.Parameters.AddWithValue("@id", transportid.Text);
                string idss = string.Empty;
                if (ViewState["transportorCode"] !=null)
                {
                     idss = ViewState["transportorCode"].ToString();
                }
                string id = string.Empty;
                string response = cmd.ExecuteScalar().ToString();
                if (response == "successfully deletevechicle")
                {
                    string Deletetoastr = @"toastr.error(' Delete successfully!! ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", Deletetoastr, true);
                }
                con.Close();
                SetVehicelGrid(idss);
            }
        }

        protected void gridviewtable2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (gridviewtable2.Rows.Count == 0)
            {
                gridviewtable2.ShowFooter = true;
            }
        }

        private void getGridInfo()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Vehicel_types", typeof(string));
            dt.Columns.Add("vehicel_no", typeof(string));
            //dt.Columns.Add("AutoId", typeof(string));

            foreach (GridViewRow row in gridviewtable2.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow) // Only process data rows
                {
                    DropDownList ddlVehicle = row.FindControl("ddvehicletypes") as DropDownList;
                    TextBox txtVehicleNo = row.FindControl("txtvehicelnos") as TextBox;

                    if (ddlVehicle != null && txtVehicleNo != null) // Prevents null reference error
                    {
                        DataRow dr = dt.NewRow();
                        dr["Vehicel_types"] = ddlVehicle.SelectedItem != null ? ddlVehicle.SelectedItem.Text : ""; // Check for selected item
                        dr["vehicel_no"] = txtVehicleNo.Text.Trim();
                        //dr.["AutoId"] = 
                        dt.Rows.Add(dr);
                    }
                }
            }
            Session["AddVehicel"] = dt;
        }
    }
}