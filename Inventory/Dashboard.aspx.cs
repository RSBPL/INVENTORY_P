﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Inventory
{
    public partial class Dashboard : System.Web.UI.Page
    {
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
        }
    }
}