<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="Inventory.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Inventory</title>
    <link href="../Content/assets/css/bootstrap.min.css" rel="stylesheet" />

    <script src="Content/assets/js/jquery-3.7.1.min.js"></script>
    <script src="Content/assets/plugins/toastr/toastr.min.js" type="text/javascript"></script>
    <script src="Content/assets/plugins/toastr/toastr.js" type="text/javascript"></script>

    <!-- Toatr CSS -->		
    <link rel="stylesheet" href="../Content/assets/plugins/toastr/toatr.css" />

    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="../Content/assets/plugins/fontawesome/css/fontawesome.min.css" />
    <link rel="stylesheet" href="../Content/assets/plugins/fontawesome/css/all.min.css" />

    <!-- Main CSS -->
    <link rel="stylesheet" href="../Content/assets/css/style.css" />
       <!-- jQuery -->
   <script src="~/Content/assets/js/jquery-3.7.1.min.js" type="15507f26746588018229fdf3-text/javascript"></script>

    <link rel="stylesheet" href="Content/assets/plugins/alertify/alertify.min.css" />

    <!-- Layout Js -->
    <script src="~/Content/assets/js/layout.js" type="15507f26746588018229fdf3-text/javascript"></script>
    <script language="javascript" type="text/javascript">
        function validationform() {
            var User = document.getElementById("txtUserName").value;
            var pass = document.getElementById("txtuserpass").value;
            if (User == "" && pass == "") {
                alertify.error("Username and password are Necessory ! plz enter & try again...");
                document.getElementById("txtUserName").focus();
                return false;
            } else if (User == "") {
                alertify.error("plz Enter Username ");
                document.getElementById("txtUserName").focus();
                return false;
            } else if (pass == "") {
                alertify.error("plz Enter password");
                document.getElementById("txtuserpass").focus();
                return false;
            }

            return true;
        }
    </script>

</head>
<body>

    <!-- Main Wrapper -->
    <div class="main-wrapper login-body">
        <div class="login-wrapper">
            <div class="container">
                <img class="img-fluid logo-dark mb-2 logo-color" src="../../Content/assets/img/logo2.png" alt="Logo" />
                <img class="img-fluid logo-light mb-2" src="../../Content/assets/img/logo2-white.png" alt="Logo" />
                <div class="loginbox">

                    <div class="login-right">
                        <div class="login-right-wrap">
                            <h1>Login</h1>
                            <p class="account-subtitle">Access to our dashboard</p>
                            <form id="form1" runat="server">
                                <div class="input-block mb-3">
                                    <label class="form-control-label">Email Address</label>
                                    <asp:TextBox ID="txtUserName"
                                        CssClass="form-control" Text="Admin" runat="server">
                                    </asp:TextBox>
                                </div>
                                <div class="input-block mb-3">
                                    <label class="form-control-label">Password</label>
                                    <div class="pass-group">
                                        <asp:TextBox ID="txtuserpass" Text="Admin@123" CssClass="form-control pass-input" runat="server" TextMode="Password"></asp:TextBox>
                                        <span class="fas fa-eye toggle-password"></span>
                                    </div>
                                </div>
                                <%--                                <button class="btn btn-lg  btn-primary w-100" type="submit">Login</button>--%>
                                <asp:Button ID="txtlogin" CssClass="btn btn-lg  btn-primary w-100" runat="server" Text="Login" OnClick="login_Click" OnClientClick="return validationform() " />
                                <asp:Label ID="lblMEssage" runat="server" CssClass=" my-5" BackColor="Green" ForeColor="Wheat"></asp:Label>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /Main Wrapper -->

    <!-- Theme Setting -->


    <!-- /Theme Setting -->
 

    <!-- Bootstrap Core JS -->
    <script src="~/Content/assets/js/bootstrap.bundle.min.js" type="15507f26746588018229fdf3-text/javascript"></script>

    <!-- Theme Settings JS -->
    <script src="~/Content/assets/js/theme-settings.js" type="15507f26746588018229fdf3-text/javascript"></script>
    <script src="~/Content/assets/js/greedynav.js" type="15507f26746588018229fdf3-text/javascript"></script>

    <!-- Custom JS -->
    <script src="~/Content/assets/js/script.js" type="15507f26746588018229fdf3-text/javascript"></script>


    <script src="Content/assets/plugins/alertify/alertify.min.js" type="text/javascript" > </script>
    <script src="Content/assets/plugins/alertify/alertify.min.js" type="text/javascript"></script>
    

    <script src="../../cdn-cgi/scripts/7d0fa10a/cloudflare-static/rocket-loader.min.js" data-cf-settings="15507f26746588018229fdf3-|49" defer=""></script>
    <%-- <form id="form1" runat="server">
        <div>
        </div>
    </form>--%>
</body>
</html>
