package com.numina.tophits.action;

import static com.numina.tophits.action.LaneClosing.log;
import com.numina.tophits.utils.DbConnection;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class InitializeLane extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Connection conn = DbConnection.getDbConnection();
        PrintWriter out = response.getWriter();
        try {
            if (conn != null) {
                String laneNo = request.getParameter("laneno");

                HttpSession session = request.getSession();
                String empId = (String) session.getAttribute("employeeId");
                
                    String sql = "update app_closing set state='idle',client_id=0,lp='',force_audit='no',err_msg='' where lane=" + laneNo+" and client_id="+empId;

                    PreparedStatement pstmt1 = conn.prepareStatement(sql);
                    if (pstmt1.executeUpdate() > 0) {
                        out.print("success");
                    } else {
                        out.print("failure");
                    }
                    pstmt1.close();
                
              
                conn.close();
            }
        } catch (SQLException e) {
            log.error("Error::" + e);

        } finally {
            out.close();
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
