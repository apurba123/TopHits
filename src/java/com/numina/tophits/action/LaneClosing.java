package com.numina.tophits.action;

import com.numina.tophits.utils.DbConnection;
import com.numina.tophits.utils.InternalDerbyDbManager;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

public class LaneClosing extends HttpServlet {

    static Logger log = Logger.getLogger(LaneClosing.class.getName());

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Connection conn = DbConnection.getDbConnection();
        PrintWriter out = response.getWriter();
        try {
            if (conn != null) {
                String laneNo = request.getParameter("laneno");
                String lpnNo = request.getParameter("lpn");
                String audit = request.getParameter("audit");
                HttpSession session = request.getSession();
                String empId = (String) session.getAttribute("employeeId");
                String sql = "select state from app_closing where lane='" + laneNo + "' and state='closing'";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    out.print("duplicate");
                } else {
                    sql = "update app_closing set state='closing',client_id='" + empId + "',lp='" + lpnNo + "',force_audit='" + audit + "' where lane=" + laneNo;

                    PreparedStatement pstmt1 = conn.prepareStatement(sql);
                    String sql1 = "update app_lanes set qty_asked=qty_asked-box_qty_sorted Where lane=" + laneNo;
                    PreparedStatement pst1 = conn.prepareStatement(sql1);
                    if (pstmt1.executeUpdate() > 0 && pst1.executeUpdate() > 0) {
                        out.print("success");

                        Connection connDerby = null;
                        try {
                            String sqlQuery = "update AUDIT_COMMENTS set AUDITCOMMENT='' where LANEID=" + laneNo;
                            connDerby = InternalDerbyDbManager.getConnection();
                            InternalDerbyDbManager.executeUpdate(sqlQuery);

                        } catch (Exception ex) {
                            java.util.logging.Logger.getLogger(LaneClosing.class.getName()).log(Level.SEVERE, null, ex);
                        } finally {
                            try {
                                InternalDerbyDbManager.releaseConnection(connDerby);
                            } catch (Exception ex) {
                                java.util.logging.Logger.getLogger(LaneClosing.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }

                    } else {
                        out.print("failure");
                    }
                    pstmt1.close();
                }
                rs.close();
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

}
