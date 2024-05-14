using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text.RegularExpressions;
using System.Web.Script.Serialization;
using System.Net.Mail;
using System.Net;
using System.Drawing.Imaging;
using System.Drawing;
using ZXing.Common;
using ZXing;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;
using System.Web.Mvc;
using ZXing.Aztec.Internal;

namespace VMS
{

    public partial class Registration : System.Web.UI.Page
    {
        // private string connectionString = "Data Source=localhost\\sqlexpress;Initial Catalog=VMS;Integrated Security=True;";
        private string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

        private readonly object recipientNumber;
        private String SENDER_EMAIL = "softsupport@foresgroup.com";
        private String SENDER_PASSWORD = "Password@193";
        private String SUBJECT = "CONFIRMATION OF YOUR APPOINTMENT AT FORES GROUP";
        private String token;
        string employeename;


        private readonly Timer timer = new Timer();
        protected void Page_Load(object sender, EventArgs e)
        {


            // Check if the user is logged in as Admin
            if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "SupperAdmin")
            {
                System.Diagnostics.Trace.WriteLine($"reeeeeeeeeeeeegiiiii load");
                //  BindDropDownList();

            }
            else if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "Admin")
            {

                employeelink.Visible = false;
                //  BindDropDownList();


            }

            else
            {
                System.Diagnostics.Trace.WriteLine($"registration up loads");

                Response.Redirect("Authenticate_User.aspx");
            }


        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";
            List<string> Qrdata = new List<string>();
            employeename = Session["name"].ToString();
            string employymail = Session["passmail"].ToString();
            string EmployeeMob = Session["User_id"].ToString();
            string mobile_No = txtMbNo.Text;
            string meetingSubject = txtMeeting.Text;
            string meetingdate = datetimepicker.Text;

            string visitor_Name = txtName.Text;
            string visitor_Email = txtEmail.Text;
            string Company = txtCompany.Text;

            InsertRecord(employeename, EmployeeMob, mobile_No, meetingSubject, meetingdate, visitor_Name, visitor_Email, Company);

