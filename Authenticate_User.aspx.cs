using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VMS
{
    public partial class Authenticate_User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void loginbtn_Click(object sender, EventArgs e)
        {
            // here create 3 session variable as object and pass on forward for further aplication authentication 

            if (txtUsername.Text == "Admin@vms" && txtPassword.Text == "Fores@123")
            {
                // Set role as admin and redirect to entry screen
                Session["adminrole"] = "Admin";
                Response.Redirect("Entry_Screen.aspx");
            }
             if(txtUsername.Text =="User@vms"&& txtPassword.Text == "Fores@7100")
            {
                Session["UserRole"] = "User";
                Response.Redirect("Entry_Screen.aspx");
            }

        }
    }
}