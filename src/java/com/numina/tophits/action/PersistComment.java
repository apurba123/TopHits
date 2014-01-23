package com.numina.tophits.action;

import com.numina.tophits.utils.InternalDerbyDbManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PersistComment extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        int laneno = Integer.parseInt(request.getParameter("laneno"));
        String comment = request.getParameter("comment");

        Connection connDerby = null;
        try {
            String sqlQuery = "update AUDIT_COMMENTS set AUDITCOMMENT='" + comment + "' where LANEID=" + laneno;
            connDerby = InternalDerbyDbManager.getConnection();
            InternalDerbyDbManager.executeUpdate(sqlQuery);

        } catch (Exception ex) {
            java.util.logging.Logger.getLogger(PersistComment.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                InternalDerbyDbManager.releaseConnection(connDerby);
            } catch (Exception ex) {
                java.util.logging.Logger.getLogger(PersistComment.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
