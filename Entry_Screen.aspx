﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Entry_Screen.aspx.cs" Inherits="VMS.Entry_Screen" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
   
    <title style="font:bold">ENTRY SCREEN</title>
    <link rel="icon" href="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png">
    <script src="https://cdn.jsdelivr.net/npm/@zxing/library@0.26.1"></script>
    <script src="https://cdn.jsdelivr.net/npm/html5-qrcode@^2.2.0/html5-qrcode.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/jsqr/dist/jsQR.js"></script>
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
.center-button-container {
    text-align: center;
    margin-top: 50px; /* Adjust as needed */
}

.center-button {
    background-color: #e7e7e7; /* Light gray background */
    border: 1px solid #ddd; /* Add a subtle border */
    color: #333; /* Darker text color */
    padding: 15px 32px;
    text-align: center;
    text-decoration: none;
    display: inline-block;
    font-size: 16px;
    cursor: pointer;
    border-radius: 8px;
    margin-left: 695px;
    margin-top: 393px;
}

.center-button:hover {
    background-color: #e5e5e5; /* Slightly darker gray on hover */
}
  span:hover {
     animation: blink 1s infinite;
     color: #0066ff; /* Change this color to suit your background */
     text-decoration: none; /* Remove underline */
 }

    </style>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>

</head>
<body>
    
    <form id="form1" runat="server" >
        <header>
            <img src="https://foreselastomech.com/wp-content/uploads/2019/03/FORES-Logo.png" alt="Logo" />
            <div class="header-name">ENTRY SCREEN</div>
        </header>
        <div class="icon-sidebar " id="sidebar" >
            <a href="Registration.aspx" id="registrationLink" runat="server">
                <i class='fas fa-user-plus'></i>
                <span  >INVITE VISITOR</span>

            </a>
            <a href="Signup.aspx" id="newVisitorLink" runat="server">
                <i class='fas fa-user-plus'></i>
                <span>NEW VISITORS REGISTRATION</span>
            </a>

             <a href="Employee_Signup.aspx" id="employeelink" runat="server">
     <i class='fas fa-user-plus'></i>
     <span>NEW EMPLOYEE REGISTRATION</span>
 </a>
        </div>

      <div class="container">
  <div class="row justify-content-center">
    <div class="col-sm-6 text-center"> <!-- Adjust column size based on your layout -->
      <asp:Button ID="centerButton" runat="server" class="btn btn-primary" Text="Scan QR Code Here" OnClientClick="openCamera(); return false;" OnClick="centerButton_Click1" />
    </div>
    <div class="col-sm-6 text-center mt-4  col-md-4 "> <!-- Adjust column size based on your layout -->
      <asp:Button ID="btnconform" runat="server" class="btn btn-primary" Text="Confirm" OnClientClick="opencamere_forconform(); return false;" />
    </div>
  </div>
