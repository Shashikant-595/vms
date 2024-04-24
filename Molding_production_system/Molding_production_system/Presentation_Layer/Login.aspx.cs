using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Buesiness_Logic_Layer;

namespace Presentation_Layer
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginbtn_Click(object sender, EventArgs e)
        {

            string username = txtUsername.Text;
            string password = txtPassword.Text;

            LoginBLL loginBLL = new LoginBLL();
            String category = loginBLL.ValidateUser(username, password);
            if (category != null)
            {
                if (category == "Admin")
                { 
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Admin login Successfully');", true);
                }
                else if (category == "User")
                { 
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('User login Successfully');", true);
                }
                else if (category == "Supervisor")
                { 
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Supervisor login Successfully');", true);

                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Status not Asign');", true);

                } 
            }
            else {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Sumting Went Wrong in Username & Password');", true);
            }


        }
    }
}