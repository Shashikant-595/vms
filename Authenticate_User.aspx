<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Authenticate_User.aspx.cs" Inherits="VMS.Authenticate_User" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <title>login</title>
    <style>
        .login-container {
            border: thick;
            padding: 5%;
            border-radius: 20px;
            box-shadow: 0 0 20px rgb(0, 0, 0);
            width: 80%;
            height: 60%;
            max-width: 500px;
            margin: auto;
        }

        .login-button {
            width: 60%;
            margin-top: 20px;
            border-radius: 20px;
        }

        #lblpassword,
        #lblusername {
            color: black;
            font-weight: 600;
        }

        .password-toggle-icon {
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
</head>
<body id="login-body">
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12" id="header" style="background-color: aqua;">
                <marquee style="font-weight: bold; font-size: larger;">Welcome to the Fores Elastomech Visitor Management System</marquee>
            </div>
        </div>
        <div class="container-1 mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6 login-container" style="background-color: aqua; background-image: url('images/fores_vms.jpg');">
                    <h3 class="text-center mb-2">Login</h3>
                    <form id="form1" runat="server">
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <div class="form-group p-1">
                            <asp:Label ID="lblusername" runat="server" CssClass="mb-3">User ID</asp:Label>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>


                        <div class="form-group p-1">
                            <asp:Label ID="lblpassword" runat="server" CssClass="mb-3">Password</asp:Label>
                            <div class="input-group">
                                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" onfocus="showIcon(this)" onblur="hideIcon(this)"></asp:TextBox>
                                <span id="eyeIcon2" class="toggle-password" onclick="togglePasswordVisibility('txtPassword')" style="position: absolute; top: 50%; transform: translateY(-50%); right: 10px; cursor: pointer;" aria-hidden="False"><i class="fa fa-eye"></i></span>
                            </div>


                        </div>
                         <div class="form-group text-center">
     <asp:Button ID="loginbtn" runat="server" Text="Login" CssClass="btn btn-primary login-button" OnClick="loginbtn_Click" />
 </div>
                        </form>
                </div>
               
               
            </div>
        </div>
    </div>
    

   
<script>
    function togglePasswordVisibility(inputId) {
        const passwordInput = document.getElementById(inputId);
        const eyeIcon = document.getElementById('eyeIcon2');

        if (passwordInput.type === 'password') {
            passwordInput.type = 'text';
            eyeIcon.innerHTML = '<i class="fa fa-eye-slash"></i>'; // Change icon to hide
        } else {
            passwordInput.type = 'password';
            eyeIcon.innerHTML = '<i class="fa fa-eye"></i>'; // Change icon to show
        }
    }
</script>

</body>
</html>
