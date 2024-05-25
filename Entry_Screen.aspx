<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entry_Screen.aspx.cs" Inherits="VMS.Entry_Screen" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">

    <title style="font: bold">ENTRY SCREEN</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png">
    <script src="https://cdn.jsdelivr.net/npm/@zxing/library@0.26.1"></script>
    <script src="https://cdn.jsdelivr.net/npm/html5-qrcode@^2.2.0/html5-qrcode.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jsqr/dist/jsQR.js"></script>
    <style>
        .form-control {
            width: 50%;
            height: 20px;
            border-radius: 8px;
            font-size: 16px;
            margin-bottom: 8px;
        }

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
            width: 30px;
            position: fixed;
            height: 100%;
            transition: width 0.3s;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

            .icon-sidebar a {
                color: black;
                padding: 7px 0;
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

        .logout-btn {
            margin-top: 600px;
            background-color: red;
        }
        /* Center align the visitor count container */


        .auto-style1 {
            position: absolute;
            top: 38px;
            right: -71px;
            width: 111%;
            height: 345px;
        }

        .login-container {
            border: thick;
            padding: 10%;
            border-radius: 30px;
            box-shadow: 0 0 20px rgb(0, 0, 0);
            width: 40%; /* Decreased width */
            height: 120%; /* Increased height */
            max-width: 300px;
            margin: auto;
        }


        .auto-style2 {
            position: absolute;
            top: -53px;
            right: 2px;
            width: 14%;
            height: 406px;
        }

        .form-group label {
            font-size: 1.50rem; /* Adjust the font size of labels */
        }

        .form-control {
            font-size: 1.25rem; /* Adjust the font size of textboxes */
            width: 300px;
            height: 30px;
        }

        ::placeholder {
            font-size: 13px; /* Adjust the font size as needed */
        }
    </style>
    <link href="Conten
        t/bootstrap.min.css"
        rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>

</head>
<body>

    <form id="form1" runat="server">
        <header>

            <!-- Logo and header name code here -->

            <!-- Number of visitors textbox -->



            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" />
            <div class="header-name">ENTRY SCREEN</div>
            <!-- Add the user ID icon and text box -->
            <div id="userIdIcon">
                <i class="fas fa-user sidebar-icon text-primary fa-2x"></i>
                <div id="userIdTextBox" class="input-group" style="border-radius: 10px; margin-top: 10px;">
                    <asp:TextBox ID="userIdInput" runat="server" CssClass="rounded" Style="border-radius: 8px; height: 30px; width: 75px; font-size: 20px;" placeholder="User ID"></asp:TextBox>
                </div>
            </div>

        </header>
        <div class="icon-sidebar" id="sidebar">
            <a href="Registration.aspx" id="registrationLink" runat="server" class="sidebar-link">
                <i class='fas fa-user-plus sidebar-icon'></i>
                <span>INVITE VISITOR</span>
            </a>
            <a href="Signup.aspx" id="newVisitorLink" runat="server" class="sidebar-link">
                <i class='fas fa-user-plus sidebar-icon'></i>
                <span>NEW VISITORS REGISTRATION</span>
            </a>
            <a href="Employee_Signup.aspx" id="employeelink" runat="server" class="sidebar-link">
                <i class='fas fa-user-plus sidebar-icon'></i>
                <span>NEW EMPLOYEE REGISTRATION</span>
            </a>

            <a href="#" id="confirmLink" class="sidebar-link" runat="server" onclick="opencamere_forconform()">
                <i class='fas fa-check sidebar-icon'></i>
                <span>Confirm</span>
            </a>
            <a href="#" id="scanQrLink" class="sidebar-link" runat="server" onclick="openCamera()">
                <i class='fas fa-qrcode sidebar-icon'></i>
                <span>Scan QR</span>
            </a>
            <br />
            <br />
            <br />
            <a href="" class="logout-btn">
                <i class="fas fa-sign-out-alt" id="logoutBtn"></i>
                <span>Logout</span>
            </a>
        </div>

        <div id="camera-preview" class="col-ml-6"></div>


        <div class="visitor-count-container mt-5 d-flex justify-content-center" style="margin-top: 350px; margin-left: 600px">
            <!-- Added "d-flex justify-content-center" classes -->
            <asp:Label ID="visitorCountLabel" runat="server" CssClass="mr-2 font-weight-bold" AssociatedControlID="visitorCountInput" Text="Number of Visitors:"></asp:Label>
            <asp:TextBox ID="visitorCountInput" runat="server" Type="Number" CssClass="form-control rounded" Style="border-radius: 8px; height: 30px; width: 100px;" placeholder="Enter number" required></asp:TextBox>
        </div>
        <div class="auto-style2" style="margin-top: 190px; margin-right: 120px; padding: 5%; border-radius: 20px; box-shadow: 0 0 20px rgb(0, 0, 0);">
            <div class="auto-style1">
                <div class="form-group row">
                    <h2>VISITOR INFORMATION</h2>
                    <div class="form-group row">
                        <label for="txtName" class="col-sm-2 col-form-label">Name</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" required Font-Size="Medium"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="txtMbNo" class="col-sm-2 col-form-label fs-5">Mobile No</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtMbNo" runat="server" CssClass="form-control fs-5" required></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="txtEmail" class="col-sm-2 col-form-label fs-5">Email</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control fs-5" required Font-Size="Medium"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="txtCompany" class="col-sm-2 col-form-label fs-5">Company</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtCompany" runat="server" CssClass="form-control fs-5" required Font-Size="Medium"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="txtMeeting" class="col-sm-2 col-form-label fs-5">Meeting Subject</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="txtMeeting" runat="server" CssClass="form-control fs-5" Font-Size="Medium"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="datetimepicker" class="col-sm-2 col-form-label fs-5">Meeting Date and Time</label>
                        <div class="col-sm-10">
                            <asp:TextBox ID="datetimepicker" runat="server" CssClass="form-control fs-5" Font-Size="Medium"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Adjust button placement
            var iconSidebar = document.getElementById("sidebar");
            var links = iconSidebar.getElementsByClassName("sidebar-link");
            for (var i = 0; i < links.length; i++) {
                links[i].style.marginLeft = (iconSidebar.offsetWidth - links[i].offsetWidth) / 2 + "px";
            }

            // Adjust button size and placement when the window is resized
            window.addEventListener("resize", function () {
                for (var i = 0; i < links.length; i++) {
                    links[i].style.marginLeft = (iconSidebar.offsetWidth - links[i].offsetWidth) / 2 + "px";
                }
            });
        });



        function openCamera() {
            // Check if getUserMedia is available
            if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                // If there's already an active camera stream, stop it and remove the video element
                var existingVideo = document.querySelector('video');
                if (existingVideo) {
                    existingVideo.srcObject.getTracks().forEach(track => track.stop());
                    existingVideo.remove();
                    return;
                }

                // for back camera
                navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } })

                    // Request access to the camera
                    // navigator.mediaDevices.getUserMedia({ video: true })
                    .then(function (stream) {
                        // Create a video element to display the camera stream
                        var video = document.createElement('video');
                        video.setAttribute('autoplay', '');
                        video.setAttribute('playsinline', '');

                        video.style.position = 'fixed';
                        video.style.top = '17vh';
                        video.style.left = '50vh';
                        video.style.width = '40%';
                        video.style.height = '40%';
                        video.style.objectFit = 'cover';
                        video.style.zIndex = '9999';

                        // Attach the stream to the video element
                        video.srcObject = stream;

                        // Append the video element to the body
                        document.body.appendChild(video);

                        // Continuously capture frames from the video stream
                        let intervalId = setInterval(function () {
                            var canvas = document.createElement('canvas');
                            canvas.width = video.videoWidth;
                            canvas.height = video.videoHeight;
                            var context = canvas.getContext('2d');
                            context.drawImage(video, 0, 0, canvas.width, canvas.height);
                            var imageData = context.getImageData(0, 0, canvas.width, canvas.height);
                            var code = jsQR(imageData.data, imageData.width, imageData.height);

                            if (code) {
                                console.log('QR code detected:', code.data);
                                clearInterval(intervalId);
                                video.srcObject.getTracks().forEach(track => track.stop());
                                video.remove();
                                // Do something with the decoded data (e.g., display it on the page)
                                var dataFromQR = splitQRCodeData(code.data);

                                // Assuming you have input boxes with the IDs "txtName", "txtMbNo", "txtEmail", "txtCompany", "txtMeeting", "datetimepicker"
                                var txtName = document.getElementById("<%= txtName.ClientID %>");
                                var txtMbNo = document.getElementById("<%= txtMbNo.ClientID %>");
                                var txtEmail = document.getElementById("<%= txtEmail.ClientID %>");
                                var txtCompany = document.getElementById("<%= txtCompany.ClientID %>");
                                var txtMeeting = document.getElementById("<%= txtMeeting.ClientID %>");
                                var datetimepicker = document.getElementById("<%= datetimepicker.ClientID %>");

                                if (txtName && dataFromQR.length > 3) {
                                    txtName.value = dataFromQR[3] || '';
                                }
                                if (txtMbNo && dataFromQR.length > 2) {
                                    txtMbNo.value = dataFromQR[2] || '';
                                }
                                if (txtEmail && dataFromQR.length > 1) {
                                    txtEmail.value = dataFromQR[1] || '';
                                }
                                if (txtCompany && dataFromQR.length > 4) {
                                    txtCompany.value = dataFromQR[4] || '';
                                }
                                if (txtMeeting && dataFromQR.length > 0) {
                                    txtMeeting.value = dataFromQR[0] || '';
                                }
                                if (datetimepicker && dataFromQR.length > 5) {
                                    datetimepicker.value = dataFromQR[5] || '';
                                }

                                saveQRDataToDatabase(code.data);

                            }
                        }, 100); // Adjust the interval as needed (e.g., every second)
                    })
                    .catch(function (error) {
                        // Handle errors
                        console.error('Error accessing camera:', error);
                    });
            } else {
                alert('getUserMedia is not supported in this browser');
            }
        }
        function splitQRCodeData(data) {
            // Split the QR code data using '/' as the delimiter
            const parts = data.split('/');
            // Extract date and time parts (6th, 7th, and 8th indexes), excluding the 9th index
            const dateAndTime = `${parts[5]} ${parts[6]} ${parts[7]}`;
            return [...parts.slice(0, 5), dateAndTime];
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

        // code for conformation

        let isMessageShown = false;
        let isSaveMessageShown = false;

        function opencamere_forconform() {
            // Check if getUserMedia is available
            if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
                // If there's already an active camera stream, stop it and remove the video element
                var existingVideo = document.querySelector('video');
                if (existingVideo) {
                    existingVideo.srcObject.getTracks().forEach(track => track.stop());
                    existingVideo.remove();
                    return;
                }

                // Request access to the camera
                navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } })
                    .then(function (stream) {
                        // Create a video element to display the camera stream
                        var video = document.createElement('video');
                        video.setAttribute('autoplay', '');
                        video.setAttribute('playsinline', '');

                        video.style.position = 'fixed';
                        video.style.top = '17vh';
                        video.style.left = '50vh';
                        video.style.width = '40%';
                        video.style.height = '40%';
                        video.style.objectFit = 'cover';
                        video.style.zIndex = '9999';

                        // Attach the stream to the video element
                        video.srcObject = stream;

                        // Append the video element to the body
                        document.body.appendChild(video);

                        // Continuously capture frames from the video stream
                        let intervalId = setInterval(function () {
                            var canvas = document.createElement('canvas');
                            canvas.width = video.videoWidth;
                            canvas.height = video.videoHeight;
                            var context = canvas.getContext('2d');
                            context.drawImage(video, 0, 0, canvas.width, canvas.height);
                            var imageData = context.getImageData(0, 0, canvas.width, canvas.height);
                            var code = jsQR(imageData.data, imageData.width, imageData.height);
                            if (code) {
                                console.log('QR code detected:', code.data);
                                clearInterval(intervalId);  // Stop capturing frames
                                video.srcObject.getTracks().forEach(track => track.stop());  // Stop the video stream
                                video.remove();  // Remove the video element

                                if (!isMessageShown) {
                                    isMessageShown = true;
                                    Conform_meeting(code.data);
                                }
                            }
                        }, 100); // Adjust the interval as needed (e.g., every second)
                    })
                    .catch(function (error) {
                        // Handle errors
                        console.error('Error accessing camera:', error);
                    });
            } else {
                alert('getUserMedia is not supported in this browser');
            }
        }

        function Conform_meeting(qrData) {
            // Send an AJAX request to the server
            fetch('Home/Conform_meeting', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ qrData: qrData })
            })
                .then(response => {
                    if (response.ok) {
                        // Response was successful, handle success message
                        return response.text(); // Extract response text
                    } else {
                        // Response was not successful, handle error message
                        throw new Error('Network response was not ok');
                    }
                })
                .then(message => {
                    // Display the returned message as an alert
                    alert(message);
                })
                .catch(error => {
                    // Handle error, display an error message
                    alert('Error saving QR: ' + error.message);
                });
        }

        function saveQRDataToDatabase(qrData) {
            if (isSaveMessageShown) return;

            var visitorCount = parseInt(document.getElementById("<%= visitorCountInput.ClientID %>").value);
    var token = extractTokenFromQRData(qrData); // Implement this function to extract token from qrData

    fetch('/Home/SaveQRData', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ qrData: qrData })
    })
        .then(response => {
            if (response.ok) {
                return response.text();
            } else {
                throw new Error('Failed to save QR data');
            }
        })
        .then(message => {
            isSaveMessageShown = true;
            alert(message);
            updateVisitorCountInDatabase(visitorCount, token);
        })
        .catch(error => {
            console.error('Error saving QR data:', error);
            
        });
}

        function updateVisitorCountInDatabase(visitorCount, token) {
            fetch('/Entry_Screen.aspx/UpdateVisitorCount', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ visitorCount: visitorCount, token: token })
            })
                .then(response => {
                    if (response.ok) {
                        console.log('Visitor count updated successfully.');
                    } else {
                        throw new Error('Failed to update visitor count');
                    }
                })
                .catch(error => {
                    console.error('Error updating visitor count:', error);
                    //alert('Error updating visitor count: ' + error.message);
                });
        }

        function extractTokenFromQRData(qrData) {
            // Implement your logic to extract the token from qrData
            // For example, if qrData is a string in the format "data1/data2/token/data4", you can split it
            var parts = qrData.split('/');
            return parts[9]; // Assuming the token is at the third position
        }


        document.querySelector(".logout-btn").addEventListener("click", function (event) {
            event.preventDefault(); // Prevent default navigation

            // Send an asynchronous POST request to the server for logout
            fetch('/Entry_Screen.aspx', { // Replace with your actual logout handler URL
                method: 'POST'
            })
                .then(response => {
                    if (response.ok) {
                        // Logout successful, clear session information (client-side)
                        sessionStorage.clear(); // Clear session storage for client-side data

                        // Replace the current URL in the browser history with the login page
                        history.replaceState(null, null, '/Authenticate_User.aspx');

                        // Redirect to login page
                        window.location.href = '/Authenticate_User.aspx';
                    } else {
                        console.error('Logout failed with status:', response.status);
                        // Handle logout failure (optional: display error message)
                    }
                })
                .catch(error => {
                    console.error('Error logging out:', error);
                    // Handle network errors (optional: display error message)
                });
        });

    </script>
</body>
</html>
