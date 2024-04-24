using Buesiness_Logic_Layer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Presentation_Layer
{
    public partial class Master_Users : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Perform initial data binding when the page loads
                BindGrid();
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

            BusinessLogicLayerMasterUsers bll = new BusinessLogicLayerMasterUsers();
            bll.SaveUser(userType, username, password);

            // Optionally, you can reload the data or perform other actions after saving.
            BindGrid(); // Assuming you have a method to bind data to a GridView or similar control.
        }
        protected void BindGrid()
        {
            // Call your business logic layer to get data
            BusinessLogicLayerMasterUsers bll = new BusinessLogicLayerMasterUsers();
            var data = bll.GetUsers(); // Assuming you have a method to retrieve user data

            // Bind the data to the GridView
            GridView1.DataSource = data;
            GridView1.DataBind();
        }
    }
}