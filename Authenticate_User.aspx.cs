using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VMS
{
    public partial class Authenticate_User : System.Web.UI.Page
    {
        string connectionString = "Data Source=DESKTOP-4TNUEJA\\MSSQLSERVER02;Initial Catalog=vms;Integrated Security=True;";
        //string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void loginbtn_Click(object sender, EventArgs e)
        {
            string userid = txtUsername.Text;
            string password = txtPassword.Text;

            string query = "select password, user_type, Name, Email from Employ_Registration WHERE Employee_Id = @Employ_Id";

            // here create 3 session variable as object and pass on forward for further application authentication 
            try
            {
                SqlConnection con = new SqlConnection(connectionString);
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    System.Diagnostics.Trace.WriteLine($"Employee_Id for query: " + userid);
                    cmd.Parameters.AddWithValue("@Employ_Id", userid);
                    con.Open();
                    System.Diagnostics.Trace.WriteLine("Query executed.");

                    // Executing query
                    SqlDataReader reader = cmd.ExecuteReader();
                    System.Diagnostics.Trace.WriteLine("Query executed.");

                    if (reader.Read())
                    {
                        string userpass = reader["password"].ToString();
                        string userlogintype = reader["user_type"].ToString();
                        string employeeName = reader["Name"].ToString();
                        string email = reader["Email"].ToString();
                        System.Diagnostics.Trace.WriteLine("Password from DB: " + userpass);
                        System.Diagnostics.Trace.WriteLine("User type from DB: " + userlogintype);

                        if (password.Trim() == userpass.Trim())
                        {
                            System.Diagnostics.Trace.WriteLine("Password match, proceeding.");
                            // pass session 3 variables 
                            Session["User_id"] = userid;
                            Session["User_type"] = userlogintype;
                            Session["password"] = password;
                            Session["name"] = employeeName;
                            Session["passmail"] = email;
                            Response.Redirect("Entry_Screen.aspx");
                            System.Diagnostics.Trace.WriteLine("All parameters are passed.");

                        }
                        else
                        {
                            lblMessage.Text = "Invalid username or password!";
                            System.Diagnostics.Trace.WriteLine("Invalid username or password.");
                        }
                    }
                }
            }
            catch (Exception p)
            {
                System.Diagnostics.Trace.WriteLine("Connection error: " + p.Message);
            }
        }
    }
}