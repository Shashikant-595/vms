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
    
    public partial class Employee_Signup : System.Web.UI.Page
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

        protected void btn_save_Click(object sender, EventArgs e)
        {
            ListItem selectedItem = usertype.SelectedItem;
            string itemText = selectedItem.Text;
            //string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";
            string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";
            System.Diagnostics.Trace.WriteLine($" connection done ; ");
            SqlConnection connection = new SqlConnection(connectionString);
            string query = "INSERT INTO Employ_Registration (Name, Mobile_No, Email, Department,password,user_type) VALUES (@Name, @Mobil_No, @Email, @Department,@password,@user_type)";
            try
            {
                connection.Open();
                SqlCommand command = new SqlCommand(query, connection);
                command.Parameters.AddWithValue("@Name", txteName.Text);
                command.Parameters.AddWithValue("@Mobil_No", txteMbNo.Text);
                command.Parameters.AddWithValue("@Email", txteemail.Text);
                command.Parameters.AddWithValue("@Department", txteDepartment.Text);
                command.Parameters.AddWithValue("@password", txtpassword.Text);
                command.Parameters.AddWithValue("@user_type", itemText);
                System.Diagnostics.Trace.WriteLine($" usertype is  ; "+ usertype.SelectedItem);
                command.ExecuteNonQuery();
                connection.Close();
                
                Response.Redirect("Registration.aspx");
                System.Diagnostics.Trace.WriteLine($" Data is send ; ");
                string alertMessage = "alert('Employee registered ');";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", alertMessage, true);



            }
            catch (Exception ex)
            {
                // Handle any exceptions here, such as logging or displaying an error message
                // Example:
                Response.Write("An error occurred: " + ex.Message);
                System.Diagnostics.Trace.WriteLine($" No record found; {ex.Message}");



            }
        }

        
    }
}