            try
            {
                string queryfortoken = "SELECT MAX(token) AS LastToken FROM Record";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(queryfortoken, connection))
                    {
                        connection.Open();
                        object LastToken = command.ExecuteScalar();

                        if (LastToken != null)
                        {
                            token = LastToken.ToString();
                            System.Diagnostics.Trace.WriteLine($"token is  {token}");
                        }
                        else
                        {
                            System.Diagnostics.Trace.WriteLine($"token is null {token}");
                        }
                    }
                }

                Qrdata.Add(meetingSubject);
                Qrdata.Add(visitor_Email);
                Qrdata.Add(mobile_No);
                Qrdata.Add(visitor_Name);
                Qrdata.Add(Company);
                Qrdata.Add(meetingdate);
                Qrdata.Add(employeename);
                Qrdata.Add(token);

                PrintQRCode(Qrdata);
                sendMail(visitor_Email, employymail);
                System.Diagnostics.Trace.WriteLine($" mail is send success fully");

                // Display success message using ScriptManager
                string alertMessage = "alert('Your Meeting Request has been successfully submitted.');";
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert", alertMessage, true);

                // Clear input fields
                txtCompany.Text = string.Empty;
                txtEmail.Text = string.Empty;
                txtName.Text = string.Empty;
                datetimepicker.Text = string.Empty;
                txtMeeting.Text = string.Empty;

                // Reinitialize datetimepicker after the pop-up is closed
                ScriptManager.RegisterStartupScript(this, this.GetType(), "DateTimePicker", "$('#<%= datetimepicker.ClientID %>').datetimepicker();", true);

            }
            catch (Exception ex)
            {
                Console.WriteLine($"An unexpected error occurred: {ex.Message}");
            }

        }
        public void PrintQRCode(List<string> values)
        {
            int qrCodeSize = 90; // Adjust the QR code size as needed
            int paperWidth = 300; // Adjust to the width of your paper
            int paperHeight = 250; // Adjust to the height of your paper
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
                    int qrCodeX = 90;
                    int qrCodeY = 170;
                    g.DrawImage(image, qrCodeX, qrCodeY);
                    System.Drawing.Image gatePassImage = System.Drawing.Image.FromFile(@"D:\fores.jpg");

                    // Now, use the loaded image in the DrawImage method
                    g.DrawImage(gatePassImage, 5, 15);
                    g.DrawString("FORES ELASTOMECH INDIAN PVT,LTD ", new Font("Verdana", 9), Brushes.Blue, 55, 8);
                    g.DrawString("VISITOR GATE PASS ", new Font("Verdana", 9), Brushes.Blue, 100, 30);
                    g.DrawString("Name: " + values[3], new Font("Verdana", 9), Brushes.Black, 15, 90);
                    g.DrawString("Meeting Date: " + values[5], new Font("Verdana", 9), Brushes.Black, 15, 105);
                    g.DrawString("Mobile No: " + values[2], new Font("Verdana", 9), Brushes.Black, 15, 120);
                    g.DrawString("Meeting With: " + values[6], new Font("Verdana", 9), Brushes.Black, 15, 135);
                    g.DrawString("Company: " + values[4], new Font("Verdana", 9), Brushes.Black, 15, 150);
                    g.DrawString("Subject: " + values[0], new Font("Verdana", 9), Brushes.Black, 15, 165);

                    // parameters for position of texton the paper 
                    int textX = qrCodeX + qrCodeSize + 2;
                    int textY = qrCodeY + 20;


                }

                // Use HostingEnvironment.MapPath instead of Server.MapPath
                string savePath = @"D:\Gate_Pass.png";
                combinedImage.Save(savePath, ImageFormat.Png);
                Console.WriteLine("File saved at location: " + savePath);

            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine($" {ex.ToString()}");

                Console.WriteLine("Error occurred: " + ex.Message);
            }
        }
        protected void sendMail(String receiverMail, String employymail)
        {

            // write the code that can get the receiver email and send the link on that using the user credentials 
            //  string BODY_HTML = "<p>Hello Sir,</p><p>This is past 7-hour mixing batch testing report.</p><p>Please click on the button/link below:</p><p><a href=\"https://www.example.com\"><button style=\"padding:10px;background-color:#4CAF50;color:white;border:none;\">Click me</button></a></p>";

            try
            {
                using (SmtpClient client = new SmtpClient("smtp.office365.com"))
                {
                    client.Port = 587;
                    client.Credentials = new NetworkCredential(SENDER_EMAIL, SENDER_PASSWORD);
                    client.EnableSsl = true;


                    using (MailMessage message = new MailMessage())
                    {
                        message.From = new MailAddress(SENDER_EMAIL);
                        message.To.Add(new MailAddress(receiverMail));
                        message.CC.Add(new MailAddress(employymail));

                        message.Subject = SUBJECT;
                        message.IsBodyHtml = true;


                        // Attach the link 

                        string BODY_HTML = "<h1 style=\"color: blue\">Dear " + txtName.Text + ",<p> This is your Gate pass</h1><br>" +
                                           "<p style=\\\"padding-left: 20px;\\>This is a just quick message to confirm your upcoming appointment at Fores Group. <p>We're thrilled to have you visit our office!</p><br>" + "Thank You." + "<p>Best regards,</p><br><p> " + employeename + "</p>";

                        // Add the text part
                        message.Body = BODY_HTML;

                        // attach the file to the mail
                        string savePath = @"D:\Gate_Pass.png"; // Adjust the path as necessary
                        Attachment attachment = new Attachment(savePath);
                        message.Attachments.Add(attachment);


                        client.Send(message);
                        Console.WriteLine("Email sent successfully!");
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine($" in time entry {ex.Message}");
                Console.WriteLine("Failed to send email: " + ex.Message);
            }

        }

        //protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    string selectedValue = DropDownList1.SelectedValue;
        //}

        //private void BindDropDownList()
        //{
        //    // Your connection string to the database

        //    // Your SQL query to fetch names from the employ_Registration table
        //    string query = "SELECT Name FROM Employ_Registration";

        //    using (SqlConnection connection = new SqlConnection(connectionString))
        //    {
        //        using (SqlCommand command = new SqlCommand(query, connection))
        //        {
        //            connection.Open();
        //            SqlDataReader reader = command.ExecuteReader();
        //            if (reader.HasRows)
        //            {
        //                while (reader != null && reader.Read())
        //                {
        //                    if (!reader.IsDBNull(reader.GetOrdinal("Name")))
        //                    {
        //                        ListItem item = new ListItem(reader["Name"].ToString());
        //                        DropDownList1.Items.Add(item);
        //                    }
        //                }
        //            }
        //            reader.Close();
        //        }
        //    }
        //}

        protected void txtMbNo_TextChanged(object sender, EventArgs e)
        {



            if (txtMbNo.Text.Trim().Length == 10)
            {
                // Database connection string
                // Query to check if mobile number exists and retrieve details
                string query = "SELECT Name, Email, Company FROM Visitor_Registration WHERE Mobile_No = @Mobil_No";
                try
                {
                    // Establishing connection
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        System.Diagnostics.Trace.WriteLine($" event is done   ;");
                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            // Parameter for mobile number
                            command.Parameters.AddWithValue("@Mobil_No", txtMbNo.Text.Trim());

                            // Opening connection
                            connection.Open();

                            // Executing query
                            SqlDataReader reader = command.ExecuteReader();

                            // Checking if mobile number exists
                            if (reader.Read())
                            {
                                // Autofilling details
                                txtName.Text = reader["Name"].ToString();
                                txtEmail.Text = reader["Email"].ToString();
                                txtCompany.Text = reader["Company"].ToString();


                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Mobile number is not registered.');", true);
                                // Displaying message if mobile number not found
                                // ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Mobile number is not registered.');", true);
                                Response.Redirect("Signup.aspx");
                            }

                            // Closing reader
                            reader.Close();
                        }
                    }
                }
                catch (SqlException ex)
                {
                    // Handling SQL exceptions
                    System.Diagnostics.Trace.WriteLine($" No record found; {ex.Message}");


                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('An error occurred while processing your request. Please try again later.');", true);
                }
                catch (Exception ex)
                {
                    // Handling other exceptions
                    System.Diagnostics.Trace.WriteLine($" No record found; {ex.Message}");


                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('An unexpected error occurred. Please contact the administrator.');", true);
                }
            }
            else if (txtMbNo.Text.Trim().Length > 10)
            {
                // Displaying message for exceeding mobile number length
                ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Mobile number should be 10 digits.');", true);
            }
        }
        private void InsertRecord(string Whometo_Visit, string EmployeeMob, string Mobile_No, string Meeting_Subject, string Date_Time, string Name, string Email, string Company)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {

                    string query = "INSERT INTO Record (Whometo_Visit, Mobile_No, Meeting_Subject, Date_Time, Name, Email, Company,Employee_mob) VALUES (@Whometo_Visit, @Mobile_No, @Meeting_Subject, @Date_Time, @Name, @Email, @Company,@EmployeeMob)";

                    using (var command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Whometo_Visit", Whometo_Visit);
                        command.Parameters.AddWithValue("@Mobile_No", Mobile_No);
                        command.Parameters.AddWithValue("@Meeting_Subject", Meeting_Subject);
                        command.Parameters.AddWithValue("@Date_Time", DateTime.Now);
                        command.Parameters.AddWithValue("@Name", Name);
                        command.Parameters.AddWithValue("@Email", Email);
                        command.Parameters.AddWithValue("@Company", Company);
                        command.Parameters.AddWithValue("@EmployeeMob", EmployeeMob);

                        connection.Open();
                        command.ExecuteNonQuery();
                    }

                }
                catch (Exception ex)
                {
                    System.Diagnostics.Trace.WriteLine($"Mobile Number for {ex.Message}: ");

                }

            }
        }
    }
}