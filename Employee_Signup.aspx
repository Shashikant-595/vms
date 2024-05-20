﻿﻿﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee_Signup.aspx.cs" Inherits="VMS.Employee_Signup" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <title style="font: bold">SIGN UP</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png">
    <script src="Scripts/bootstrap.min.js"></script>
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
        }

            header img {
                height: 80px;
                margin-left: 5px;
            }

        .header-name {
            text-align: center;
            flex-grow: 1;
            font-size: 30px;
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
                padding: 20px 0;
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
                    font-size: 24px;
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

        .icon-sidebar:hover {
            width: 200px;
        }

        .center-container {
            text-align: center;
            margin-top: 90px;
        }

        Label {
            font-size: 16px;
        }
        /*.center-container label {
                padding: 8px 12px;
                font-size: 16px;
                border: 1px solid #ccc;
                border-radius: 5px;
                margin-bottom: 10px;
                display: inline-block;
                text-align: right;*/ /* Align textboxes to the right */
        /*flex: 1;*/ /* Take up remaining space */
        /*}

            .center-container input[type="text"] {
                width: 300px;
                padding: 9px 13px;
                font-size: 15px;
                border: 1px solid #ccc;
                border-radius: 8px;
                margin-bottom: 10px;
                display: inline-block;*/ /* Display textboxes inline */
        /*text-align: center;
                margin-left: 10px;
            }*/
        span:hover {
            animation: blink 1s infinite;
            color: #0066ff; /* Change this color to suit your background */
            text-decoration: none; /* Remove underline */
        }

        .logout-btn {
            margin-top: 900px;
            background-color: red;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
        <header>
            <link href="Content/bootstrap.min.css" rel="stylesheet" />


            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" />
            <div class="header-name">Create New Employee</div>
            <div id="userIdIcon">
                <i class="fas fa-user sidebar-icon text-primary fa-2x"></i>
                <div id="userIdTextBox" class="input-group" style="border-radius: 10px; margin-top: 10px;">
                    <input type="text" id="userIdInput" class="form-control rounded" style="border-radius: 8px; height: 30px;" placeholder="User ID" />
                </div>
            </div>
        </header>
        <div class="icon-sidebar">
            <a href="Entry_Screen.aspx">
                <i class='fas fa-door-open'></i>
                <span>ENTRY SCREEN</span>
            </a>
            <a href="Registration.aspx">
                <i class='fas fa-user-plus'></i>
                <span>INVITE VISITOR</span>
            </a>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <a href="Authenticate_User.aspx" class="logout-btn">
                <i class="fas fa-sign-out-alt" id="logoutBtn"></i>
                <span>Logout</span>
            </a>
        </div>

        <div class="container " style="margin-left: 200px">
            <div class="form-group col-sm-3 mt-5">
                <asp:Label ID="lbleName" runat="server" Text="Employee Name : "></asp:Label>
                <asp:TextBox ID="txteName" runat="server" CssClass="form-control" required></asp:TextBox>
            </div>
            <div class="form-group col-sm-3">
                <asp:Label ID="lbleMbNo" runat="server" Text="Mobile No : "></asp:Label>

                <asp:TextBox ID="txteMbNo" runat="server" CssClass="form-control" OnTextChanged="txteMbNo_TextChanged" AutoPostBack="True" required></asp:TextBox>
            </div>
            <div class="form-group col-sm-3">
                <asp:Label ID="Label1" runat="server" Text="Email : "></asp:Label>
                <asp:TextBox ID="txteemail" runat="server" CssClass="form-control" required></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidatorEmail" runat="server" ControlToValidate="txteemail"
                    ErrorMessage="Email is required" Display="Dynamic" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="regexEmail" runat="server" ControlToValidate="txteemail"
                    ValidationExpression="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
                    ErrorMessage="Please enter a valid email address with '@' symbol and a '.' before the ending word."
                    Display="Dynamic" ForeColor="Red"></asp:RegularExpressionValidator>
            </div>
            <div class="form-group  col-sm-3">
                <asp:Label ID="Labele2" runat="server" Text="Employee-ID    : "></asp:Label>
                <asp:TextBox ID="txtID" runat="server" CssClass="form-control" required></asp:TextBox>
            </div>
            <div class="form-group col-sm-3">
                <asp:Label ID="Label3" runat="server" Text="Department: "></asp:Label>
                <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control" onchange="showOtherOption(this)">
                    <asp:ListItem Text="SELECT OPTION" Value="IT"></asp:ListItem>
                    <asp:ListItem Text="COATING" Value="General"></asp:ListItem>
                    <asp:ListItem Text="Other (Please Specify)" Value="Other"></asp:ListItem>
                </asp:DropDownList>
                <input type="text" id="txtDepartment" class="form-control" style="display: none;" placeholder="Department">
            </div>
            <div class="form-group col-sm-3" style="position: relative;">
                <asp:Label ID="Label13" runat="server" Text="Password: "></asp:Label>
                <asp:TextBox ID="txtpassword" type="password" runat="server" CssClass="form-control" onfocus="showIcon(this)" onblur="hideIcon(this)" required></asp:TextBox>
                <span id="eyeIcon" class="toggle-password" onclick="togglePasswordVisibility()" style="position: absolute; top: 70%; transform: translateY(-50%); right: 10px; cursor: pointer;"><i class="fa fa-eye"></i></span>
            </div>
            <div class="form-group  col-sm-3">
                <asp:Label ID="Label4" runat="server" Text="User-Type"></asp:Label>
                <asp:DropDownList ID="usertype" runat="server" CssClass="form-control">
                    <asp:ListItem Enabled="true">SELECT OPTION</asp:ListItem>
                    <asp:ListItem Enabled="true">SupperAdmin</asp:ListItem>
                    <asp:ListItem Enabled="true">Admin</asp:ListItem>
                    <asp:ListItem Enabled="true">User</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-group col-sm-3 mt-5">
                <asp:Button ID="Btn_save" runat="server" Text="Register" CssClass="btn btn-primary" OnClick="Btn_save_Click" />
                <asp:Button ID="Btn_edit" runat="server" Text="Edit" CssClass="btn btn-primary" OnClick="Btn_edit_Click" Style="float; margin-left:80px;" />
            </div>
        </div>
                
            </ContentTemplate>
    <Triggers>
        <asp:AsyncPostBackTrigger ControlID="txteMbNo" EventName="TextChanged" />
        <asp:AsyncPostBackTrigger ControlID="Btn_save" EventName="Click" />
        <asp:AsyncPostBackTrigger ControlID="Btn_edit" EventName="Click" />
    </Triggers>
</asp:UpdatePanel>
                        <div class="col-md-4" style="margin-top: -500px; margin-left:650px; height: 580px; width:900px; overflow: auto;">
<asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" Width="300px">
    <Columns>
            <asp:BoundField DataField="Name" HeaderText="Name" ItemStyle-Width="100" />
            <asp:BoundField DataField="Mobile_No" HeaderText="Mobile No" ItemStyle-Width="100" />
            <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-Width="150" />
            <asp:BoundField DataField="Employee_ID" HeaderText="Employee ID" ItemStyle-Width="100" />
            <asp:BoundField DataField="Department" HeaderText="Department" ItemStyle-Width="100" />
            <asp:BoundField DataField="password" HeaderText="Password" ItemStyle-Width="100" />
            <asp:BoundField DataField="user_type" HeaderText="User Type" ItemStyle-Width="100" />
        </Columns>
    </asp:GridView>
</div>
    </form>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/jquery-3.7.1.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/Scripts/jquery.signalR-2.4.2.min.js"></script>
    <script src="/signalr/hubs"></script>


    <script>
        function togglePasswordVisibility() {
            var passwordField = document.getElementById("<%= txtpassword.ClientID %>");
            var icon = document.getElementById("eyeIcon");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                icon.innerHTML = '<i class="fa fa-eye-slash"></i>';
            } else {
                passwordField.type = "password";
                icon.innerHTML = '<i class="fa fa-eye"></i>';
            }
        }
        // Add event listener to show the text box when hovering over the user ID icon
        document.addEventListener("DOMContentLoaded", function () {
            var userIdIcon = document.getElementById("userIdIcon");
            var userIdTextBox = document.getElementById("userIdTextBox");
            userIdIcon.addEventListener("mouseover", function () {
                userIdTextBox.style.display = "block";
            });
            userIdIcon.addEventListener("mouseout", function () {
                userIdTextBox.style.display = "none";
            });
        });

    </script>

</body>
</html>
<script>
    // Add event listeners to all text boxes (except email) to capitalize all letters when typed
    document.addEventListener("DOMContentLoaded", function () {
        var textboxes = document.querySelectorAll('input[type="text"]:not(#txteemail)');
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