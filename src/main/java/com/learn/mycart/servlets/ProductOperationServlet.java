/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.learn.mycart.servlets;

import com.learn.mycart.dao.CategoryDao;
import com.learn.mycart.dao.ProductDao;
import com.learn.mycart.entities.Category;
import com.learn.mycart.entities.Product;
import com.learn.mycart.helper.FactoryProvider;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Akash PC
 */
@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

//            fetching category data
            String op = request.getParameter("operation");

            if (op.trim().equals("addcategory")) {

//               add category
                String title = request.getParameter("catTitle");
                String desc = request.getParameter("catDesc");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDesc(desc);

//               save category in database
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);

                //out.println("category saved!!");
                HttpSession httpsession = request.getSession();
                httpsession.setAttribute("message", "Category added successfully !!");
                response.sendRedirect("admin.jsp");
                return;

            } else if (op.trim().equals("addproduct")) {

//               add product
                String pName = request.getParameter("proTitle");
                String pDesc = request.getParameter("proDesc");
                int pPrice = Integer.parseInt(request.getParameter("proPrice"));
                int pQuant = Integer.parseInt(request.getParameter("proQuant"));
                int pDisc = Integer.parseInt(request.getParameter("proDisc"));
                int cId = Integer.parseInt(request.getParameter("catId").trim());
                Part part = request.getPart("proImage");

                Product p = new Product();
                p.setpName(pName);
                p.setpDesc(pDesc);
                p.setpDiscount(pDisc);
                p.setpPrice(pPrice);
                p.setpQuantity(pQuant);
                p.setpPhoto(part.getSubmittedFileName());

//                 get caategory by id
                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                Category category = cdao.getCategoryById(cId);

                p.setCategory(category);

                //product save
                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                pdao.saveProduct(p);
                //out.println("Product saved");
                
                //pic upload
                
//                food out the path to upload photo

                 String path=request.getRealPath("Images")+File.separator+"products"+File.separator+part.getSubmittedFileName();
                 System.out.println(path);
                 
                try ( //uploading code
                        
                        FileOutputStream fos = new FileOutputStream(path)) {
                    InputStream is=part.getInputStream();
                    
                    //reading data
                    
                    byte []data=new byte[is.available()];
                    is.read(data);
                    
                    //writing data
                    
                    fos.write(data);
                }
                catch(Exception e)
                {
                    e.printStackTrace();
                }
                       


                
                
                HttpSession httpsession = request.getSession();
                httpsession.setAttribute("message", "Product added successfully !!");
                response.sendRedirect("admin.jsp");
                return;

            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
