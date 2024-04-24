<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Master_BOM.aspx.cs" Inherits="Presentation_Layer.Master_BOM" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <title>BOM Mater</title>
    <style>
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <div class="col-md-12" id="header">
                <h3>BOM Master</h3>
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
                        <li><a class="dropdown-item" href="Home Page.aspx">User Master</a></li>
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
                <div class="dropdown mb-3">
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

            <div class="col-md-10 col-sm-2" id="content">
                <form id="form1" runat="server">
                    <div class="container mt-4">
                        <div class="row  p-1">
                            <div class="col-sm-4 col-md-3 justify-content-center ">
                                <asp:Label runat="server" AssociatedControlID="MaterialSapDropList" CssClass="font-weight-bold">Material SAP Code:</asp:Label>
                                <asp:DropDownList ID="MaterialSapDropList" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="--Select--" Value="0" /> 
                                </asp:DropDownList>
                                 <asp:TextBox ID="txtMaterialSapcode" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-6 col-md-5">
                                <asp:Label runat="server" AssociatedControlID="txtMaterialSap" CssClass="font-weight-bold">Material Description:</asp:Label>
                                <asp:TextBox ID="txtMaterialSapdesc" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>

                            <div class="col-sm-4 col-md-3">
                                <asp:Label runat="server" AssociatedControlID="txtCategory" CssClass="font-weight-bold">Category:</asp:Label>
                                <asp:TextBox ID="txtCategory" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>


                        <asp:Panel runat="server">
                            <div class="row border border-dark rounded p-1 mt-1">
                                <h5>Compound</h5>
                                <div class="col-sm-3 col-md-3">
                                    <asp:Label runat="server" CssClass="font-weight-bold">Compound SAP Code:</asp:Label>
                                    <asp:TextBox ID="cmb_compoundsapcode" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3">
                                    <asp:Label runat="server" AssociatedControlID="txtCompoundDescription" CssClass="font-weight-bold">Compound Description:</asp:Label>
                                    <asp:TextBox ID="txtCompoundDescription" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3">
                                    <asp:Label runat="server" AssociatedControlID="txtCompBaseQty" CssClass="font-weight-bold">Quantity</asp:Label>
                                    <asp:TextBox ID="txtCompBaseQty" runat="server" CssClass="form-control">1</asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3">
                                    <asp:Label runat="server" AssociatedControlID="txtCompBomQty" CssClass="font-weight-bold">UOM</asp:Label>
                                    <asp:TextBox ID="txtCompBomQty" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </asp:Panel>

                        <asp:Panel runat="server">
                            <div class="row border border-dark rounded p-1 mt-1">
                                <h5 class="col-12">Metal</h5>
                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:Label runat="server" CssClass="font-weight-bold">Metal SAP Code:</asp:Label>
                                    <asp:TextBox ID="cmb_metal1sapcode" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:Label runat="server" AssociatedControlID="txtMetalDescription_1" CssClass="font-weight-bold">Metal Description:</asp:Label>
                                    <asp:TextBox ID="txtMetalDescription_1" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:Label runat="server" AssociatedControlID="txtMetalBaseQty_1" CssClass="font-weight-bold">Quantity</asp:Label>
                                    <asp:TextBox ID="txtMetalBaseQty_1" runat="server" CssClass="form-control">1</asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:Label runat="server" AssociatedControlID="txtMetalBomQty_1" CssClass="font-weight-bold">UOM</asp:Label><asp:Button ID="Button1" runat="server" Text="+" /><asp:Button ID="Button2" runat="server" Text="-" />
                                    <asp:TextBox ID="txtMetalBomQty_1" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:TextBox ID="cmb_metal2Sapcode" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:TextBox ID="txtMetalDescription_2" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:TextBox ID="txtMetalBaseQty_2" runat="server" CssClass="form-control">1</asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:TextBox ID="txtMetalBomQty_2" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                   <asp:TextBox ID="cmb_metal3sapcode" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:TextBox ID="txtMetalDescription_3" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:TextBox ID="txtMetalBaseQty_3" runat="server" CssClass="form-control">1</asp:TextBox>
                                </div>

                                <div class="col-sm-3 col-md-3 p-1 mt-1">
                                    <asp:TextBox ID="txtMetalBomQty_3" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </asp:Panel>


                        <div class="row justify-content-center mt-2 p-3 ">
                            <div class="col-sm-12 text-center">
                                <asp:Button runat="server" Text="Save" CssClass="btn btn-success btn-lg w-50" />
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="Scripts/jquery-3.4.1.min.js"></script>
    <script src="Scripts/bootstrap.bundle.min.js"></script>
</body>
</html>

