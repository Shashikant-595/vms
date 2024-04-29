using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data_Access_Layer
{
    public class master_userDAL
    {
        // Assuming you have a method to connect to the database, create a connection string, etc.
        private string connectionString = "Data Source=SHUBHAM\\SQLEXPRESS;Initial Catalog=molding;Integrated Security=True;";


        public bool SaveUser(string userType, string username, string password)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();

                    string query = "INSERT INTO Master_User (Category, Username, Password) VALUES (@UserType, @Username, @Password)";

                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@UserType", userType);
                        command.Parameters.AddWithValue("@Username", username);
                        command.Parameters.AddWithValue("@Password", password);

                        command.ExecuteNonQuery();
                    }
                }

                return true; // Data saved successfully
            }
            catch (Exception ex)
            {
                // Log the exception or handle it as needed
                return false; // Failed to save data
            }
        }

        public List<string> GetAllUsernames()
        {
            List<string> usernames = new List<string>();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                Console.WriteLine("usernames" + usernames);
                string query = "SELECT Username FROM Master_User";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            usernames.Add(reader["Username"].ToString());
                        }
                    }
                }
            }

            return usernames;
        }
    }
}
