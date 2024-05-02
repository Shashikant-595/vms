<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="VMS.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Visitor Management System - Dashboard</title>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-XXEtcRoHS9bLVzIBb8dlUbaD5aykaf4u50c4+WCohgFjm4C8FaEzC1Kj2Ml3sH1R3T8MEXMm1kVhuvbfYjZKdA==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="Scripts/jquery-3.7.1.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
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
            z-index: 1; /* Ensure the sidebar is above other content */
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
                    display: block;
                    font-size: 14px;
                }

                .icon-sidebar a span {
                    display: none;
                    opacity: 0;
                    transition: opacity 0.3s;
                }

            .icon-sidebar:hover a i {
                display: inline;
            }

            .icon-sidebar:hover a span {
                display: inline;
                opacity: 1;
            }

        .content {
            padding-left: 60px;
            transition: padding-left 0.3s;
        }

        .icon-sidebar:hover {
            width: 180px;
        }

        .chart-container {
            height: 400px;
            width: 100%;
            overflow-y: auto;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <header>
            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" />
            <div class="header-name">DASHBOARD</div>
        </header>
        <div class="container-fluid px-0 ">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-2">
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
                        <a href="Registration.aspx">
                            <i class='fas fa-user-plus'></i>
                            <span>INVITE VISITOR</span>
                        </a>
                    </div>
                </div>
                <!-- Content -->
                <div class="col-md-10">
                    <section class="content">
                        <div class="container mt-4">
                            <div class="row">
                                <div class="col-md-3">
                                    <div class="card h-100 bg-info">
                                        <div class="card-body">
                                            <h5 class="card-title text-white">Total Visitors</h5>
                                            <asp:Label ID="totalVisitorsLabel" runat="server" Text=""></asp:Label>
                                            <asp:UpdatePanel ID="cardUpdatePanel" runat="server" UpdateMode="Conditional">
                                                <ContentTemplate>
                                                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                                </ContentTemplate>
                                                <Triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="__PAGE" EventName="Load" />
                                                </Triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card h-100 bg-success">
                                        <div class="card-body">
                                            <h5 class="card-title text-white">Visitors This Month</h5>
                                            <h3 id="visitorsThisMonth" class="card-text text-white">0</h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card h-100 bg-warning">
                                        <div class="card-body">
                                            <h5 class="card-title text-white">Most Visited Employee</h5>
                                            <h3 id="mostVisitedEmployee" class="card-text text-white">N/A</h3>
                                            <hr />
                                            <h6 class="text-white">Top 5 Most Visited Employees:</h6>
                                            <button id="toggleEmployeeList" class="btn btn-outline-light btn-sm mb-2" style="display: none;" onclick="toggleEmployeeList()">Show Employees</button>
                                            <ul id="topVisitedEmployees" class="text-white" style="display: none;"></ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="card h-100 bg-danger">
                                        <div class="card-body">
                                            <h5 class="card-title text-white">Bounce Rate</h5>
                                            <h3 id="bounceRate" class="card-text text-white">0%</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row mt-4">
                                <div class="col-lg-7 connectedSortable text-center mt-4">
                                    <div class="card">
                                        <div class="card-header">
                                            <h3 class="card-title">
                                                <i class="fas fa-chart-pie mr-1"></i>
                                                Sales
                                            </h3>
                                            <div class="card-tools">
                                                <ul class="nav nav-pills ml-auto">
                                                    <li class="nav-item">
                                                        <a class="nav-link active" href="#revenue-chart" data-toggle="tab">Area</a>
                                                    </li>
                                                    <li class="nav-item">
                                                        <a class="nav-link" href="#sales-chart" data-toggle="tab">Donut</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="row mt-4">
                                            <div class="col-md-12 chart-container">
                                                <canvas id="totalVisitorChart" style="height: 300px;"></canvas>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-5">
                                    <canvas id="visitorChart" style="height: 400px; width: 100%;"></canvas>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
