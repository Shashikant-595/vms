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
        // string connectionString = "Data Source=DESKTOP-4TNUEJA\\MSSQLSERVER02;Initial Catalog=vms;Integrated Security=True;";
        string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void loginbtn_Click(object sender, EventArgs e)
        {
            string userid = txtUsername.Text;
            string password = txtPassword.Text;

            string query = "select password,user_type,Name,Email from Employ_Registration WHERE Mobile_No = @Mobil_No";

            // here create 3 session variable as object and pass on forward for further aplication authentication 
            try
            {

                SqlConnection con = new SqlConnection(connectionString);
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    System.Diagnostics.Trace.WriteLine($" mobileno for quey ; " + userid);
                    cmd.Parameters.AddWithValue("@Mobil_No", userid);
                    con.Open();
                    System.Diagnostics.Trace.WriteLine($" query exicuted ; ");
                    // Executing query
                    SqlDataReader reader = cmd.ExecuteReader();
                    System.Diagnostics.Trace.WriteLine($" query exicuted ; ");
                    if (reader.Read())
                    {
                        string userpass = reader["password"].ToString();
                        string userlogintype = reader["user_type"].ToString();
                        string employeeName = reader["Name"].ToString();
                        string email = reader["email"].ToString();
                        System.Diagnostics.Trace.WriteLine($"pass from db ; " + userpass);
                        System.Diagnostics.Trace.WriteLine($"pass from db ; " + userlogintype);

                        if (password.Trim() == userpass.Trim())
                        {
                            System.Diagnostics.Trace.WriteLine($"password from if condition; " + password);
                            // pass session 3 variables 
                            Session["User_id"] = userid;
                            Session["User_type"] = userlogintype;
                            Session["password"] = password;
                            Session["name"] = employeeName;
                            Session["passmail"] = email;
                            Response.Redirect("Entry_Screen.aspx");
                            System.Diagnostics.Trace.WriteLine($"all parameters are passeddsjbdbvd nd  " + password);

                        }
                        else
                        {
                            System.Diagnostics.Trace.WriteLine($"all parameters are passeddsjbdbvd nd  " + password);

                        }



                    }

                }




            }
            catch (Exception p)
            {

                System.Diagnostics.Trace.WriteLine($" connection done ; " + p.Message);
            }



















            //if (txtUsername.Text == "Admin@vms" && txtPassword.Text == "Fores@123")
            //{
            //    // Set role as admin and redirect to entry screen
            //    Session["adminrole"] = "Admin";
            //    Response.Redirect("Entry_Screen.aspx");
            //}
            //if (txtUsername.Text == "User@vms" && txtPassword.Text == "Fores@7100")
            //{
            //    Session["UserRole"] = "User";
            //    Response.Redirect("Entry_Screen.aspx");
            //}

        }
    }
}