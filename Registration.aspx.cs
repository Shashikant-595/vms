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
        private string connectionString = "Data Source=DESKTOP-4TNUEJA\\MSSQLSERVER02;Initial Catalog=VMS;Integrated Security=True;";
        //private string connectionString = "Data Source=192.168.20.70,1433;Initial Catalog=vms;User ID=vms;Password=Vms@123;";

        private readonly object recipientNumber;
        private String SENDER_EMAIL = "softsupport@foresgroup.com";
        private String SENDER_PASSWORD = "Password@193";
        private String SUBJECT = "CONFIRMATION OF YOUR APPOINTMENT AT FORES GROUP";
        private String token;
        string employeename;


        private readonly Timer timer = new Timer();
        protected void Page_Load(object sender, EventArgs e)
        {
            BindGridView();

            // Check if the user is logged in as Admin
            if (Session["User_type"] != null && Session["User_type"].ToString().Trim() == "SupperAdmin")
            {
                System.Diagnostics.Trace.WriteLine($"reeeeeeeeeeeeegiiiii load");
                //  BindfDropDownList();

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
            try
            {
                // Check if Session variables are not null
                if (Session["name"] != null && Session["passmail"] != null && Session["User_id"] != null)
                {
                    string connectionString = "Data Source=DESKTOP-4TNUEJA\\MSSQLSERVER02;Initial Catalog=VMS;Integrated Security=True;";
                    string employeename = Session["name"].ToString();
                    string employymail = Session["passmail"].ToString();
                    string EmployeeMob = Session["User_id"].ToString();

                    string mobile_No = txtMbNo.Text;
                    string meetingSubject = ddlMeetingType.SelectedValue;
                    if (meetingSubject == "Other")
                    {
                        meetingSubject = txtMeeting.Text;
                    }

                    string meetingdate = datetimepicker.Text;
                    string visitor_Name = txtName.Text;
                    string visitor_Email = txtEmail.Text;
                    string Company = txtCompany.Text;
                    string totalPersons = txtTotalPersons.Text;

                    InsertRecord(employeename, EmployeeMob, mobile_No, meetingSubject, meetingdate, visitor_Name, visitor_Email, Company, totalPersons);

                    string token = "";
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

                    List<string> Qrdata = new List<string> { meetingSubject, visitor_Email, mobile_No, visitor_Name, Company, meetingdate, employeename, token};
                    PrintQRCode(Qrdata);
                    sendMail(visitor_Email, employymail, employeename);
                    System.Diagnostics.Trace.WriteLine($" mail is send successfully");

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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "DateTimePicker", "$('#" + datetimepicker.ClientID + "').datetimepicker();", true);
                }
                else
                {
                    Console.WriteLine("Session variables are null.");
                }
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
            int paperHeight = 350; // Adjust to the height of your paper to fit the QR code properly
            string combinedValue = string.Join("/", values);

            var hintMap = new Dictionary<EncodeHintType, object>
    {
        { EncodeHintType.CHARACTER_SET, "UTF-8" },
        { EncodeHintType.ERROR_CORRECTION, ZXing.QrCode.Internal.ErrorCorrectionLevel.L },
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
                Bitmap qrImage = new Bitmap(qrCodeSize, qrCodeSize);
                for (int x = 0; x < qrCodeSize; x++)
                {
                    for (int y = 0; y < qrCodeSize; y++)
                    {
                        qrImage.SetPixel(x, y, bitMatrix[x, y] ? Color.Black : Color.White);
                    }
                }

                Bitmap combinedImage = new Bitmap(paperWidth, paperHeight);
                using (Graphics g = Graphics.FromImage(combinedImage))
                {
                    g.FillRectangle(Brushes.White, 0, 0, paperWidth, paperHeight);

                    // Draw the QR code image
                    int qrCodeX = (paperWidth - qrCodeSize) / 2; // Center the QR code horizontally
                    int qrCodeY = paperHeight - qrCodeSize - 10; // Place the QR code at the bottom with a margin
                    g.DrawImage(qrImage, qrCodeX, qrCodeY);

                    int yOffset = paperHeight - 280; // Adjust this value as needed to control the vertical position

                    System.Drawing.Image gatePassImage = System.Drawing.Image.FromFile(@"D:\fores.jpg");
                    int logoX = 7; // Adjust this value to control the horizontal position of the logo
                    int logoY = 50; // Start from a top position and adjust incrementally
                    g.DrawImage(gatePassImage, logoX, logoY);


                    // Add the text elements at the bottom
                    g.DrawString("FORES ELASTOMECH INDIAN PVT,LTD", new Font("Verdana", 9, FontStyle.Bold), Brushes.DarkSlateGray, 30, 8);
                    g.DrawString("VISITOR GATE PASS", new Font("Verdana", 9, FontStyle.Bold), Brushes.DarkSlateGray, 60, 30);
                    g.DrawString("Name: " + values[3], new Font("Verdana", 9, FontStyle.Bold), Brushes.Black, 15, yOffset + 60);
                    g.DrawString("Meeting Date: " + values[5], new Font("Verdana", 9, FontStyle.Bold), Brushes.Black, 15, yOffset + 75);
                    g.DrawString("Mobile No: " + values[2], new Font("Verdana", 9, FontStyle.Bold), Brushes.Black, 15, yOffset + 90);
                    g.DrawString("Meeting With: " + values[6], new Font("Verdana", 9, FontStyle.Bold), Brushes.Black, 15, yOffset + 105);
                    g.DrawString("Company: " + values[4], new Font("Verdana", 9, FontStyle.Bold), Brushes.Black, 15, yOffset + 120);
                    g.DrawString("Subject: " + values[0], new Font("Verdana", 9, FontStyle.Bold), Brushes.Black, 15, yOffset + 135);

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
        protected void sendMail(String receiverMail, String employymail, string employeename)
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
        private void InsertRecord(string Whometo_Visit, string EmployeeMob, string Mobile_No, string Meeting_Subject, string Date_Time, string Name, string Email, string Company, string totalPersons)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                try
                {

                    string query = "INSERT INTO Record (Whometo_Visit, Mobile_No, Meeting_Subject, Date_Time, Name, Email, Company,Employee_mob,Total_Visitor) VALUES (@Whometo_Visit, @Mobile_No, @Meeting_Subject, @Date_Time, @Name, @Email, @Company,@EmployeeMob, @totalPersons)";

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
                        command.Parameters.AddWithValue("@totalPersons", totalPersons);

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

        private void BindGridView()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("SELECT token, Whometo_Visit, Mobile_No, Meeting_Subject, Date_Time, Name, Email, Company, IN_time, OUT_time, confirmation, Employee_mob, Total_Visitor FROM [Record]", con);
                try
                {
                    con.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {
            if (txtName.Text.Trim().Length > 0)
            {
                // Database connection string
                string query = "SELECT Mobile_No, Email, Company FROM Visitor_Registration WHERE Name = @Name";
                try
                {
                    // Establishing connection
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        System.Diagnostics.Trace.WriteLine($"Name text changed event is done;");
                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            // Parameter for Name
                            command.Parameters.AddWithValue("@Name", txtName.Text.Trim());

                            // Opening connection
                            connection.Open();

                            // Executing query
                            SqlDataReader reader = command.ExecuteReader();

                            // Checking if name exists
                            if (reader.Read())
                            {
                                // Autofilling details
                                txtMbNo.Text = reader["Mobile_No"].ToString();
                                txtEmail.Text = reader["Email"].ToString();
                                txtCompany.Text = reader["Company"].ToString();
                            }
                            else
                            {
                                ScriptManager.RegisterStartupScript(this, GetType(), "showalert", "alert('Name is not registered.');", true);
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
                    System.Diagnostics.Trace.WriteLine($"No record found; {ex.Message}");
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('An error occurred while processing your request. Please try again later.');", true);
                }
                catch (Exception ex)
                {
                    // Handling other exceptions
                    System.Diagnostics.Trace.WriteLine($"No record found; {ex.Message}");
                    ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('An unexpected error occurred. Please contact the administrator.');", true);
                }
            }
            else
            {
                // Displaying message for empty name
                ScriptManager.RegisterStartupScript(this, GetType(), "alertMessage", "alert('Name cannot be empty.');", true);
            }
        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                CheckBox chkConfirmation = (CheckBox)e.Row.FindControl("chkConfirmation");
                if (chkConfirmation != null)
                {
                    bool isConfirmed = DataBinder.Eval(e.Row.DataItem, "confirmation") != DBNull.Value && Convert.ToBoolean(DataBinder.Eval(e.Row.DataItem, "confirmation"));

                    chkConfirmation.Checked = isConfirmed;

                    if (isConfirmed)
                    {
                        chkConfirmation.CssClass = "checkbox-checked";
                    }
                    else
                    {
                        chkConfirmation.CssClass = "checkbox-unchecked";
                    }

                    // To ensure the checkbox size is applied properly, we can add an inline style as well
                    //chkConfirmation.Style.Add("width", "100px");
                    //chkConfirmation.Style.Add("height", "100px");
                }
            }
        }

    }
}