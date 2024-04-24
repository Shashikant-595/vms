using Buesiness_Logic_Layer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Mvc;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Presentation_Layer
{
    public partial class Master_User : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Populate the updateuser dropdown during the initial load
                PopulateUserDropdown();
            }

            string action = Request.QueryString["action"];

            if (!string.IsNullOrEmpty(action))
            {
                if (action.Equals("save", StringComparison.OrdinalIgnoreCase))
                { 
                    cmb_updateuser.Visible = false;
                }
                else
                {
                    txtusername.Visible = false; 
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {

            string userType = cmb_UserType.Text;
            string username = txtusername.Text;
            string password = txtpassword.Text;

            master_userBLL bll = new master_userBLL();
            bool isSaved = bll.SaveUser(userType, username, password);

            if (isSaved)
            {
                Console.WriteLine("... Data Save Successfully ....");
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Data Save Successfully');", true);
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "danger('Sumthing ernt wrong please check value');", true);

            }

        }

        private void PopulateUserDropdown()
        {
            master_userBLL bll = new master_userBLL();
            List<string> usernames = bll.GetAllUsernames();

            cmb_updateuser.DataSource = usernames;
            cmb_updateuser.DataBind();
        }

        protected void cmb_updateuser_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
           
        }
    }
}