</div>
        <div id="camera-preview"class="col-ml-6 " ></div>
    
    
    </form>
    <script>


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
                        video.style.left = '65vh';
                        video.style.width = '40%';
                        video.style.height = '40%';
                        video.style.objectFit = 'cover';
                        video.style.zIndex = '9999';

                        // Attach the stream to the video element
                        video.srcObject = stream;

                        // Append the video element to the body
                        document.body.appendChild(video);

                        // Continuously capture frames from the video stream
                        setInterval(function () {
                            var canvas = document.createElement('canvas');
                            canvas.width = video.videoWidth;
                            canvas.height = video.videoHeight;
                            var context = canvas.getContext('2d');
                            context.drawImage(video, 0, 0, canvas.width, canvas.height);
                            var imageData = context.getImageData(0, 0, canvas.width, canvas.height);
                            var code = jsQR(imageData.data, imageData.width, imageData.height);
                            if (code) {
                                console.log('QR code detected:', code.data);
                                // Do something with the decoded data (e.g., display it on the page)
                               
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

                // Determine device type
                var isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);

                // Request access to the appropriate camera based on the device type
                var constraints = {
                    video: {}
                };

                if (isMobile) {
                    // If it's a mobile device, request access to the back camera
                    constraints.video.facingMode = 'environment';
                } else {
                    // If it's a desktop device, request access to the default camera (front camera)
                    constraints.video = true;
                }

                navigator.mediaDevices.getUserMedia(constraints)
                    .then(function (stream) {
                        // Create a video element to display the camera stream
                        var video = document.createElement('video');
                        video.setAttribute('autoplay', '');
                        video.setAttribute('playsinline', '');

                       // video.style.position = 'fixed';
                        video.style.top = '17vh';
                        video.style.left = '65vh';
                        video.style.width = '40%';
                        video.style.height = '40%';
                        video.style.objectFit = 'cover';
                        video.style.zIndex = '9999';
                        video.style.marginLeft = '150px';
                        video.style.marginTop = '100px';


                        // Attach the stream to the video element
                        video.srcObject = stream;

                        // Append the video element to the body
                        document.body.appendChild(video);

                        // Continuously capture frames from the video stream
                        setInterval(function () {
                            var canvas = document.createElement('canvas');
                            canvas.width = video.videoWidth;
                            canvas.height = video.videoHeight;
                            var context = canvas.getContext('2d');
                            context.drawImage(video, 0, 0, canvas.width, canvas.height);
                            var imageData = context.getImageData(0, 0, canvas.width, canvas.height);
                            var code = jsQR(imageData.data, imageData.width, imageData.height);
                            if (code) {
                                console.log('QR code detected:', code.data);
                                // Do something with the decoded data (e.g., display it on the page)
                                Conform_meeting(code.data);
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



        // code for conformation

        //function opencamere_forconform() {
        //    // Check if getUserMedia is available
        //    if (navigator.mediaDevices && navigator.mediaDevices.getUserMedia) {
        //        // If there's already an active camera stream, stop it and remove the video element
        //        var existingVideo = document.querySelector('video');
        //        if (existingVideo) {
        //            existingVideo.srcObject.getTracks().forEach(track => track.stop());
        //            existingVideo.remove();
        //            return;
        //        }

        //        // Request access to the camera
        //        navigator.mediaDevices.getUserMedia({ video: { facingMode: 'environment' } })
        //      //  navigator.mediaDevices.getUserMedia({ video: true })
        //            .then(function (stream) {
        //                // Create a video element to display the camera stream
        //                var video = document.createElement('video');
        //                video.setAttribute('autoplay', '');
        //                video.setAttribute('playsinline', '');

        //                video.style.position = 'fixed';
        //                video.style.top = '17vh';
        //                video.style.left = '65vh';
        //                video.style.width = '40%';
        //                video.style.height = '40%';
        //                video.style.objectFit = 'cover';
        //                video.style.zIndex = '9999';

        //                // Attach the stream to the video element
        //                video.srcObject = stream;

        //                // Append the video element to the body
        //                document.body.appendChild(video);

        //                // Continuously capture frames from the video stream
        //                setInterval(function () {
        //                    var canvas = document.createElement('canvas');
        //                    canvas.width = video.videoWidth;
        //                    canvas.height = video.videoHeight;
        //                    var context = canvas.getContext('2d');
        //                    context.drawImage(video, 0, 0, canvas.width, canvas.height);
        //                    var imageData = context.getImageData(0, 0, canvas.width, canvas.height);
        //                    var code = jsQR(imageData.data, imageData.width, imageData.height);
        //                    if (code) {
        //                        console.log('QR code detected:', code.data);
        //                        // Do something with the decoded data (e.g., display it on the page)
        //                        Conform_meeting(code.data);
                               
        //                    }
        //                }, 100); // Adjust the interval as needed (e.g., every second)
        //            })
        //            .catch(function (error) {
        //                // Handle errors
        //                console.error('Error accessing camera:', error);
        //            });
        //    } else {
        //        alert('getUserMedia is not supported in this browser');
        //    }
        //}
        // create method to exicute controller method 

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
                    alert('Error saving QR ' + error.message);
                });
        }

        function saveQRDataToDatabase(qrData) {
            // Send an AJAX request to the server
           
            fetch('/Home/SaveQRData', {
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
                       // throw new Error('responce is not send ');

                    }
                })
                .then(message => {
                    // Display the returned message as an alert
                    alert(message);
                   
                })
                .catch(error => {
                    // Handle error, display an error message
                    alert('exception == ' + error.message);
                });
        }

    </script>
   
</body>
</html>  