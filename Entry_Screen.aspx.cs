using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VMS
{
    [Authorize]
    public partial class Entry_Screen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if the user is logged in as Admin
                if (Session["adminrole"] != null && Session["adminrole"].ToString() == "Admin")
                {
                    // Hide the View button
                    centerButton.Visible = false;
                    btnconform.Visible = true;
                    registrationLink.Visible = true;
                    newVisitorLink.Visible = true;
                    employeelink.Visible = true;    
                }

                if (Session["UserRole"] != null && Session["UserRole"].ToString() == "User")
                {
                    // Hide the View button
                    centerButton.Visible = true;
                    btnconform.Visible = false;
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
