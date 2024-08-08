
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login - MyCart</title>
        <%@include file="Components/comman_css_js.jsp" %>
    </head>
    <body>
        <%@include file="Components/navbar.jsp" %>
        <div class="container">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card mt-3">

                        <div class="card-header custom-bg text-white">
                            <h1>Login Here</h1>

                        </div>
                        <div class="card-body">
                            
                            <%@include file="Components/message.jsp" %>

                            <form action="LoginServlet" method="post">
                                <div class="mb-3">
                                    <label for="exampleInputEmail1" class="form-label">Email address</label>
                                    <input name="email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp">
                                    
                                </div>
                                <div class="mb-3">
                                    <label for="exampleInputPassword1" class="form-label">Password</label>
                                    <input name="password" type="password" class="form-control" id="exampleInputPassword1">
                                </div>

                                <a href="register.jsp" class="text-center d-block mb-2">If not registered ? click here</a>
                                <div class="container text-center ">

                                    <button type="submit" class="btn btn-primary custom-bg border-0">Submit</button>
                                    <button type="reset" class="btn btn-primary custom-bg border-0">Reset</button>
                                </div>
                            </form>

                        </div>

                        <div class="card-footer">

                        </div>
                    </div>


                </div>
            </div>
        </div>
    </body>
</html>
