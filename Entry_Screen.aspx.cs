using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VMS
{
    
    public partial class Entry_Screen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                System.Diagnostics.Trace.WriteLine($"gvfadcdfffffffffffff  " + Session["User_type"]);

                if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "SupperAdmin")
                {
                    System.Diagnostics.Trace.WriteLine($"gvfadcdfffffffffffff  "+Session["User_type"]);

                    // HR and IT head 
                    scanQrLink.Visible = true;
                    confirmLink.Visible = true;
                    registrationLink.Visible = true;
                    newVisitorLink.Visible = true;
                    employeelink.Visible = true;
                }
                if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "Admin")
                {
                    // only invote to visitors
                    scanQrLink.Visible = false;
                    confirmLink.Visible = true;
                    registrationLink.Visible= true;
                    newVisitorLink.Visible = true;
                    employeelink.Visible= false;
                }
                if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "User")
                {
                    // Hide the View button
                    scanQrLink.Visible = true;
                    confirmLink.Visible = false;
                    registrationLink.Style["display"] = "none";
                    newVisitorLink.Style["display"] = "none";
                    employeelink.Style["display"] = "none";
                }
            }
        }

        protected void centerButton_Click(object sender, EventArgs e)
        {

        }

        protected void btnconform_Click(object sender, EventArgs e)
        {

        }

        protected void centerButton_Click1(object sender, EventArgs e)
        {

        }
    }
    }
