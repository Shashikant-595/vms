<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="VMS.Registration" Async="true" %>

<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <title>REGISTRATION</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png">
    <link href="Content/Site.css" rel="stylesheet" />
    <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />

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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" />
            <div class="header-name">INVITE VISITOR</div>
            <%--   <link href="Content/bootstrap.min.css" rel="stylesheet" />

            <link href="Content/bootstrap-datetimepicker.min.css" rel="stylesheet" />--%>


            <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
            <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/css/bootstrap-datetimepicker.min.css" rel="stylesheet" />
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.47/js/bootstrap-datetimepicker.min.js"></script>


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
                                <a href="Authenticate_User.aspx" class="logout-btn">
    <i class="fas fa-sign-out-alt"></i>
    <span>Logout</span>
</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="  justify-content-center" style="margin-left: 200px">
            <div class="row">
                <div class="col-md-3">
                    <div class="form-group">
                        <asp:Label ID="lblName" runat="server" Text="Name :" AssociatedControlID="txtName" ></asp:Label>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required></asp:TextBox>
                    </div>
                </div>
            </div>
          <div class="row">
    <div class="col-md-3">
        <div class="form-group">
            <asp:Label ID="lblMbNo" runat="server" Text="Mobile No :" AssociatedControlID="txtMbNo"></asp:Label>
            <asp:TextBox ID="txtMbNo" runat="server" OnTextChanged="txtMbNo_TextChanged" AutoPostBack="True" CssClass="form-control" required></asp:TextBox>
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
</div><div class="row">
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
            <select class="form-control" id="ddlMeetingType" onchange="showOtherOption(this)" required>
                <option value="">Select Meeting Type</option>
                <option value="Business Meeting">Business Meeting</option>
                <option value="Job Interview">Job Interview</option>
                <option value="Vendor Meeting">Vendor Meeting</option>
                <option value="Client Visit">Client Visit</option>
                <option value="Training Session">Training Session</option>
                <option value="Delivery / Pickup">Delivery / Pickup</option>
                <option value="Personal Visit">Personal Visit</option>
                <option value="Maintenance/Repair Visit">Maintenance/Repair Visit</option>
                <option value="Government Inspection">Government Inspection</option>
                <option value="Audit">Audit</option>
                <option value="Material Inspection">Material Inspection</option>
                <option value="Other">Other (Please Specify)</option>
            </select>
            <input type="text" id="txtMeeting" class="form-control" style="display: none;" placeholder="Meeting Subject">
        </div>
    </div>
</div>


<script>
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
        <div class="form-group">
            <asp:Label ID="Label9" runat="server" Text="Meeting Date and Time :" AssociatedControlID="datetimepicker"></asp:Label>
            <asp:TextBox ID="datetimepicker" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="datetimepicker" ErrorMessage="Meeting Date and Time is required" Display="None"></asp:RequiredFieldValidator>
        </div>
    </div>
</div>


            <div class="row">
                <div class="col-md-3">
                    <asp:Button ID="RGN" runat="server" Text="Submit" CssClass="btn btn-primary btn-lg btn-block" OnClick="Button1_Click" />
                </div>
            </div>

        </div>
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
        </script>

    </form>

    
</body >
</html >
<script>
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
</script>
