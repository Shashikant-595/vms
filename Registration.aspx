<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="VMS.Registration" Async="true" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <title>REGISTRATION</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png">
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            overflow: hidden;
        }

        header {
            background-color: darkgray;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            width: 100%;
        }

            header img {
                height: 80px;
                margin-left: 5px;
            }

        .header-name {
            text-align: center;
            flex-grow: 1;
            font-size: 24px;
            font-weight: bold;
        }

        .icon-sidebar {
            background-color: darkgray;
            width: 25px;
            position: fixed;
            height: 100%;
            transition: width 0.3s;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

            .icon-sidebar a {
                color: black;
                padding: 17px 0;
                text-align: center;
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                text-decoration: none;
                margin-top: 50px;
            }

                .icon-sidebar a i {
                    display: block; /* Initially display only icons */
                    font-size: 14px;
                }

                .icon-sidebar a span {
                    display: none;
                    opacity: 0;
                    transition: opacity 0.3s; /* Use opacity for smooth transition */
                    /* Initially set opacity to 0 */
                }

            .icon-sidebar:hover a i {
                display: inline; /* Hide icons when hovering over the sidebar */
            }

            .icon-sidebar:hover a span {
                display: inline; /* Display span text when hovering over the sidebar */
                opacity: 1; /* Set opacity to 1 to reveal the text */
            }

        .content {
            margin-left: 60px;
            padding: 16px;
            transition: margin-left 0.3s;
        }

        .icon-sidebar:hover {
            width: 180px;
        }



        .center-container {
            text-align: center;
            margin-top: 90px;
        }

            .center-container label {
                padding: 8px 12px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-bottom: 10px;
                display: inline-block;
                text-align: right; /* Align textboxes to the right */
                flex: 1; /* Take up remaining space */
            }

            .center-container input[type="text"] {
                width: 300px;
                padding: 9px 13px;
                font-size: 15px;
                border: 1px solid #ccc;
                border-radius: 8px;
                margin-bottom: 10px;
                display: inline-block; /* Display textboxes inline */
                text-align: center; /* Align textboxes to the right */
                margin-left: 10px;
            }

        @keyframes blink {
            0% {
                opacity: 1;
            }

            50% {
                opacity: 0;
            }

            100% {
                opacity: 1;
            }
        }

        .blinking-link {
            animation: blink 1s infinite;
            color: #0066ff; /* Change this color to suit your background */
            text-decoration: none; /* Remove underline */
        }

            .blinking-link:hover {
                text-decoration: underline; /* Add underline on hover */
            }

        /* CSS for positioning */
        .registration-link {
            position: relative;
            top: 10px; /* Adjust the value as needed for desired spacing */
        }

        .logout-btn {
            margin-top: 400px;
            background-color: red;
        }

        .logout-btn {
            margin-top: 900px;
            background-color: red;
        }

        .checkbox-unchecked input[type="checkbox"] {
            width: 40px;
            height: 40px;
            background-color: red;
        }

        .checkbox-checked input[type="checkbox"] {
            width: 40px;
            height: 40px;
            background-color: green;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <header>
            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" />

            <div class="header-name">INVITE VISITOR</div>
            <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
            <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        </header>
        <div class="jumbotrone" style="position: sticky; left: 0; background-color: gray;">
            <div class="row">
                <div class="col-md-auto">
                    <div class="icon-sidebar bg-darkgray" id="sidebar">
                        <a href="Entry_Screen.aspx">
                            <i class='fas fa-door-open'></i>
                            <span class="d-none d-md-inline">ENTRY SCREEN</span>
                        </a>
                        <a href="Signup.aspx">
                            <i class='fas fa-user-plus'></i>
                            <span class="d-none d-md-inline">NEW VISITORS REGISTRATION</span>
                        </a>
                        <a href="Employee_Signup.aspx" id="employeelink" runat="server">
                            <i class='fas fa-user-plus'></i>
                            <span class="d-none d-md-inline">NEW EMPLOYEE REGISTRATION</span>
                        </a>
                        <br />
                        <br />
                        <br />
                        <a href="#" class="logout-btn">
                            <i class="fas fa-sign-out-alt" id="logoutBtn"></i>
                            <span>Logout</span>
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <div class="justify-content-center" style="margin-left: 200px">
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <asp:Label ID="lblName" runat="server" Text="Name :" AssociatedControlID="txtName"></asp:Label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" AutoPostBack="True" OnTextChanged="txtName_TextChanged" required></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-1">
                    <div class="form-group">
                        <i class="fas fa-plus-circle" id="plusIcon" style="margin-top: 35px; margin-left: -70px"></i>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="form-group">
                        <asp:TextBox ID="txtTotalPersons" runat="server" CssClass="form-control" placeholder="Total Persons" Style="margin-top: 24px; width: 110px; margin-left: -170px"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <asp:Label ID="lblMbNo" runat="server" Text="Mobile No :" AssociatedControlID="txtMbNo"></asp:Label>
                        <asp:TextBox ID="txtMbNo" runat="server" CssClass="form-control" required></asp:TextBox>
                        <asp:RegularExpressionValidator ID="regexMobile" runat="server" ControlToValidate="txtMbNo"
                            ValidationExpression="^[0-9]{10}$"
                            ErrorMessage="Please enter a valid 10-digit mobile number."
                            Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <asp:Label ID="Label1" runat="server" Text="Email :" AssociatedControlID="txtEmail"></asp:Label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" required></asp:TextBox>
                        <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txtEmail"
                            ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                            ErrorMessage="Please enter a valid email address with '@' symbol and a '.' before the ending word."
                            Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <asp:Label ID="Label2" runat="server" Text="Company:"></asp:Label>
                        <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control" required></asp:TextBox>
                        <asp:RequiredFieldValidator runat="server" ID="reqCompany" ControlToValidate="txtCompany" ErrorMessage="Please enter the company name!" />
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <label for="ddlMeetingType">Meeting Subject :</label>
                        <asp:DropDownList ID="ddlMeetingType" runat="server" class="form-control" onchange="showOtherOption(this)" required>
                            <asp:ListItem Value="">Select Meeting Type</asp:ListItem>
                            <asp:ListItem Value="Business Meeting">Business Meeting</asp:ListItem>
                            <asp:ListItem Value="Job Interview">Job Interview</asp:ListItem>
                            <asp:ListItem Value="Vendor Meeting">Vendor Meeting</asp:ListItem>
                            <asp:ListItem Value="Client Visit">Client Visit</asp:ListItem>
                            <asp:ListItem Value="Training Session">Training Session</asp:ListItem>
                            <asp:ListItem Value="Delivery Pickup">Delivery  Pickup</asp:ListItem>
                            <asp:ListItem Value="Personal Visit">Personal Visit</asp:ListItem>
                            <asp:ListItem Value="Maintenance Repair Visit">Maintenance/Repair Visit</asp:ListItem>
                            <asp:ListItem Value="Government Inspection">Government Inspection</asp:ListItem>
                            <asp:ListItem Value="Audit">Audit</asp:ListItem>
                            <asp:ListItem Value="Material Inspection">Material Inspection</asp:ListItem>
                            <asp:ListItem Value="Other">Other (Please Specify)</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtMeeting" runat="server" class="form-control" Style="display: none;" placeholder="Meeting Subject"></asp:TextBox>
                    </div>
                </div>
            </div>

            <div class="row">

                <script> 

                    document.getElementById('plusIcon').addEventListener('click', function () {
                        var totalPersonsTextbox = document.getElementById('<%= txtTotalPersons.ClientID %>');
                        var currentValue = parseInt(totalPersonsTextbox.value || 0);
                        totalPersonsTextbox.value = currentValue + 1;
                    });

                    function showOtherOption(select) {
                        var selectedOption = select.value;
                        var meetingTextBox = document.getElementById("txtMeeting");
                        if (selectedOption === "Other") {
                            meetingTextBox.style.display = "block";
                        } else {
                            meetingTextBox.style.display = "none";
                        }
                    } function showOtherOption(select) {
                        var selectedOption = select.value;
                        var meetingTextBox = document.getElementById("txtMeeting");
                        if (selectedOption === "Other") {
                            meetingTextBox.style.display = "block";
                        } else {
                            meetingTextBox.style.display = "none";
                        }
                    }

                    function validateMobile() {
                        var mobileNumber = document.getElementById('<%= txtMbNo.ClientID %>').value;
                        var regex = /^[0-9]{10}$/;
                        if (!regex.test(mobileNumber)) {
                            alert("Please enter a valid 10-digit mobile number.");
                            return false;
                        }
                        return true;
                    }

                    function showOtherOption(select) {
                        var otherOption = select.options[select.selectedIndex].value;
                        if (otherOption === "Other") {
                            document.getElementById("txtMeeting").style.display = "block";
                            document.getElementById("txtMeeting").setAttribute("required", "true");
                        } else {
                            document.getElementById("txtMeeting").style.display = "none";
                            document.getElementById("txtMeeting").removeAttribute("required");
                        }
                    }
                </script>


                <%--  <div class="row">
        <div class="col-md-3">
            <div class="form-group">
                <asp:Label ID="Label4" runat="server" Text="Meeting Invitor :" AssociatedControlID="DropDownList1"></asp:Label>
                <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" CssClass="form-control" Style="width: 100%;"></asp:DropDownList>
            </div>
        </div>
        </div>--%>
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group" style="margin-left: 7px;">
                            <label for="datetimepicker">Meeting Date and Time :</label>
                            <asp:TextBox ID="datetimepicker" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="datetimepicker" ErrorMessage="Meeting Date and Time is required" Display="None"></asp:RequiredFieldValidator>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-3">
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:Button ID="RGN" runat="server" Text="Submit" CssClass="btn btn-primary btn-lg btn-block" OnClick="Button1_Click" />
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <%-- <div class="col-md-8" style="margin-top: -440px; margin-left:260px; height: 580px; width:1100px; overflow: auto;">
                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-bordered table-hover table-sm" AutoGenerateColumns="False" OnRowDataBound="GridView1_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="token" HeaderText="Token" />
                            <asp:BoundField DataField="Whometo_Visit" HeaderText="Whom to Visit" />
                            <asp:BoundField DataField="Mobile_No" HeaderText="Mobile No" />
                            <asp:BoundField DataField="Meeting_Subject" HeaderText="Meeting Subject" />
                            <asp:BoundField DataField="Date_Time" HeaderText="Date Time" />
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:BoundField DataField="Email" HeaderText="Email" />
                            <asp:BoundField DataField="Company" HeaderText="Company" />
                            <asp:BoundField DataField="IN_time" HeaderText="IN Time" />
                            <asp:BoundField DataField="OUT_time" HeaderText="OUT Time" />
                            <asp:TemplateField HeaderText="Confirmation">
            <ItemTemplate>
                <asp:CheckBox ID="chkConfirmation" runat="server" 
                    Checked='<%# Eval("confirmation") != DBNull.Value && Convert.ToBoolean(Eval("confirmation")) %>' 
                    Enabled="false" />
            </ItemTemplate>
        </asp:TemplateField>
                            <asp:BoundField DataField="Employee_mob" HeaderText="Employee Mobile" />
                            <asp:BoundField DataField="Total_Visitor" HeaderText="Total Visitors" />
                        </Columns>
                    </asp:GridView>

                </div>--%>
            </div>
    </form>

    <script>
        document.getElementById('sidebar').addEventListener('mouseenter', function () {
            this.classList.add('show');
        });

        document.getElementById('sidebar').addEventListener('mouseleave', function () {
            this.classList.remove('show');
        });

        $(function () {
            $('#<%= datetimepicker.ClientID %>').datetimepicker();
        });

        function showOtherOption(select) {
            var otherOption = select.options[select.selectedIndex].value;
            if (otherOption === "Other") {
                document.getElementById("txtMeeting").style.display = "block";
                document.getElementById("txtMeeting").setAttribute("required", "true");
            } else {
                document.getElementById("txtMeeting").style.display = "none";
                document.getElementById("txtMeeting").removeAttribute("required");
            }
        }

        // Add event listeners to all text boxes (except email) to capitalize all letters when typed
        document.addEventListener("DOMContentLoaded", function () {
            var textboxes = document.querySelectorAll('input[type="text"]:not(#txtEmail)');
            textboxes.forEach(function (textbox) {
                textbox.addEventListener("input", function () {
                    // Get the current value of the textbox
                    var currentValue = this.value;
                    // Convert the value to uppercase
                    var newValue = currentValue.toUpperCase();
                    // Update the textbox value with the uppercase text
                    this.value = newValue;
                });
            });
        });

        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/Registration.aspx', { // Replace with your actual logout handler URL
                method: 'POST'
            })
                .then(response => {
                    if (response.ok) {
                        // Logout successful, clear session information (client-side)
                        sessionStorage.clear(); // Clear session storage for client-side data

                        // Replace the current URL in the browser history with the login page
                        history.replaceState(null, null, '/Authenticate_User.aspx');

                        // Redirect to login page
                        window.location.href = '/Authenticate_User.aspx';
                    } else {
                        console.error('Logout failed with status:', response.status);
                        // Handle logout failure (optional: display error message)
                    }
                })
                .catch(error => {
                    console.error('Error logging out:', error);
                    // Handle network errors (optional: display error message)
                });
        });

    </script>
</body>
</html>
