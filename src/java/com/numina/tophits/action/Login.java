/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.numina.tophits.action;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.numina.tophits.utils.InternalDerbyDbManager;
import com.numina.tophits.utils.SqlServerDbConnection;

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
        //Connection conn = DbConnection.getDbConnection();
        Connection conn = SqlServerDbConnection.getDbConnection();
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
               // String sql = "select employee_id,password from employee_login where employee_id='" + uid + "' and password='" + pwd + "'";
                String sql = "select EmployeeId,Password from Employee where EmployeeId='" + uid + "' and Password='" + pwd + "'";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    loginflag = true;
                }
                conn.close();

                if (loginflag) {
                    // rd = request.getRequestDispatcher("home.jsp");
                    Connection connDerby = null;
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

                    } catch (Exception ex) {
                        java.util.logging.Logger.getLogger(LaneStatus.class.getName()).log(Level.SEVERE, null, ex);
                    } finally {
                        try {
                            InternalDerbyDbManager.releaseConnection(connDerby);
                        } catch (Exception ex) {
                            java.util.logging.Logger.getLogger(LaneStatus.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                    HttpSession session = request.getSession();
                    session.setAttribute("employeeId", uid);
                    response.sendRedirect("home.jsp");

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
