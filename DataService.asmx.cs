using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Services;

namespace VMS
{
    /// <summary>
    /// Summary description for WebService1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class WebService1 : System.Web.Services.WebService
    {

        [WebMethod]
        public int GetLatestVisitorCount()
        {
            if (!this.Context.User.Identity.IsAuthenticated)
            {
                throw new Exception("Unauthorized access. Please login.");
            }

            string connectionString = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            int count = GetTotalVisitors(connectionString);
            return count;
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
