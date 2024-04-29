<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Signup.aspx.cs" Inherits="VMS.Signup" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
    <title style="font:bold">SIGN UP</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png">
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
.icon-sidebar:hover{
    width:180px;
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
                text-align: center;
                margin-left: 10px;
            }
             span:hover {
    animation: blink 1s infinite;
    color: #0066ff; /* Change this color to suit your background */
    text-decoration: none; /* Remove underline */
}
    </style>
</head>
<body>
    <form id="signup" runat="server">
        <header>
            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" />
            <div class="header-name">NEW VISITORS REGISTRATION</div>
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
                        <a href="Employee_Signup.aspx" id="employeelink" runat="server">
    <i class='fas fa-user-plus'></i>
    <span>NEW EMPLOYEE REGISTRATION</span>
</a>
        </div>

        <div class="center-container">
            <div style="margin-bottom: 20px; margin-left: -48px">
                <asp:Label ID="lblName" runat="server" Text="Visitor Name : "></asp:Label>
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
            </div>
            <div style="margin-bottom: 20px; margin-left: -24px;">
                <asp:Label ID="lblMbNo" runat="server" Text="Mobile No : "></asp:Label>
                <asp:TextBox ID="txtMbNo" runat="server" OnTextChanged="txtMbNo_TextChanged" AutoPostBack="true"></asp:TextBox>
            </div>
            <div style="margin-bottom: 20px; margin-left: 10px;">
                <asp:Label ID="email" runat="server" Text="Email : "></asp:Label>
                <asp:TextBox ID="txtemail" runat="server"></asp:TextBox>
            </div>
            <div style="margin-bottom: 20px; margin-left: -20px;">
                <asp:Label ID="compony" runat="server" Text="Company : "></asp:Label>
                <asp:TextBox ID="txtcompany" runat="server"></asp:TextBox>
            </div>
           
                       <div class="form-group col-sm-3 mt-5">
    <asp:Button ID="btn_submit" runat="server" Text="Register" CssClass="btn btn-primary" OnClick="btn_submit_Click" />
        <asp:Button ID="btn_edit" runat="server" Text="Edit" CssClass="btn btn-primary" OnClick="btn_edit_Click" />
</div>
        </div>
    </form>
</body>
</html>