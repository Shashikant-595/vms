using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data_Access_Layer
{
    public class UserValidator
    {
        private readonly string connectionString; // Connection string for your database

        public UserValidator()
        {
            // Get connection string from web.config
            //connectionString = ConfigurationManager.ConnectionStrings["DemoDB"].ConnectionString;
            connectionString = "Data Source=SHUBHAM\\SQLEXPRESS;Initial Catalog=molding;Integrated Security=True;";
        }

        public String ValidateUser(string username, string password)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT Category FROM Master_User WHERE Username = @Username AND Password = @Password";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@Username", username);
                    command.Parameters.AddWithValue("@Password", password);

                    // Use ExecuteScalar to get the Category value
                    object result = command.ExecuteScalar();

                    // Check if result is not null and convert it to string
                    string category = (result != null) ? result.ToString() : null;

                    return category;
                }
            }
        }

    }
}
