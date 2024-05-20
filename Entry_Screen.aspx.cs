using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VMS
{

    public partial class Entry_Screen : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CheckVisitorCount();
                PopulateVisitorInformation();

                System.Diagnostics.Trace.WriteLine($"gvfadcdfffffffffffff  " + Session["User_type"]);

                if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "SupperAdmin")
                {
                    System.Diagnostics.Trace.WriteLine($"gvfadcdfffffffffffff  " + Session["User_type"]);

                    // HR and IT head 
                    scanQrLink.Visible = true;
                    confirmLink.Visible = true;
                    registrationLink.Visible = true;
                    newVisitorLink.Visible = true;
                    employeelink.Visible = true;
                }
                if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "Admin")
                {
                    // only invote to visitors
                    scanQrLink.Visible = false;
                    confirmLink.Visible = true;
                    registrationLink.Visible = true;
                    newVisitorLink.Visible = true;
                    employeelink.Visible = false;
                }
                if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "User")
                {
                    // Hide the View button
                    scanQrLink.Visible = true;
                    confirmLink.Visible = false;
                    registrationLink.Style["display"] = "none";
                    newVisitorLink.Style["display"] = "none";
                    employeelink.Style["display"] = "none";
                }
            }
        }
        private void CheckVisitorCount()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT TOP 1 Total_Visitor FROM Record ORDER BY token DESC";

                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();

                object result = command.ExecuteScalar();
                int totalVisitor = result != null ? Convert.ToInt32(result) : 0;

                // Display the Total_Visitor count in the visitorCountInput textbox if greater than zero
                if (totalVisitor > 0)
                {
                    visitorCountInput.Text = totalVisitor.ToString();
                }

                // Use JavaScript to hide/show the TextBox and Label based on the value of totalVisitor
                string script = totalVisitor == 0
                    ? "document.getElementById('" + visitorCountInput.ClientID + "').style.display = 'none'; " +
                      "document.getElementById('" + visitorCountLabel.ClientID + "').style.display = 'none';"
                    : "document.getElementById('" + visitorCountInput.ClientID + "').style.display = 'block'; " +
                      "document.getElementById('" + visitorCountLabel.ClientID + "').style.display = 'block';";

                ScriptManager.RegisterStartupScript(this, GetType(), "ShowHideVisitorCount", script, true);
            }
        }

        private void PopulateVisitorInformation()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT TOP 1 Name, Mobile_No, Email, Company, Meeting_Subject, Date_Time FROM Record ORDER BY token DESC";

                SqlCommand command = new SqlCommand(query, connection);
                connection.Open();

                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();

                    txtName.Text = reader["Name"].ToString();
                    txtMbNo.Text = reader["Mobile_No"].ToString();
                    txtEmail.Text = reader["Email"].ToString();
                    txtCompany.Text = reader["Company"].ToString();
                    txtMeeting.Text = reader["Meeting_Subject"].ToString();
                    datetimepicker.Text = reader["Date_Time"].ToString();
                }

                reader.Close();
            }
        }
    }
}
