/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.numina.tophits.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.apache.log4j.Logger;

/**
 *
 * @author s
 */
public class SqlServerDbConnection {

    static Logger log = Logger.getLogger(SqlServerDbConnection.class.getName());

    public static Connection getDbConnection() {
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String userName = "sa";
            String password = "Tophits@123";
            String url = "jdbc:sqlserver://192.168.1.4:1433" + ";databaseName=TopHits";
            conn = DriverManager.getConnection(url, userName, password);
//            Statement s1 = conn.createStatement();
//            ResultSet rs = s1.executeQuery("SELECT * FROM Employee");
//
//            if (rs != null) {
//                while (rs.next()) {
//                    System.out.println(rs.getString(1) + "--" + rs.getString(2) + "--" + rs.getString(3));
//                }
//            }

        } catch (ClassNotFoundException e) {
            log.error("Error in db sql server connection");
        } catch (SQLException e) {
             log.error("Error in db sql server connection");
        }

        return conn;
    }

}
