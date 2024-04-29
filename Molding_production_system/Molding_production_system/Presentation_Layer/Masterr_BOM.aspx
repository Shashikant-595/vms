<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Masterr_BOM.aspx.cs" Inherits="Presentation_Layer.Masterr_BOM" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" />
    <style>
        table {
            border: none;
            margin-top: 10px;
        }

            table tr td {
                padding-left: 10px;
                padding-right: 10px;
                padding-top: 10px;
            }

        #heading {
            margin-top: 200px;
        }

        .header {
            background-color: gray;
        }

        #txt_userlogin{
            border-radius:50px;
            width:200px;
        }

        .navbar{
            background-color:lightgrey;
            width: 200px;
            height: 650px;
            float: left;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="Container">
            <%--  This is header class --%>
            <div class="header">
                <div class="row">
                    <div class="col-md-2">
                        <asp:Image ID="img_foreslogo" runat="server" ImageUrl="img/fores.ico" CssClass="img-fluid" Height="70" Width="70" />
                    </div>
                    <div class="col-md-7 pt-3 text-center">
                        <asp:Label ID="lbl_heading" runat="server" Text="Bill Of Material" Font-Size="x-large" Font-Names="Times New Roman" Font-Bold="true"></asp:Label>
                    </div>
                    <div class="col-md-3 pt-3 d-flex align-items-center">
                        <asp:Image ID="img_admin" runat="server" ImageUrl="img/admin.png" CssClass="img-fluid" Height="30" Width="30" />
                        <asp:TextBox ID="txt_userlogin" runat="server" Text="ADMIN" CssClass="form-control text-center ml-2" Font-Size="Medium" Font-Bold="true" Font-Names="times new roman"></asp:TextBox>
                    </div>
                </div>
            </div>

            <%-- This is navbar class --%>
            <div class="navbar">

            </div>
            <%--  This is section class --%>
            <div class="section">
                <table align="center">
                    <%-- Componant Code --%>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_componant" runat="server" Text="Componant" Font-Size="x-large" Font-Names="Times New Roman" Font-Bold="true"></asp:Label></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="text-center">
                            <asp:Label ID="lbl_Materialsapcode" runat="server" Text="Material SAP Code" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>
                        <td class="text-center">
                            <asp:Label ID="lbl_materialdescription" runat="server" Text="Material Description" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>
                        <td class="text-center">
                            <asp:Label ID="lbl_Materialgroup" runat="server" Text="Material Group" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:TextBox ID="txt_sapcode" runat="server" CssClass="form-control text-center" MaxLength="10" OnTextChanged="txt_sapcode_TextChanged" AutoPostBack="true"></asp:TextBox>

                        </td>
                        <td>
                            <asp:TextBox ID="txt_Materialdescription" runat="server" CssClass="form-control text-center"></asp:TextBox></td>
                        <td>
                            <asp:DropDownList ID="cmb_Materialgroup" runat="server" CssClass="form-control text-center">
                                <asp:ListItem>Select Material Group</asp:ListItem>
                            </asp:DropDownList></td>
                    </tr>
                    <%-- Compound Code --%>

                    <tr>
                        <td>
                            <asp:Label ID="lbl_compound" runat="server" Text="Compound" Font-Size="x-large" Font-Names="Times New Roman" Font-Bold="true"></asp:Label></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="text-center">
                            <asp:Label ID="lbl_sapcode" runat="server" Text="SAP Code" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>
                        <td class="text-center">
                            <asp:Label ID="lbl_Description" runat="server" Text="Description" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>
                        <td class="text-center">
                            <asp:Label ID="lbl_Quantity" runat="server" Text="Quantity" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>
                        <td class="text-center">
                            <asp:Label ID="lbl_UOM" runat="server" Text="UOM" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>

                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:TextBox ID="txt_compoundSAPcode" runat="server" CssClass="form-control text-center" MaxLength="10" OnTextChanged="txt_compoundSAPcode_TextChanged"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_compounddescription" runat="server" CssClass="form-control text-center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_compoundQuantity" runat="server" CssClass="form-control text-center" MaxLength="1" Text="1" ReadOnly="true" align="center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_UOM" runat="server" CssClass="form-control text-center" placeholder="GRAMS" MaxLength="2"></asp:TextBox></td>

                    </tr>
                    <%--  Metal  --%>
                    <tr>
                        <td>
                            <asp:Label ID="lbl_Metal" runat="server" Text="Metal" Font-Size="x-large" Font-Names="Times New Roman" Font-Bold="true"></asp:Label></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td class="text-center">
                            <asp:Label ID="lbl_Metalsapcode1" runat="server" Text="SAP Code" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>
                        <td class="text-center">
                            <asp:Label ID="lbl_MetalDescription1" runat="server" Text="Description" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>
                        <td class="text-center">
                            <asp:Label ID="lbl_metalQuantity1" runat="server" Text="Quantity" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>
                        <td class="text-center">
                            <asp:Label ID="lbl_metalUOM1" runat="server" Text="UOM" Font-Size="Medium" Font-Names="Times New Roman" Font-Bold="false"></asp:Label>
                        </td>

                    </tr>
                    <tr id="textboxes1" runat="server">
                        <td></td>
                        <td>
                            <asp:TextBox ID="txt_MetalSapcode1" runat="server" CssClass="form-control text-center" MaxLength="10"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalDescription1" runat="server" CssClass="form-control text-center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalQuantity1" runat="server" CssClass="form-control text-center" MaxLength="1" Text="1" ReadOnly="true" align="center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalUOM1" runat="server" CssClass="form-control text-center" placeholder="NOS" MaxLength="2"></asp:TextBox></td>
                        <td>
                            <asp:ImageButton ID="btnimg_addMetalrow" runat="server" ImageUrl="~/img/add.png" Height="30px" Width="30px" OnClick="btnimg_addMetalrow_Click" /></td>
                    </tr>
                    <tr id="textboxes2" runat="server" visible="false">
                        <td></td>
                        <td>
                            <asp:TextBox ID="txt_MetalSapcode2" runat="server" CssClass="form-control text-center" MaxLength="10"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalDescription2" runat="server" CssClass="form-control text-center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalQuantity2" runat="server" CssClass="form-control text-center" MaxLength="1" Text="1" ReadOnly="true" align="center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalUOM2" runat="server" CssClass="form-control text-center" placeholder="NOS" MaxLength="2"></asp:TextBox></td>
                        <td>
                            <asp:ImageButton ID="btnimg_removemetalrow" runat="server" ImageUrl="~/img/remove.png" Height="30px" Width="30px" OnClick="btnimg_removemetalrow_Click" /></td>
                    </tr>
                    <tr id="textboxes3" runat="server" visible="false">
                        <td></td>
                        <td>
                            <asp:TextBox ID="txt_MetalSapcode3" runat="server" CssClass="form-control text-center" MaxLength="10"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalDescription3" runat="server" CssClass="form-control text-center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalQuantity3" runat="server" CssClass="form-control text-center" MaxLength="1" Text="1" ReadOnly="true" align="center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalUOM3" runat="server" CssClass="form-control text-center" placeholder="NOS" MaxLength="2"></asp:TextBox></td>

                    </tr>
                    <tr id="textboxes4" runat="server" visible="false">
                        <td></td>
                        <td>
                            <asp:TextBox ID="txt_MetalSapcode4" runat="server" CssClass="form-control text-center" MaxLength="10"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalDescription4" runat="server" CssClass="form-control text-center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalQuantity4" runat="server" CssClass="form-control text-center" MaxLength="1" Text="1" ReadOnly="true" align="center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalUOM4" runat="server" CssClass="form-control text-center" placeholder="NOS" MaxLength="2"></asp:TextBox></td>

                    </tr>
                    <tr id="textboxes5" runat="server" visible="false">
                        <td></td>
                        <td>
                            <asp:TextBox ID="txt_MetalSapcode5" runat="server" CssClass="form-control text-center" MaxLength="10"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalDescription5" runat="server" CssClass="form-control text-center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalQuantity5" runat="server" CssClass="form-control text-center" MaxLength="1" Text="1" ReadOnly="true" align="center"></asp:TextBox></td>
                        <td>
                            <asp:TextBox ID="txt_MetalUOM5" runat="server" CssClass="form-control text-center" placeholder="NOS" MaxLength="2"></asp:TextBox></td>

                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td class="text-right">
                            <asp:Button ID="btn_save" runat="server" Text="SAVE" CssClass="btn btn-success" Font-Size="X-Large" Width="200" BorderStyle="Ridge"></asp:Button></td>
                    </tr>
                </table>
            </div>
            <%-- This is Footer class --%>
            <div class="footer">
            </div>
        </div>
    </form>

</body>
</html>

