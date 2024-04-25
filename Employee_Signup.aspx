<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee_Signup.aspx.cs" Inherits="VMS.Employee_Signup" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <title style="font:bold">SIGN UP</title>
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
    padding: 15px 0;
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
.icon-sidebar:hover{
    width:180px;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
            <link href="Content/bootstrap.min.css" rel="stylesheet" />


            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" />
            <div class="header-name">Create New User</div>
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
        </div>

      <div class="container "  style="margin-left:200px">
                <div class="form-group col-sm-3 mt-5">
                    <asp:Label ID="lbleName" runat="server" Text="Employee Name : "></asp:Label>
                    <asp:TextBox ID="txteName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group col-sm-3">
                    <asp:Label ID="lbleMbNo" runat="server" Text="Mobile No : "></asp:Label>
                   
                    <asp:TextBox ID="txteMbNo"  runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group  col-sm-3">
                    <asp:Label ID="Label1" runat="server" Text="Email : "></asp:Label>
                    <asp:TextBox ID="txteemail" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group  col-sm-3">
                    <asp:Label ID="Labele2" runat="server" Text="Employee-Code : "></asp:Label>
                    <asp:TextBox ID="txteDepartment" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="form-group col-sm-3" style="position: relative;">
    <asp:Label ID="Label13" runat="server" Text="Password: "></asp:Label>
    <asp:TextBox ID="txtpassword" type="password" runat="server" CssClass="form-control" onfocus="showIcon(this)" onblur="hideIcon(this)"></asp:TextBox>
    <span id="eyeIcon" class="toggle-password" onclick="togglePasswordVisibility()" style="position: absolute; top: 70%; transform: translateY(-50%); right: 10px; cursor: pointer;"><i class="fa fa-eye"></i></span>
</div>
                <div class="form-group  col-sm-3">
                    <asp:Label ID="Label4" runat="server" Text="User-Type"></asp:Label>
                    <asp:DropDownList ID="usertype" runat="server" CssClass="form-control">
                        <asp:ListItem Enabled="true">SupperAdmin</asp:ListItem>
                        <asp:ListItem Enabled="true">Admin</asp:ListItem>
                        <asp:ListItem Enabled="true">User</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="form-group col-sm-3 mt-5">
                <asp:Button ID="btn_save" runat="server" Text="Register" CssClass="btn btn-primary" OnClick="btn_save_Click" />


                </div>
            </div>
       
    </form>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/jquery-3.7.1.min.js"></script>

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
    </script>

</body>
</html>