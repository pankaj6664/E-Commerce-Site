<%@page import="java.util.Map"%>
<%@page import="org.hibernate.boot.model.source.internal.hbm.Helper"%>
<%@page import="com.learn.mycart.helper.helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.User"%>
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "you are not logged in !!");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not admin !!");
            response.sendRedirect("login.jsp");
            return;
        }
    }

%>

<%    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cdao.getcategories();

//getting ount
    Map<String, Long> m = helper.getCount(FactoryProvider.getFactory());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>
        <%@include file="Components/comman_css_js.jsp" %>


    </head>
    <body>
        <%@include file="Components/navbar.jsp" %>
        <div class="container admin">

            <div class="container-fluid mt-3">

                <%@include file="Components/message.jsp" %>
            </div>



            <div class="row mt-3">

                <!--first col-->

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center" >
                            <div class="container">
                                <img style="max-width:125px;" class="img-fluid" src="Images/team.png" alt="user_icon"/>
                            </div>
                            <h1><%= m.get("userCount")%></h1>
                            <h1 class="text-uppercase text-muted">Users</h1>

                        </div>
                    </div>

                </div>

                <!--Second col-->

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width:125px;" class="img-fluid rounded-circle" src="Images/delivery-box.png" alt="product_icon"/>
                            </div>
                            <h1><%= m.get("productCount")%></h1>
                            <h1 class="text-uppercase text-muted">Products</h1>

                        </div>
                    </div>


                </div>


                <!--Third col-->

                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width:125px;" class="img-fluid rounded-circle" src="Images/task.png" alt="user_icon"/>
                            </div>
                            <h1><%= list.size()%></h1>

                            <h1 class="text-uppercase text-muted">Categories</h1>


                        </div>
                    </div>


                </div>


            </div>

            <!--second row-->

            <div class="row mt-3">

                <!--second row first col-->

                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width:125px;" class="img-fluid rounded-circle" src="Images/calculator.png" alt="user_icon"/>
                            </div>
                            <p class="md-2">Click here to add new catogory</p>
                            <h1 class="text-uppercase text-muted">Add Category</h1>


                        </div>
                    </div>

                </div>

                <!--second row second col-->
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width:125px;" class="img-fluid rounded-circle" src="Images/plus.png" alt="user_icon"/>
                            </div>
                            <p class="md-2">Click here to add new product</p>
                            <h1 class="text-uppercase text-muted">Add Product</h1>


                        </div>
                    </div>

                </div>

            </div>

        </div>


        <!--add product modal-->

        <!-- Modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLongTitle">Fill product Details</h5>

                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">

                            <input type="hidden" name="operation" value="addproduct">

                            <!--product title-->
                            <div class="form-group">
                                <input type="text" class="form-control" name="proTitle" placeholder="Enter product title" required />

                            </div>

                            <div class="form-group mt-2">
                                <textarea style=" height: 200px" class="form-control" placeholder="Enter product Description" name="proDesc" required></textarea>

                            </div>

                            <div class="form-group mt-2">
                                <input type="number" class="form-control" name="proPrice" placeholder="Enter product price" required />

                            </div>

                            <div class="form-group mt-2">
                                <input type="number" class="form-control" name="proDisc" placeholder="Enter product discount" required />

                            </div>

                            <div class="form-group mt-2">
                                <input type="number" class="form-control" name="proQuant" placeholder="Enter product quantity" required />

                            </div>
                            <div class="form-group mt-2">
                                <select name="catId" id="" class="form-control">
                                    <%for (Category c : list) {
                                    %>
                                    <option value="<%= c.getCategoryId()%>"><%= c.getCategoryTitle()%></option>

                                    <%}%>
                                </select>

                            </div>

                            <div class="form-group mt-2">
                                <label for="pPic">Select Picture of product</label>
                                <br>
                                <input type="file" name="proImage" id="pPic" />

                            </div>

                            <!--submit button-->

                            <div class="container text-center mt-3">
                                <button class="btn btn-outline-success">Add Product</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                            </div>





                        </form>
                    </div>

                </div>
            </div>
        </div>



        <!--end add product modal-->

        <!--add category model-->


        <!-- Modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLongTitle" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg text-white">
                        <h5 class="modal-title" id="exampleModalLongTitle">Fill category Details</h5>

                    </div>
                    <div class="modal-body">
                        <form action="ProductOperationServlet" method="post">

                            <input type="hidden" name="operation" value="addcategory">

                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required />

                            </div>

                            <div class="form-group mt-2">
                                <textarea style=" height: 200px" class="form-control" placeholder="Enter category Description" name="catDesc" required></textarea>

                            </div>

                            <div class="container text-center mt-3">
                                <button class="btn btn-outline-success">Add Category</button>
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>

                            </div>

                        </form>
                    </div>

                </div>
            </div>
        </div>
        <!--end add category medol-->


        <%@include  file="Components/comman_modals.jsp" %>

    </body>
</html>
