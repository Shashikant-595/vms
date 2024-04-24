<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Authenticate_User.aspx.cs" Inherits="VMS.Authenticate_User" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
   
<head runat="server" >
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <title>login</title>
    <style>
      
      
        .login-container {
         /* background-color: #ffffff;*/
           
            border:thick;
            padding: 5%; /* Adjust padding to be responsive */
            border-radius: 20px;
            box-shadow: 0 0 20px rgb(0, 0, 0);
            width: 80%; /* Set width as a percentage of viewport width */
            height: 60%; /* Set height as a percentage of viewport height */
            max-width: 500px; /* Set max-width for better responsiveness */
            margin:auto;
        }

        .login-button {
            width: 60%; /* Make the button full width */
            margin-top: 20px; /* Add some top margin */
            border-radius: 20px;
        }
       #lblpassword{
            color:black;
            font-weight:600;
        }
        #lblusername{
              color:black;
              font-weight:600;
        }
         span:hover {
    animation: blink 1s infinite;
    color: #0066ff; /* Change this color to suit your background */
    text-decoration: none; /* Remove underline */
}
    </style>
</head>
<body id="login-body" >
   
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12" id="header" style="background-color:aqua;">
               
                 <marquee style="font-weight:bold;font-size:larger">Welcome to the Fores Elastomech Visitor Management System</marquee>
            </div>
        </div>
        
        <div class="container-1 mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6 login-container" style="  background-color :aqua; background-image:url('images/fores_vms.jpg'); ">
                    <h3 class="text-center mb-2">Login</h3>
                    <form id="form1" runat="server">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <div class="form-group p-1">
                            <asp:Label ID="lblusername" runat="server" CssClass="mb-3">User ID</asp:Label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="form-group p-1">
                            <asp:Label ID="lblpassword" runat="server" CssClass="mb-3">Password</asp:Label>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                        </div>
                        <div class="form-group text-center">
                            <asp:Button ID="loginbtn" runat="server" Text="Login" CssClass="btn btn-primary login-button" OnClick="loginbtn_Click" />
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.bundle.min.js"></script>
</body>
</html>
