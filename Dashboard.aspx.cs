using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.SignalR;


namespace VMS
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int visitorCount = GetVisitorCount();

            // Update the visitor count on the page (assuming visitorCountLabel exists)
            

            var hubContext = GlobalHost.ConnectionManager.GetHubContext<ChatHub>();
            hubContext.Clients.All.ReceiveVisitorCount(visitorCount);
        }

        public int GetVisitorCount() // Change to public
        {
            int visitorCount = 0;

            // Connection string to your database
            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                // SQL query to get the visitor count
                string query = "SELECT COUNT(*) FROM Record";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    connection.Open();
                    visitorCount = (int)command.ExecuteScalar();
                }
            }

            return visitorCount;

        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            int visitorCount = GetVisitorCount();
            visitorCount = GetVisitorCount();
            Label1.Text = visitorCount.ToString();
        }

    }
    }