using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace VMS
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            int totalVisitors = GetTotalVisitors(connectionString);

            // Bind the count to the Label control
            totalVisitorsLabel.Text = totalVisitors.ToString();

        }

        private int GetTotalVisitors(string connectionString)
        {
            int count = 0;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string sql = "SELECT COUNT(*) FROM Record"; // Replace "Record" with your actual table name

                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    count = (int)command.ExecuteScalar();
                }
            }
            return count;
        }
    }
}