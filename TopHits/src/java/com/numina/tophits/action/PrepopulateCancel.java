package com.numina.tophits.action;

import com.numina.tophits.utils.InternalDerbyDbManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PrepopulateCancel extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        int laneno = Integer.parseInt(request.getParameter("laneno"));
        String comment = "";
        Connection connDerby = null;
        try {
            String sqlQuery = "select AUDITCOMMENT from AUDIT_COMMENTS where LANEID=" + laneno;
            connDerby = InternalDerbyDbManager.getConnection();
            ResultSet rs = InternalDerbyDbManager.executeQueryNoParams(connDerby, sqlQuery);
            if (rs.next()) {
                comment = rs.getString(1);
            }
            if (!comment.trim().equals("")) {
                out.println(comment);
            } else {
                out.println(" ");
            }
        } catch (Exception ex) {
            java.util.logging.Logger.getLogger(PrepopulateCancel.class.getName()).log(Level.SEVERE, null, ex);

        } finally {
            try {
                InternalDerbyDbManager.releaseConnection(connDerby);
            } catch (Exception ex) {
                java.util.logging.Logger.getLogger(PrepopulateCancel.class.getName()).log(Level.SEVERE, null, ex);
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
