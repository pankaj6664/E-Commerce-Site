

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>New User</title>

        <%@include file="Components/comman_css_js.jsp" %>

    </head>
    <body>

        <%@include file="Components/navbar.jsp" %>
        <div class="container-fluid">

            <div class="row mt-5">

                <div class="col-md-4 offset-md-4">

                    <div class="card">
                         <%@ include file="Components/message.jsp" %>
                   
                        <div class="card-body px-5">

                            <h3 class="text-center my-3">Sign Up Here!!</h3>

                            <form action="RegisterServlet" method="post">
                                <div class="mb-3">
                                    <label for="name" class="form-label">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="name" aria-describedby="emailHelp" placeholder="Enter name">
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="email" aria-describedby="emailHelp" placeholder="Enter mail">
                                </div>

                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="password" placeholder="Enter password">
                                </div>

                                <div class="mb-3">
                                    <label for="phone" class="form-label">Phone</label>
                                    <input name="user_phone" type="number" class="form-control" id="phone" placeholder="Enter phone">
                                </div>

                                <div class="mb-3">
                                    <label for="address" class="form-label">Address</label>
                                    <textarea name="user_address" class="form-control" placeholder="Enter address"></textarea>
                                </div>

                                <div class="container" text-center>
                                    <button class="btn btn-outline-success">Register</button>
                                    <button class="btn btn-outline-warning">Reset</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </body>
</html>
