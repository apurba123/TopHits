/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.numina.tophits.utils;

import java.net.InetAddress;
import java.net.UnknownHostException;
import javax.servlet.http.HttpServletRequest;
import java.net.NetworkInterface;

public class ClientMachineName {

    public static String findClientComputerName(HttpServletRequest request) {
        String computerName = null;
        String remoteAddress = request.getRemoteAddr();
        try {
            InetAddress inetAddress = InetAddress.getByName(remoteAddress);
            computerName = inetAddress.getHostName();

            if (computerName.equalsIgnoreCase("localhost")) {
                computerName = java.net.InetAddress.getLocalHost().getCanonicalHostName();
            }
//            System.out.println("Current MAC address : ");
//            NetworkInterface network = NetworkInterface.getByInetAddress(inetAddress);
//
//            byte[] mac = network.getHardwareAddress();
//
//            StringBuilder sb = new StringBuilder();
//            for (int i = 0; i < mac.length; i++) {
//                sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
//            }
//            System.out.println(sb.toString());

        } catch (Exception e) {
            System.out.println("error"+e.getMessage());
            //  log.error("UnknownHostException detected in StartAction. ", e);
        }
        if (computerName.trim().length() > 0) {
            computerName = computerName.toUpperCase();
        }
        System.out.println("computerName: " + computerName);
        return computerName;
    }

}
