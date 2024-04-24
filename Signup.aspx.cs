using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VMS
{
    [Authorize]
    public partial class Signup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the user is logged in as Admin
            if (Session["adminrole"] != null && Session["adminrole"].ToString() == "Admin")
            {

            }
            else
            {
                Response.Redirect("Authenticate_User.aspx");
            }
        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
           // string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";
               string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

        SqlConnection connection = new SqlConnection(connectionString);
            string query = "INSERT INTO Visitor_Registration (Name, Mobile_No, Email, Company) VALUES (@Name, @Mobil_No, @Email, @Company)";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Name", txtName.Text);
                command.Parameters.AddWithValue("@Mobil_No", txtMbNo.Text);
                command.Parameters.AddWithValue("@Email", txtemail.Text);
                command.Parameters.AddWithValue("@Company", txtcompany.Text);

                command.ExecuteNonQuery();
                connection.Close();
                
                Response.Redirect("Registration.aspx");


            }
            catch (Exception ex)
            {
                // Handle any exceptions here, such as logging or displaying an error message
                // Example:
                Response.Write("An error occurred: " + ex.Message);
            }
        }
    }
}