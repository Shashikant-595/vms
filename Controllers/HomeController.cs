using System;
using System.Collections.Generic;
using System.Drawing.Imaging;
using System.Drawing;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Mvc;
using ZXing;
using ZXing.Common;
using System.Data.SqlClient;
using System.Web.WebPages;
using System.Xml.Linq;

namespace VMS.Controllers
{
    
    public class HomeController : Controller
    {
       // string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";
        string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";
     


        public ActionResult Index()
        {
             return Redirect("Authenticate_User.aspx"); 
           // return View();
        }


     
        //public void GenerateQRcode(string token)
        //{
           


        //    if (token.IsEmpty())
        //    {
        //        System.Diagnostics.Trace.WriteLine($" id is empty; {token}");

        //    }

        //    string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";
        //    List<string> stringList = new List<string>();
        //    // Query to fetch Mobile_No based on the selected name
        //    string query = "SELECT * FROM Record WHERE token = @Name";

        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand command = new SqlCommand(query, connection))
        //        {
        //            // Parameter for the name
        //            command.Parameters.AddWithValue("@Name", token);

        //            // Opening connection
        //            connection.Open();
        //            try
        //            {
        //                // Executing query
        //                using (SqlDataReader reader = command.ExecuteReader())
        //                {
        //                    // Check if there are rows returned
        //                    if (reader.HasRows)
        //                    {
        //                        // Iterate through the rows
        //                        while (reader.Read())
        //                        {
        //                            // Example: Retrieve values from columns
        //                            string wtv = reader.GetString(reader.GetOrdinal("Whometo_Visit")); // Assuming ID is an integer column
        //                            string mobno = reader.GetString(reader.GetOrdinal("Mobile_No")); // Assuming Name is a string column
        //                            string MS = reader.GetString(reader.GetOrdinal("Meeting_Subject")); // Assuming Name is a string column
        //                            DateTime dateValue = reader.GetDateTime(reader.GetOrdinal("Date_Time")); // Assuming Name is a string column
        //                            string VN = reader.GetString(reader.GetOrdinal("Name")); // Assuming Name is a string column
        //                            string VE = reader.GetString(reader.GetOrdinal("Email")); // Assuming Name is a string column
        //                            string VC = reader.GetString(reader.GetOrdinal("Company")); // Assuming Name is a string column
        //                            string MD = dateValue.ToString("yyyy-MM-dd HH:mm:ss");
        //                            stringList.Add(MS);
        //                            stringList.Add(VE);
        //                            stringList.Add(mobno);
        //                            stringList.Add(VN);
        //                            stringList.Add(VC);
        //                            stringList.Add(MD);
        //                            stringList.Add(token);
        //                            System.Diagnostics.Trace.WriteLine($" stringList count ; {stringList.Count}");

        //                        }
        //                    }
        //                    else
        //                    {
        //                        System.Diagnostics.Trace.WriteLine($" No record found; {stringList.Count}");

        //                    }

        //                }
        //                Console.WriteLine(token);

        //                Console.WriteLine("qr code block  ");

        //            }
        //            catch (Exception ex)
        //            {
        //                System.Diagnostics.Trace.WriteLine($" SQL exception found; {ex.Message}");

        //            }

        //            try
        //            {
        //                PrintQRCode(stringList);

        //            }
        //            catch (Exception ex)
        //            {
        //                System.Diagnostics.Trace.WriteLine($" PrintQRCode(stringList); {ex.ToString()}");
                     

        //            }
                    
