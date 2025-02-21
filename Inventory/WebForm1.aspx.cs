using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Inventory
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                columnadd();
            }
        }

        protected void gridviewT_PreRender(object sender, EventArgs e)
        {
            if (gridviewT.Rows.Count == 0)
            {
                gridviewT.ShowFooter = true;
            }
        }

        public void columnadd()
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("Vehicel_types");
            dt.Columns.Add("vehicel_no");
            ViewState["AddVehicel"] = dt;
            bind();
        }

        public void bind()
        {
            DataTable dt = ViewState["AddVehicel"] as DataTable;

            if (dt == null)
            {
                dt = new DataTable();
                dt.Columns.Add("Vehicel_types");
                dt.Columns.Add("vehicel_no");
                ViewState["AddVehicel"] = dt;
            }

            // 🔹 Only add an empty row if there is NO data
            if (dt.Rows.Count == 0)
            {
                dt.Rows.Add("", ""); // Temporary empty row
                gridviewT.DataSource = dt;
                gridviewT.DataBind();

                // ✅ Hide the empty row to prevent it from being visible
                gridviewT.Rows[0].Visible = false;
            }
            else
            {
                gridviewT.DataSource = dt;
                gridviewT.DataBind();
            }

            // ✅ Ensure Footer is always visible
            gridviewT.ShowFooter = true;
        }



        protected void gridviewT_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Save")
            {
                DropDownList ddlVehicle = (DropDownList)gridviewT.FooterRow.FindControl("ddvehicletypes");
                TextBox txtVehicleNo = (TextBox)gridviewT.FooterRow.FindControl("txtvehicelnos");

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

                    bind(); // Refresh GridView
                }
            }
        }

        protected void gridviewT_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            DataTable dt = ViewState["AddVehicel"] as DataTable;

            if (dt != null && dt.Rows.Count > e.RowIndex)
            {
                dt.Rows.RemoveAt(e.RowIndex);
                ViewState["AddVehicel"] = dt;
                bind();
            }
        }

    

    }
}