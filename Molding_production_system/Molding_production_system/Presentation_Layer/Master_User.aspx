<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Master_User.aspx.cs" Inherits="Presentation_Layer.Master_User" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <title>Molding Production System</title>
    <style>
        table {
            border: none;
            width: auto;
            height: 200px;
            box-shadow: 0 0 20px rgb(0, 0, 0);
            border-radius: 25px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12" id="header">
                <h3>Master User</h3>
            </div>
        </div>

        <div class="row">
            <div class="col-md-2 " id="sidebar">
                <!-- Dropdown 1 -->
                <div class="dropdown mb-3">
                    <span class="dropdown-toggle" href="#" role="button" id="DropdownMaster" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="img/Master_setting.png" alt="Icon" style="width: 20px; height: 20px;" />
                        <span class="ms-1 hidden-text">Master</span>
                    </span>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink1">
                        <li><a class="dropdown-item" href="#">User Master</a>
                            <ul>
                                <li><a class="dropdown-item" href="Master_User.aspx" onclick="handleButtonClick('save'); return false;">SAVE</a></li>
                                <li><a class="dropdown-item" href="Master_User.aspx" onclick="handleButtonClick('edit'); return false;">Edit</a></li>
                            </ul>
                        </li>
                        <li><a class="dropdown-item" href="Cell Master.aspx">Cell Master</a></li>
                        <li><a class="dropdown-item" href="Machine_Master.aspx">Machine Master</a></li>
                        <li><a class="dropdown-item" href="Category_Master.aspx">Category Master</a></li>
                        <li><a class="dropdown-item" href="Product_Master.aspx">Product Master</a></li>
                        <li><a class="dropdown-item" href="BOM_Master.aspx">BOM Master</a></li>
                        <li><a class="dropdown-item" href="#">Mold PPS Master</a></li>
                        <li><a class="dropdown-item" href="Down_Time_Master.aspx">Down Time Master</a></li>
                    </ul>
                </div>

                <!-- Dropdown 2 -->
                <div class="dropdown mb-3">
                    <span class="dropdown-toggle" href="#" role="button" id="DropdownEntry" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="img/DataEntry.png" alt="Icon" style="width: 20px; height: 20px;" />
                        <span class="ms-1 hidden-text">Entry</span>
                    </span>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink2">
                        <li><a class="dropdown-item" href="User Master.aspx">Entry Screen Control</a></li>
                        <li><a class="dropdown-item" href="Cell Master.aspx">Down Time Screen</a></li>
                        <li><a class="dropdown-item" href="Machine_Master.aspx">Mold Load Unload</a></li>
                    </ul>
                </div>

                <!-- Dropdown 3 -->
                <div class = "dropdown mb-3">
                    <span class="dropdown-toggle" href="#" role="button" id="DropdownReport" data-bs-toggle="dropdown" aria-expanded="false">
                        <img src="img/report.png" alt="Icon" style="width: 20px; height: 20px;" />
                        <span class="ms-1 hidden-text">Report</span>
                    </span>
                    <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink3">
                        <li><a class="dropdown-item" href="User Master.aspx">Daily Production Report </a></li>
                        <li><a class="dropdown-item" href="Cell Master.aspx">Shift Production Report</a></li>
                    </ul>
                </div>
            </div>

            <%-- ################## Section Code ###############3 --%>

            <div class="col-md-10 col-sm-2" id="content">
                <div class="container-1 mt-5">
                    <div class="row justify-content-center">
                        <div class="col-md-6 login-container">
                            <form id="form1" runat="server">
                                <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                <table align="center">
                                    <tr>
                                        <td class="form-group text-center p-3">
                                            <asp:Label ID="lbl_userType" runat="server" CssClass="mb-3" Font-Names="Times New Roman">User Type</asp:Label></td>
                                        <td class="form-group text-center p-2">
                                            <asp:DropDownList ID="cmb_UserType" CssClass="form-control" runat="server">
                                                <asp:ListItem>User</asp:ListItem>
                                                <asp:ListItem>Supervisor</asp:ListItem>
                                                <asp:ListItem>Admin</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="form-group text-center p-3">
                                            <asp:Label ID="lblusername" runat="server" CssClass="mb-3" Font-Names="Times New Roman">User ID</asp:Label></td>
                                        <td class="form-group p-3">
                                            <asp:TextBox ID="txtusername" runat="server" CssClass="form-control"></asp:TextBox>
                                            <%--</td>
                                        <td>--%>
                                            <asp:DropDownList ID="cmb_updateuser" CssClass="form-control" runat="server" OnSelectedIndexChanged="cmb_updateuser_SelectedIndexChanged"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="form-group text-center p-3">
                                            <asp:Label ID="lblpassword" runat="server" CssClass="mb-3" Font-Names="Times New Roman">Password</asp:Label></td>
                                        <td class="form-group p-3">
                                            <asp:TextBox ID="txtpassword" runat="server" CssClass="form-control" TextMode="Password"/></td>
                                    </tr>
                                    <tr class="form-group text-center mt-3">
                                        <td colspan="2" align="center">
                                            <asp:Button ID="btnSave" runat="server" Text="SAVE" CssClass="btn btn-success" OnClick="btnSave_Click" />
                                            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>



    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.bundle.min.js"></script>
</body>
</html>