        //        }
        //    }
        //}
        public void PrintQRCode(List<string> values)
        {
            int qrCodeSize = 75; // Adjust the QR code size as needed
            int paperWidth = 300; // Adjust to the width of your paper
            int paperHeight = 200; // Adjust to the height of your paper
            string combinedValue = string.Join("/", values);

            var hintMap = new Dictionary<EncodeHintType, object>
            {
                { EncodeHintType.CHARACTER_SET, "UTF-8" },
            { EncodeHintType.ERROR_CORRECTION, ZXing.QrCode.Internal.ErrorCorrectionLevel.L  },
            { EncodeHintType.MARGIN, 1 }
        };

            BarcodeWriter writer = new BarcodeWriter
            {
                Format = BarcodeFormat.QR_CODE,
                Options = new EncodingOptions
                {
                    Height = qrCodeSize,
                    Width = qrCodeSize,
                    Margin = 1
                }
            };

            try
            {
                var bitMatrix = writer.Encode(combinedValue);
                Bitmap image = new Bitmap(qrCodeSize, qrCodeSize);
                for (int x = 0; x < qrCodeSize; x++)
                {
                    for (int y = 0; y < qrCodeSize; y++)
                    {
                        image.SetPixel(x, y, bitMatrix[x, y] ? Color.Black : Color.White);
                    }
                }

                Bitmap combinedImage = new Bitmap(paperWidth, paperHeight);
                using (Graphics g = Graphics.FromImage(combinedImage))
                {
                    g.FillRectangle(Brushes.White, 0, 0, paperWidth, paperHeight);
                    // parameters of position of qr image 
                    int qrCodeX = 8;
                    int qrCodeY = 80;
                    g.DrawImage(image, qrCodeX, qrCodeY);

                    g.DrawString("*****VISITOR GATE PASS**** ", new Font("Verdana", 9), Brushes.Black, 15, 30);
                    g.DrawString("Name: " + values[4], new Font("Verdana", 9), Brushes.Black, 15, 45);
                    g.DrawString("Meeting Date: " + values[5], new Font("Verdana", 9), Brushes.Black, 15, 60);
                    // parameters for position of texton the paper 
                    int textX = qrCodeX + qrCodeSize + 2;
                    int textY = qrCodeY + 20;

                    g.DrawString("M_Subject: " + values[0], new Font("Verdana", 9), Brushes.Black, textX, textY);
                    g.DrawString("Email: " + values[1], new Font("Verdana", 9), Brushes.Black, textX, textY + 15);
                    g.DrawString("MOB no: " + values[2], new Font("Verdana", 9), Brushes.Black, textX, textY + 30);
                    g.DrawString("counterpart: " + values[3], new Font("Verdana", 9), Brushes.Black, textX, textY + 45);
                }

                // Use HostingEnvironment.MapPath instead of Server.MapPath
                string savePath = @"D:\generatedQR.png";
                combinedImage.Save(savePath, ImageFormat.Png);
                Console.WriteLine("File saved at location: " + savePath);

            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine($" {ex.ToString()}");

                Console.WriteLine("Error occurred: " + ex.Message);
            }
        }
        [HttpPost]
        public ActionResult SaveQRData(string qrData)
        {
            System.Diagnostics.Trace.WriteLine($"method calles " + qrData);
            var tokenfromqr = qrData.Split('/');
            System.Diagnostics.Trace.WriteLine($"array length {tokenfromqr.Length}");
            string Token = tokenfromqr[9];
            TimeSpan currentTime = DateTime.Now.TimeOfDay;
            string formattedTime = currentTime.ToString("hh\\:mm");
            System.Diagnostics.Trace.WriteLine($"token from controller ={Token}");
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string queryCheck = "SELECT IN_time, OUT_time ,confirmation FROM Record WHERE token = @token";
                    string queryInsert = "UPDATE Record SET IN_time = @time WHERE token = @token";
                    string queryUpdateOutTime = "UPDATE Record SET OUT_time = @time WHERE token = @token";
                    string queryUpdateErrorFlag = "UPDATE Record SET error_flag = 1 WHERE token = @token";
                    connection.Open();
                    SqlCommand commandCheck = new SqlCommand(queryCheck, connection);
                    commandCheck.Parameters.AddWithValue("@token", Token);
                    SqlDataReader reader = commandCheck.ExecuteReader();
                    if (reader.Read())
                    {
                        // Check if IN_time is NULL
                        if (reader.IsDBNull(0)) // IN_time is NULL
                        {
                            reader.Close();
                            // update IN_time with current time
                            SqlCommand commandInsert = new SqlCommand(queryInsert, connection);
                            commandInsert.Parameters.AddWithValue("@time", formattedTime);
                            commandInsert.Parameters.AddWithValue("@token", Token);
                            commandInsert.ExecuteNonQuery();
                            return Content("****VISITOR ENTRY SUCCESFULL**** : ", "text/plain");
                            System.Diagnostics.Trace.WriteLine($" in time entry {Token}");
                        }

                        // Check if confirmation is true
                        if (!reader.IsDBNull(2) && reader.GetBoolean(2)) // confirmation is true
                        {
                            reader.Close();
                            // Update OUT_time with current time
                            SqlCommand commandUpdateOutTime = new SqlCommand(queryUpdateOutTime, connection);
                            commandUpdateOutTime.Parameters.AddWithValue("@time", formattedTime);
                            commandUpdateOutTime.Parameters.AddWithValue("@token", Token);
                            commandUpdateOutTime.ExecuteNonQuery();
                            return Content("***Thank you for visiting our premises **** ", "text/plain");
                            System.Diagnostics.Trace.WriteLine($" out time entry {Token}");

                        }
                        else
                        {

                            // Confirmation is not true, so return without updating OUT_time
                            return Content("YOUR MEETING CONFIRMATION IS PENDING !!!.", "text/plain");
                            System.Diagnostics.Trace.WriteLine($" conformation is not done  time entry {Token}");
                        }

                        //// Update error flag to indicate invalid QR after fourth scan
                        if (!reader.IsDBNull(1)) // OUT_time is not NULL
                        {
                            SqlCommand commandUpdateErrorFlag = new SqlCommand(queryUpdateErrorFlag, connection);
                            commandUpdateErrorFlag.Parameters.AddWithValue("@token", Token);
                            commandUpdateErrorFlag.ExecuteNonQuery();

                            return Content("Invalid QR detected: More than two scans detected", "text/plain");
                        }

                    }
                    else
                    {
                        reader.Close();
                        return Content("Invalid QR detected: No record found for the given user", "text/plain");
                    }
                }

            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine($"Error: {ex.Message}");
                return Content(ex.ToString());
            }
        }

        [HttpPost]

        public ActionResult Conform_meeting(string qrData)
        {
            var tokenfromqr = qrData.Split('/');
            System.Diagnostics.Trace.WriteLine($"array length: {tokenfromqr.Length}");
            string Token = tokenfromqr[9];
         
           
           
               try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string queryCheck = "SELECT IN_time, confirmation,Employee_mob FROM Record WHERE token = @token";

                    string queryUpdateConfirmation = "UPDATE Record SET confirmation = 1 WHERE token = @token";

                  
                    connection.Open();
                    SqlCommand commandCheck = new SqlCommand(queryCheck, connection);
                    commandCheck.Parameters.AddWithValue("@token", Token);
                    SqlDataReader reader = commandCheck.ExecuteReader();
                    if (reader.Read())
                    {
                        // Check if IN_time is not null
                        if (!reader.IsDBNull(0))
                        {
                            string conform=reader.GetString(2).Trim();
                            string userid = Session["User_id"].ToString().Trim();

                            // Check if confirmation is false
                            if (reader.IsDBNull(1) && conform == userid) // confirmation is false
                            {

                                reader.Close();
                                // Update confirmation to true
                                SqlCommand commandUpdateConfirmation = new SqlCommand(queryUpdateConfirmation, connection);
                                commandUpdateConfirmation.Parameters.AddWithValue("@token", Token);
                                commandUpdateConfirmation.ExecuteNonQuery();
                                System.Diagnostics.Trace.WriteLine($"Confirmation updated for token: {Token}");

                                return Content("CONFIRMATION DONE !!", "text/plain");

                            }
                            else
                            {
                                return Content("UNAUTHORISED USER FOUND!!", "text/plain");
                            }
                           
                        }
                        else
                        {
                            return Content("Intime Entry is still pending!!", "text/plain");
                        }
                    }
                    return Content("NOW VISITOR CAN GO ", "text/plain");
                }
               
            }

            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine($"Error: {ex.ToString()}");
                return Content("UNABLE TO READ QRCODE : ");
            }
          
        }


    }
}