using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;
using ZXing.Aztec.Internal;

namespace VMS
{
   
    public partial class Signup : System.Web.UI.Page
    {
        string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";
        //    string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btn_edit.Visible = false; // Hide the "Edit" button on initial page load
            }

            // Check if the user is logged in as Admin
            if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "SupperAdmin")
                {
                System.Diagnostics.Trace.WriteLine($"sign up loads");
                }
                else if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "Admin")
                {
                    employeelink.Visible = false;
                }
                else
                {
                System.Diagnostics.Trace.WriteLine($"sign up else  loads");

                Response.Redirect("Authenticate_User.aspx");
                }
            
        }
        protected void btn_submit_Click(object sender, EventArgs e)
        {
           // string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";
           //    string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

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

        protected void btn_edit_Click(object sender, EventArgs e)
        {
            string mobileNo = txtMbNo.Text.Trim();
            if (!string.IsNullOrEmpty(mobileNo))
            {
                if (IsMobileNoExists(mobileNo))
                {
                    string query = "UPDATE Visitor_Registration SET ";
                    List<string> fieldsToUpdate = new List<string>();
                    if (!string.IsNullOrEmpty(txtName.Text))
                    {
                        fieldsToUpdate.Add("Name = @Name");
                    }
                    if (!string.IsNullOrEmpty(txtemail.Text))
                    {
                        fieldsToUpdate.Add("Email = @Email");
                    }
                    if (!string.IsNullOrEmpty(txtcompany.Text))
                    {
                        fieldsToUpdate.Add("Company = @Company");
                    }
                    if (fieldsToUpdate.Count > 0)
                    {
                        query += string.Join(", ", fieldsToUpdate);
                        query += " WHERE Mobile_No = @MobileNo";
                        using (SqlConnection connection = new SqlConnection(connectionString))
                        {
                            SqlCommand command = new SqlCommand(query, connection);
                            if (!string.IsNullOrEmpty(txtName.Text))
                            {
                                command.Parameters.AddWithValue("@Name", txtName.Text);
                            }
                            if (!string.IsNullOrEmpty(txtemail.Text))
                            {
                                command.Parameters.AddWithValue("@Email", txtemail.Text);
                            }
                            if (!string.IsNullOrEmpty(txtcompany.Text))
                            {
                                command.Parameters.AddWithValue("@Company", txtcompany.Text);
                            }
                            command.Parameters.AddWithValue("@MobileNo", mobileNo);
                            connection.Open();
                            int rowsAffected = command.ExecuteNonQuery();
                            if (rowsAffected > 0)
                            {
                                // Handle if update successful
                                Response.Redirect("Registration.aspx");
                            }
                            else
                            {
                                // Handle if update failed
                                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Failed to update Visitor details.');", true);
                            }
                        }
                    }
                    else
                    {
                        // Handle if no field is updated
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('No field is updated.');", true);
                    }
                }
                else
                {
                    // Handle if mobile number not exists
                    ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Mobile number does not exist.');", true);
                }
            }

        }
        private bool IsMobileNoExists(string mobileNo)
        {
            bool result = false;
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string query = "SELECT COUNT(*) FROM Visitor_Registration WHERE Mobile_No = @MobileNo";
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@MobileNo", mobileNo);

                    connection.Open();
                    int count = (int)command.ExecuteScalar();
                    result = count > 0;
                }
            }
            catch (Exception ex)
            {
                // Handle any exceptions here, such as logging or displaying an error message
                // Example:
                Response.Write("An error occurred: " + ex.Message);
            }
            return result;
        }

        protected void txtMbNo_TextChanged(object sender, EventArgs e)
        {
            string mobileNo = txtMbNo.Text.Trim();
            if (!string.IsNullOrEmpty(mobileNo))
            {
                if (IsMobileNoExists(mobileNo))
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Mobile number is already registered. Please edit if needed.');", true);
                    btn_edit.Visible = true;
                    btn_submit.Visible = false;
                }
                else
                {
                    btn_edit.Visible = false;
                }
            }
        }
    }
}