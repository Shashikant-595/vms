using Microsoft.SqlServer.Management.Common;
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
        public static class ConnectionStrings
        {
            public static string MyConnectionString { get; } = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initial data load
                totalVisitorsLabel.Text = GetTotalVisitors().ToString();
            }
            else
            {
                // Subsequent page loads - trigger AJAX request for updates
                UpdateCardContent();
            }

        }

        private void UpdateCardContent()
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "updateData",
              "$get('" + totalVisitorsLabel.ClientID + "').innerHTML = 'Loading...';" +
              "$.ajax({ url: 'DataService.asmx/GetLatestVisitorCount', success: function(data) { " +
              "$get('" + totalVisitorsLabel.ClientID + "').innerHTML = data; }, dataType: 'json' });", true);
            totalVisitorsLabel.Text = GetTotalVisitors().ToString(); // No need to pass connection string
        }

        private int GetTotalVisitors() // New method without connection string argument
        {
            int count = 0;
            using (SqlConnection connection = new SqlConnection(ConnectionStrings.MyConnectionString))
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