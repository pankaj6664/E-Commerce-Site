<%@page import="com.learn.mycart.helper.helper"%>
<%@page import="com.learn.mycart.entities.Category"%>
<%@page import="com.learn.mycart.dao.CategoryDao"%>
<%@page import="com.learn.mycart.entities.Product"%>
<%@page import="com.learn.mycart.helper.FactoryProvider"%>
<%@page import="java.util.List"%>
<%@page import="com.learn.mycart.dao.ProductDao"%>
<%
    User user = (User) session.getAttribute("current-user");
    if (user == null) {
        session.setAttribute("message", "you are not logged in !!");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (user.getUserType().equals("admin")) {
            session.setAttribute("message", "You are not normal user !!");
            response.sendRedirect("login.jsp");
            return;
        }
    }

%>





<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Normal Panel</title>
        <%@include file="Components/comman_css_js.jsp" %>

    </head>
    <body>
        <%@include file="Components/navbar.jsp" %>

        <div class="container-fluid">



            <div class="row mt-3 mx-2">

                <%                    String cat = request.getParameter("category");
                    //out.println(cat);

                    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> list;
                    if (cat == null || cat.equals("all")) {
                        list = dao.getAllProducts();
                    } else {
                        int cid = Integer.parseInt(cat.trim());
                        list = dao.getAllProductById(cid);
                    }

                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> clist = cdao.getcategories();
                %>

                <!--show categories-->
                <div class="col-md-2">

                    <div class="list-group mt-4">

                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active">All Products</a>      

                        <%
                            for (Category c : clist) {
                        %>

                        <a href="index.jsp?category=<%= c.getCategoryId()%>" class="list-group-item list-group-item-action "><%= c.getCategoryTitle()%></a>

                        <%                                }
                        %>
                    </div>


                </div>

                <!--show products-->
                <div class="col-md-10">

                    <!--row-->
                    <div class="row mt-4">
                        <!--col:12-->
                        <div class="col-md-12">

                            <div class="card-columns">

                                <!--traversing products-->

                                <%
                                    for (Product p : list) {

                                %>

                                <!--PRoduct card-->
                                <div class="card product-card" style="cursor: pointer;box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);">

                                    <div class="container text-center">
                                        <img class="card-img-top mt-2" style="max-height: 150px;max-width: 100%;width: auto;" src="Images/products/<%= p.getpPhoto()%>" alt="Card image cap">

                                    </div>

                                    <div class="card-body">
                                        <h5 class="card-title"><%= p.getpName()%></h5>
                                        <p class="card-text"><%= helper.get10Words(p.getpDesc())%></p>
                                    </div>
                                    <div class="card-footer text-center">
                                        <button class="btn custom-bg text-white" onclick="add_to_cart(<%= p.getpId()%>, '<%= p.getpName()%>', <%=p.getPriceAfterDiscount()%>)">Add to Cart</button>
                                        <button class="btn btn-outline-success" >&#8377; <%= p.getPriceAfterDiscount()%>/- <span class="text-secondary" style="font-size: 11px;font-style: italic">&#8377;<%= p.getpPrice()%> , <%= p.getpDiscount()%>% Off</span></button>
                                    </div>
                                </div>


                                <%    }
                                    if (list.size() == 0) {
                                        out.println("no item found");
                                    }

                                %>

                            </div>


                        </div>
                    </div>

                </div>

            </div>
        </div>


        <%@include file="Components/comman_modals.jsp" %>

    </body>
</html>
