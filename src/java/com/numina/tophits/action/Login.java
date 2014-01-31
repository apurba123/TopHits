package com.numina.tophits.action;

import com.numina.tophits.utils.ClientMachineName;
import com.numina.tophits.utils.DbConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.numina.tophits.utils.InternalDerbyDbManager;
import java.net.InetAddress;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;

public class Login extends HttpServlet {

    Logger log = Logger.getLogger(this.getClass());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        Connection conn = DbConnection.getDbConnection();
        // Connection conn = SqlServerDbConnection.getDbConnection();
        boolean loginflag = false;
        if (conn != null) {
            try {
                String uid = "";
                if (request.getParameter("uid_r") != null) {
                    uid = request.getParameter("uid_r");
                }
                String pwd = "";
                if (request.getParameter("pwd_r") != null) {
                    pwd = request.getParameter("pwd_r");
                }
                String sql = "select employee_id,password from employee_login where employee_id='" + uid + "' and password='" + pwd + "'";
                //String sql = "select EmployeeId,Password from Employee where EmployeeId='" + uid + "' and Password='" + pwd + "'";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    loginflag = true;
                }
                conn.close();

                if (loginflag) {
                    // rd = request.getRequestDispatcher("home.jsp");
                    Connection connDerby = null;
                    int statusflag = 0;
                    try {
                        int cnt = 0;
                        String sqlQuery = "select count(*) from UTILITY where UTILITYNAME='NearFull' and clientid=" + uid;
                        connDerby = InternalDerbyDbManager.getConnection();
                        ResultSet rst = InternalDerbyDbManager.executeQueryNoParams(connDerby, sqlQuery);
                        if (rst.next()) {
                            cnt = rst.getInt(1);
                        }
                        if (cnt == 0) {
                            sqlQuery = "insert into UTILITY (utilityname,utilityvalue,clientid) VALUES('NearFull','90'," + uid + ")";
                            InternalDerbyDbManager.executeUpdate(sqlQuery);
                        }
                        InternalDerbyDbManager.releaseConnection(connDerby);
                        connDerby = InternalDerbyDbManager.getConnection();
                        String status = "";
                        String qry = "select logstatus from EMPLOYEE where employeeid='" + uid + "'";

                        ResultSet rslt = InternalDerbyDbManager.executeQueryNoParams(connDerby, qry);
                        if (rslt.next()) {
                            status = rslt.getString(1);
                        }
                        InternalDerbyDbManager.releaseConnection(connDerby);
                        if (status.trim().equals("")) {
                            sqlQuery = "insert into EMPLOYEE (employeeid,logstatus) VALUES('" + uid + "','active')";
                            InternalDerbyDbManager.executeUpdate(sqlQuery);

                            statusflag = 1;

                        } else if (status.trim().equals("idle")) {
                            statusflag = 1;
                            try {

                                sqlQuery = "update EMPLOYEE set logstatus='active' where employeeid='" + uid + "'";

                                InternalDerbyDbManager.executeUpdate(sqlQuery);

                            } catch (Exception e) {

                            }

                        } else if (status.trim().equals("active")) {
                            statusflag = 0;
                        }

                    } catch (Exception ex) {
                        java.util.logging.Logger.getLogger(LaneStatus.class.getName()).log(Level.SEVERE, null, ex);
                    } finally {
                        try {
                            InternalDerbyDbManager.releaseConnection(connDerby);
                        } catch (Exception ex) {
                            java.util.logging.Logger.getLogger(LaneStatus.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }

                    if (statusflag == 1) {

                        response.sendRedirect("home.jsp");
                    } else {
                        RequestDispatcher rd = request.getRequestDispatcher("index.jsp?status=1");
                        rd.forward(request, response);
                    }
                    HttpSession session = request.getSession();
                    session.setAttribute("employeeId", uid);

                } else {
                    RequestDispatcher rd = request.getRequestDispatcher("index.jsp?status=0");
                    rd.forward(request, response);
                    // response.sendRedirect("index.jsp?status=0");
                }

            } catch (SQLException e) {
                log.error("Error::" + e);

            } finally {
                try {
                    conn.close();
                } catch (SQLException e) {

                }
            }
        }

    }
}
