using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Label = System.Web.UI.WebControls.Label;


namespace Inventory
{
    public partial class purchaseorders : System.Web.UI.Page
    {
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["myConnectionString"].ConnectionString);


        protected void Page_Load(object sender, EventArgs e)


        {
            btn_UpdateProducts.Visible = false;
            if (!IsPostBack)
            {

                if (!Purchasesorders_tab.Enabled)
                {
                    supplercode();
                    columnadd();
                    itemnamedd();
                    dditemname_SelectedIndexChanged(sender, e);

                }
                else
                {
                    purchaseslist();

                }
            }

            if (!Purchaseslist_tab.Enabled)
            {
                purchaseslist();
            }
        }

        protected void dditemname_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "quantitydd");
                cmd.Parameters.AddWithValue("@Itemid", dditemname.SelectedValue);
                SqlDataReader rdr = cmd.ExecuteReader();

                if (rdr.HasRows)
                {
                    if (rdr.Read())
                    {
                        txtquantity.Text = Convert.ToString(rdr["unitqty"]);
                    }
                }
                con.Close();

            }
            catch (Exception)
            {

                throw;
            }
        }

        public void purchaseslist()
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "getdata");
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataTable DT = new DataTable();
                DA.Fill(DT);
                if (DT.Rows.Count > 0)
                {
                    gridviewpurchaseslist.DataSource = DT;
                    gridviewpurchaseslist.DataBind();

                }

                con.Close();
            }
            catch (Exception)
            {

                throw;
            }
        }

        public void supplercode()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "dropdownlistspcode");
            SqlDataReader dr = cmd.ExecuteReader();
            ddspcode.DataSource = dr;
            ddspcode.DataTextField = "Name";
            ddspcode.DataValueField = "supplierid";
            ddspcode.DataBind();
            //ddspcode.Items.Insert(0, "--Select--");
            ddspcode.Items.Insert(0, new ListItem("--Select--", ""));
            con.Close();
            txtpono.Text = "10002";
        }

        public void itemnamedd()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "itemnamedd");
            SqlDataReader dr = cmd.ExecuteReader();
            dditemname.DataSource = dr;
            dditemname.DataTextField = "itemname";
            dditemname.DataValueField = "Itemid";
            dditemname.DataBind();
            //ddspcode.Items.Insert(0, "--Select--");
            dditemname.Items.Insert(0, new ListItem("--Select--", ""));
            con.Close();
        }

        protected void ddspcode_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_supplier", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Mode", "UserBind");
                cmd.Parameters.AddWithValue("@supper_id", ddspcode.SelectedValue);
                SqlDataReader rdr = cmd.ExecuteReader();

                if (rdr.HasRows)
                {
                    if (rdr.Read())
                    {
                        txtemail.Text = Convert.ToString(rdr["Email"]);
                        txtaddress.Text = Convert.ToString(rdr["Address"]);
                        txtcontactno.Text = Convert.ToString(rdr["mobile"]);
                        txtemail.ReadOnly = true;
                        txtaddress.ReadOnly = true;
                        txtcontactno.ReadOnly = true;
                    }

                }
                con.Close();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btn_clear_Click(object sender, EventArgs e)
        {
            ClearInputs(Page.Controls);
            ddunits.SelectedItem.Text = "---Select---";
            ddunits.SelectedIndex = 0;
            //btn_AddProducts.Text = "Save";
            //btn_AddProducts.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");
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

        public void columnadd()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("Product");
            dt.Columns.Add("itemcode");
            dt.Columns.Add("itemName");
            dt.Columns.Add("quantity");
            dt.Columns.Add("unit");
            dt.Columns.Add("price");
            dt.Columns.Add("discount");
            dt.Columns.Add("tax");
            dt.Columns.Add("AutoID");
            ViewState["Addproducts"] = dt;
            addproductbind();
        }
        public void addproductbind()
        {
            gridaddproducts.DataSource = (DataTable)ViewState["Addproducts"];
            gridaddproducts.DataBind();
        }

        protected void btn_AddProducts_Command(object sender, CommandEventArgs e)
        {


            dditemname.Enabled = true;
            DataTable dt = ViewState["Addproducts"] as DataTable;

            if (dt != null)
            {
                // Check if the selected item already exists in the DataTable
                string itemCode = dditemname.SelectedValue;
                DataRow[] existingRows = dt.Select(" ItemCode = '" + itemCode + "' ");

                if (existingRows.Length > 0) // If item already exists
                {
                    // Show alert message (client-side)
                    //ClientScript.RegisterStartupScript(this.GetType(), "DuplicateItem", "alert('Item already added!');", true);
                    string Deletetoastr = @"toastr.error(' Item already added!! ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", Deletetoastr, true);
                }
                else
                {
                    // Add new item if not already present
                    dt.Rows.Add(txtproductname.Text, itemCode, dditemname.SelectedItem.Text, txtquantity.Text, ddunits.SelectedItem.Text, txtprice.Text, txtdiscount.Text, txttax.Text);
                    ViewState["Addproducts"] = dt;
                    addproductbind();

                    // Clear inputs after adding
                    txtproductname.Text = string.Empty;
                    dditemname.SelectedIndex = 0;
                    txtquantity.Text = string.Empty;
                    ddunits.SelectedIndex = 0;
                    txtprice.Text = string.Empty;
                    txtdiscount.Text = string.Empty;
                    txttax.Text = string.Empty;
                }
            }
        }

        protected void gridaddproducts_RowEditing(object sender, GridViewEditEventArgs e)
        {

            gridaddproducts.EditIndex = e.NewEditIndex;

            DataTable dt = ViewState["Addproducts"] as DataTable;

            if (dt != null)
            {
                dditemname.Enabled = false;
                DataRow dr = dt.NewRow();
                GridViewRow editingRow = gridaddproducts.Rows[e.NewEditIndex];
                //Label lblPono = gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lblPono") as Label;

                //Label po_no = (Label)gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lblPono");
                Label product = (Label)gridaddproducts.Rows[e.NewEditIndex].FindControl("lblproduct");
                Label item = (Label)gridaddproducts.Rows[e.NewEditIndex].FindControl("lblitecode");
                Label quantity = (Label)gridaddproducts.Rows[e.NewEditIndex].FindControl("lblquantity");
                Label unit = (Label)gridaddproducts.Rows[e.NewEditIndex].FindControl("lblunit");
                Label price = (Label)gridaddproducts.Rows[e.NewEditIndex].FindControl("lblprice");
                Label discount = (Label)gridaddproducts.Rows[e.NewEditIndex].FindControl("lbldiscount");
                Label tax = (Label)gridaddproducts.Rows[e.NewEditIndex].FindControl("lbltax");


                if (item.Text != null && !string.IsNullOrEmpty(item.Text))
                {
                    ListItem selectedItem = dditemname.Items.FindByValue(item.Text);
                    if (selectedItem != null)
                    {
                        dditemname.ClearSelection();
                        selectedItem.Selected = true;
                    }
                }

                if (!string.IsNullOrEmpty(unit.Text))
                {
                    string unitText = unit.Text.Trim(); // Remove any extra spaces

                    foreach (ListItem item1 in ddunits.Items)
                    {
                        if (item1.Text.Trim().Equals(unitText, StringComparison.OrdinalIgnoreCase)) // Case-insensitive match
                        {
                            ddunits.ClearSelection();
                            item1.Selected = true;
                            break; // Stop loop once match is found
                        }
                    }
                }

                //txtproductcode.Text = lblPono.Text;
                txtproductname.Text = product.Text;
                txtquantity.Text = quantity.Text;
                //ddunits.Text = unit.Text;
                txtprice.Text = price.Text;
                txtdiscount.Text = discount.Text;
                txttax.Text = tax.Text;

                //dt.Rows.Add(dr);
                //ViewState["Addproducts"] = dt;

                string script = "<script>$(document).ready(function() { $('#exampleModal').modal('show'); setFocus(); });</script>";
                ClientScript.RegisterStartupScript(this.GetType(), "ShowModalScript", script, false);


                gridaddproducts.DataSource = (DataTable)ViewState["Addproducts"];
                gridaddproducts.DataBind();
                btn_UpdateProducts.Visible = true;
                btn_AddProducts.Visible = false;


            }
        }

        protected void gridaddproducts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridaddproducts.PageIndex = e.NewPageIndex;
            addproductbind();

        }

        protected void btn_Save_Click(object sender, EventArgs e)
        {
            try
            {
                getGridInfo();
                DataTable dt = ViewState["Addproducts"] as DataTable;
                if (dt.Columns.Contains("itemname"))
                {
                    dt.Columns.Remove("itemname"); // Remove column
                }
                if (btn_Save.Text == "Save")
                {

                    con.Open();
                    SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@po_date", txtpodate.Text);
                    cmd.Parameters.AddWithValue("@invoice_no", txtivno.Text);
                    cmd.Parameters.AddWithValue("@invoice_date", txtivdate.Text);
                    cmd.Parameters.AddWithValue("@supplier_code", ddspcode.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@contactno", txtcontactno.Text);
                    cmd.Parameters.AddWithValue("@Address", txtaddress.Text);
                    cmd.Parameters.AddWithValue("@Email", txtemail.Text);
                    cmd.Parameters.AddWithValue("@createdby", Session["UserID"].ToString());
                    cmd.Parameters.AddWithValue("@PO_NOAutoID", dt);
                    cmd.Parameters.AddWithValue("@Mode", "insertdata");
                    string response = cmd.ExecuteScalar().ToString();
                    if (response == "successfully insertdata")
                    {

                        txtpodate.Text = "";
                        txtivno.Text = "";
                        txtivdate.Text = "";
                        ddspcode.SelectedItem.Text = "";
                        txtcontactno.Text = "";
                        txtaddress.Text = "";
                        txtemail.Text = "";

                        DataTable DT = new DataTable();
                        gridaddproducts.DataSource = DT;
                        gridaddproducts.DataBind();

                        string successtoastr = "toastr.success(' Insert successfully!! ', 'success', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "toastr", successtoastr, true);

                    }
                    else
                    {

                    }
                    con.Close();
                }
                else
                {
                    con.Open();
                    SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@po_date", txtpodate.Text);
                    cmd.Parameters.AddWithValue("@invoice_no", txtivno.Text);
                    cmd.Parameters.AddWithValue("@invoice_date", txtivdate.Text);
                    cmd.Parameters.AddWithValue("@supplier_code", ddspcode.SelectedItem.Text);
                    cmd.Parameters.AddWithValue("@contactno", txtcontactno.Text);
                    cmd.Parameters.AddWithValue("@Address", txtaddress.Text);
                    cmd.Parameters.AddWithValue("@Email", txtemail.Text);
                    cmd.Parameters.AddWithValue("@updateby", Session["UserID"].ToString());
                    cmd.Parameters.AddWithValue("@PO_NOAutoID", dt);
                    cmd.Parameters.AddWithValue("@createdby", txtpono.Text);
                    cmd.Parameters.AddWithValue("@Mode", "updatedata");

                    string response = cmd.ExecuteScalar().ToString();
                    if (response == "successfully update")
                    {
                        txtpono.Text = "";
                        txtpodate.Text = "";
                        txtivno.Text = "";
                        txtivdate.Text = "";
                        ddspcode.SelectedItem.Text = "";
                        txtcontactno.Text = "";
                        txtaddress.Text = "";
                        txtemail.Text = "";
                        DataTable DT = new DataTable();
                        gridaddproducts.DataSource = DT;
                        ViewState["Addproducts"] = DT;
                        gridaddproducts.DataBind();

                        btn_Save.Text = "Save";
                        btn_Save.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");


                        string successtoastr = "toastr.success(' Insert successfully!! ', 'success', { closebutton: true, timeout: 3000 });";
                        ClientScript.RegisterClientScriptBlock(this.GetType(), "toastr", successtoastr, true);

                    }
                    con.Close();
                    purchaseslist();

                }
            }
            catch (Exception ex)
            {
                string successtoastr = "toastr.success('" + ex.Message.ToString() + "', 'Error', { closebutton: true, timeout: 3000 });";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "toastr", successtoastr, true);
            }
        }
        private void getGridInfo()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Product", typeof(string));
            dt.Columns.Add("itemcode", typeof(string));
            dt.Columns.Add("itemName", typeof(string));
            dt.Columns.Add("quantity", typeof(string));
            dt.Columns.Add("unit", typeof(string));
            dt.Columns.Add("price", typeof(string));
            dt.Columns.Add("discount", typeof(string));
            dt.Columns.Add("tax", typeof(string));

            foreach (GridViewRow row in gridaddproducts.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow) // Only process data rows
                {
                    Label product = row.FindControl("lblproduct") as Label;
                    Label itemcode = row.FindControl("lblitecode") as Label;
                    Label itemName = row.FindControl("lblitecode") as Label;
                    Label quantity = row.FindControl("lblquantity") as Label;
                    Label units = row.FindControl("lblunit") as Label;
                    Label Price = row.FindControl("lblprice") as Label;
                    Label discount = row.FindControl("lbldiscount") as Label;
                    Label tax = row.FindControl("lbltax") as Label;

                    if (product.Text != null && itemcode.Text != null && quantity.Text != null && Price.Text != null && discount.Text != null && tax.Text != null) // Prevents null reference error
                    {
                        DataRow dr = dt.NewRow();
                        dr["Product"] = product.Text.Trim();
                        dr["itemcode"] = itemcode.Text.Trim();
                        dr["itemName"] = itemName.Text.Trim();
                        dr["quantity"] = quantity.Text.Trim();
                        dr["unit"] = units.Text.Trim();
                        dr["price"] = Price.Text.Trim();
                        dr["discount"] = discount.Text.Trim();
                        dr["tax"] = tax.Text.Trim();

                        dt.Rows.Add(dr);
                    }
                }
            }
            ViewState["Addproducts"] = dt;
        }

        protected void gridviewpurchaseslist_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gridviewpurchaseslist.PageIndex = e.NewPageIndex;
            this.purchaseslist();

        }

        public void gridviewbind2()
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Mode", "getdata_childtable");
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataTable DT = new DataTable();
            DA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                gridaddproducts.DataSource = DT;
                gridaddproducts.DataBind();

            }
            con.Close();
        }

        public void setaddproductsgrid(string AutoID)
        {
            try
            {
                columnadd();
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@invoice_no", AutoID);
                cmd.Parameters.AddWithValue("@Mode", "getdata_tblpurchasesOrderDet");
                SqlDataAdapter DA = new SqlDataAdapter(cmd);
                DataTable DT = new DataTable();
                DA.Fill(DT);
                if (DT.Rows.Count > 0)
                {

                    DataTable dt = ViewState["Addproducts"] as DataTable;
                    foreach (DataRow item in DT.Rows)
                    {
                        dt.Rows.Add(item["Product"].ToString(), item["itemcode"].ToString(), item["itemname"].ToString(),
                            item["quantity"].ToString(), item["unit"].ToString(), item["price"].ToString(), item["discount"].ToString(), item["tax"].ToString(), item["AutoID"].ToString());

                    }
                    ViewState["Addproducts"] = dt;
                    gridaddproducts.DataSource = dt;
                    gridaddproducts.DataBind();
                }
                else
                {
                    gridaddproducts.DataSource = null;
                    gridaddproducts.DataBind();
                }
                con.Close();
            }
            catch (Exception)
            {
                throw;
            }
        }

        protected void gridviewpurchaseslist_RowEditing(object sender, GridViewEditEventArgs e)
        {
            try
            {
                Label po_no = (Label)gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lblPono");
                Label po_date = (Label)gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lblPodate");
                Label invoice_no = (Label)gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lblinvoiceno");
                Label invoice_date = (Label)gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lblinvoicedate");
                Label supplier_code = (Label)gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lblsuppliercode");
                Label contactno = (Label)gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lblcontactno");
                Label Addresss = (Label)gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lbladdress");
                Label email = (Label)gridviewpurchaseslist.Rows[e.NewEditIndex].FindControl("lblemail");
                ViewState["PONO"] = po_no.Text;

                txtpono.Text = po_no.Text;
                txtpodate.Text = Convert.ToDateTime(po_date.Text).ToString("yyyy-MM-dd");
                txtivno.Text = invoice_no.Text;
                txtivdate.Text = Convert.ToDateTime(invoice_date.Text).ToString("yyyy-MM-dd");
                ddspcode.SelectedItem.Text = supplier_code.Text;
                txtcontactno.Text = contactno.Text;
                txtaddress.Text = Addresss.Text;
                txtemail.Text = email.Text;
                setaddproductsgrid(po_no.Text);

                string script = "$('#Purchases-orders').tab('show');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "ShowTab", script, true);

                btn_Save.Text = "Update";
                btn_Save.BackColor = System.Drawing.Color.Green;
                Purchasesorders_tab_Click(sender, e);

            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void gridviewpurchaseslist_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Label PO_NO = (Label)gridviewpurchaseslist.Rows[e.RowIndex].FindControl("lblPono");

            con.Open();
            SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@invoice_no", PO_NO.Text);
            cmd.Parameters.AddWithValue("@Mode", "Delete");


            string AutoID = string.Empty;
            if (ViewState["PONO"] != null)
            {
                AutoID = ViewState["PONO"].ToString();
            }
            //string AutoID = string.Empty;

            string respone = cmd.ExecuteScalar().ToString();
            if (respone == "successfully Delete")
            {
                string Deletetoastr = @"toastr.error(' Delete successfully!! ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", Deletetoastr, true);
            }
            con.Close();
            purchaseslist();
            setaddproductsgrid(AutoID);
        }

        protected void txtsearch_TextChanged(object sender, EventArgs e)
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("sp_tbpurchasesOrder", con);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            string a = txtsearch.Text;
            if (!string.IsNullOrEmpty(a))
            {
                a = a.Trim();
            }
            cmd.Parameters.AddWithValue("@createdby", a);
            cmd.Parameters.AddWithValue("@invoice_no", a);
            cmd.Parameters.AddWithValue("@Email", a);
            cmd.Parameters.AddWithValue("@Mode", "Filter");
            SqlDataAdapter DA = new SqlDataAdapter(cmd);
            DataTable DT = new DataTable();
            DA.Fill(DT);
            if (DT.Rows.Count > 0)
            {
                gridviewpurchaseslist.DataSource = DT;
                gridviewpurchaseslist.DataBind();
            }
            con.Close();
        }

        protected void Purchaseslist_tab_Click(object sender, EventArgs e)
        {

            Purchasesorders_tab.Enabled = true;
            Purchaseslist_tab.Enabled = false;
            gridviewpurchaseslist.Visible = true;

            Purchaseslist_tab.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");
            Purchaseslist_tab.ForeColor = System.Drawing.Color.White;
            //Purchasesorders_tab.BackColor = System.Drawing.Color.White;
            //Purchasesorders_tab.ForeColor = System.Drawing.Color.Black;
            Purchasesorders_tab.Style.Add("color", "#000000");
            Purchasesorders_tab.Style.Add("background-color", "#ffffff");
            lblpono.Text = "";
            lblpodate.Text = "";
            lblinvoiceno.Text = "";
            lblinvoicedate.Text = "";
            lblsuppliercode.Text = "";
            lblcontactno.Text = "";
            lbladdress.Text = "";
            lblemail.Text = "";
            txtpono.Visible = false;
            txtpodate.Visible = false;
            txtivno.Visible = false;
            txtivdate.Visible = false;
            ddspcode.Visible = false;
            txtcontactno.Visible = false;
            txtaddress.Visible = false;
            txtemail.Visible = false;
            btn_AddProduct.Visible = false;
            btn_Save.Visible = false;
            gridaddproducts.Visible = false;
            btn_AddProducts.Visible = false;

            txtsearch.Visible = true;

            Page_Load(sender, e);


        }

        protected void Purchasesorders_tab_Click(object sender, EventArgs e)
        {
            lblpono.Text = "PO No:";
            lblpodate.Text = "PO Date:";
            lblinvoiceno.Text = "Invoice No";
            lblinvoicedate.Text = "Invoice Date";
            lblsuppliercode.Text = "Supplier Code";
            lblcontactno.Text = "Contact No";
            lbladdress.Text = "Address";
            lblemail.Text = "Email";
            txtpono.Visible = true;
            txtpodate.Visible = true;
            txtivno.Visible = true;
            txtivdate.Visible = true;
            ddspcode.Visible = true;
            txtcontactno.Visible = true;
            txtaddress.Visible = true;
            txtemail.Visible = true;
            btn_AddProduct.Visible = true;
            btn_Save.Visible = true;
            gridaddproducts.Visible = true;
            btn_AddProducts.Visible = true;


            Purchasesorders_tab.Enabled = false;
            Purchaseslist_tab.Enabled = true;
            gridviewpurchaseslist.Visible = false;
            //Purchasesorders_tab.BackColor = System.Drawing.ColorTranslator.FromHtml("#7539FF");
            //Purchasesorders_tab.ForeColor = System.Drawing.Color.White;
            Purchaseslist_tab.BackColor = System.Drawing.Color.White;
            Purchaseslist_tab.ForeColor = System.Drawing.Color.Black;
            Purchasesorders_tab.Style.Add("color", "#FFFF");
            Purchasesorders_tab.Style.Add("background-color", "#7539FF");
            txtsearch.Visible = false;
            ddspcode_SelectedIndexChanged(sender, e);
            Page_Load(sender, e);


        }

        protected void btn_UpdateProducts_Command(object sender, CommandEventArgs e)
        {

            DataTable dt = ViewState["Addproducts"] as DataTable;

            if (dt != null)
            {
                string itemcode = dditemname.SelectedValue.ToString();
                DataRow[] rows = dt.Select("ItemCode = '" + itemcode + "'");
                if (rows.Length > 0)
                {
                    string Deletetoastr = @"toastr.error(' Item already exists!! ', 'Inconceivable!', { closebutton: true, timeout: 3000 });";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "showToast", Deletetoastr, true);
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Item already exists!');", true);

                    rows[0]["Product"] = txtproductname.Text.ToString();
                    rows[0]["Quantity"] = txtquantity.Text.ToString();
                    rows[0]["unit"] = ddunits.SelectedItem.Text.ToString();
                    rows[0]["price"] = txtprice.Text.ToString();
                    rows[0]["discount"] = txtdiscount.Text.ToString();
                    rows[0]["tax"] = txttax.Text.ToString();

                    ViewState["Addproducts"] = dt;
                }
            }
            addproductbind();
            dditemname.Enabled = true;
            txtproductname.Text = string.Empty;
            dditemname.SelectedIndex = 0;
            txtquantity.Text = string.Empty;
            ddunits.SelectedIndex = 0;
            txtprice.Text = string.Empty;
            txtdiscount.Text = string.Empty;
            txttax.Text = string.Empty;
            btn_AddProducts.Visible = true;
            btn_UpdateProducts.Visible = false;
        }

        protected void gridaddproducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dt = ViewState["Addproducts"] as DataTable;

            if (dt != null && dt.Rows.Count > e.RowIndex)
            {
                dt.Rows.RemoveAt(e.RowIndex); // Remove the row
                ViewState["Addproducts"] = dt; // Update ViewState
                addproductbind();
            }
            else
            {
                Label id = (Label)gridaddproducts.Rows[e.RowIndex].FindControl("lblid");
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_tbpurchasesorder", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@mode", "delete_tblpurchasesorderdet");
                cmd.Parameters.AddWithValue("@AutoID", id.Text);
                string AutoID = string.Empty;
                if (ViewState["pono"] != null)
                {
                    AutoID = ViewState["pono"].ToString();
                }
                //string id = string.Empty;
                string response = cmd.ExecuteScalar().ToString();
                if (response == "successfully delete")
                {
                    string deletetoastr = @"toastr.error(' delete successfully!! ', 'inconceivable!', { closebutton: true, timeout: 3000 });";
                    ClientScript.RegisterClientScriptBlock(this.GetType(), "showtoast", deletetoastr, true);

                }
                con.Close();
                setaddproductsgrid(AutoID);
                addproductbind();

            }
        }
    }
}