<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login</title>
        <script type='text/javascript' src='js/rhoapi-modules.js'></script>
        <link href="css/global.css" rel="stylesheet" type="text/css" />
        <link href="css/res.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript">
            var versionInfo;
            var uuId;
            var phoneId;
            var deviceName;
            
            function logOut(){
                document.forms[0].action = "/TopHits/Logout";
                document.forms[0].submit();
                return true;
            }
            
            function err()
            {
                //versionInfo = Rho.System.osVersion;
                //uuId = Rho.System.uuid; // Valid only for Motorolla Solutions through App
                //phoneId = Rho.System.phoneId;
                //deviceName = Rho.System.deviceName;
                //alert("Client JS1. VersionInfo:"+versionInfo+" DeviceUuId:"+uuId+" PhoneId:"+phoneId+" Device Name:"+deviceName);
                //if(phoneId != ""){
                //    document.getElementById('clientId').value=phoneId;
                //    document.getElementById('clientName').value=deviceName;
                //} else{
                //    if(deviceName != ""){
                //        document.getElementById('clientId').value=deviceName;
                //        document.getElementById('clientName').value=deviceName;
                //    } else{
                        //alert("Neither PhoneId Nor DeviceName is Found.");
                        //return false;
                //    }
                //}
                //console.log("phoneId:"+phoneId+" deviceName:"+deviceName);
                
            <% if (request.getParameter("status") != null) {
                    String st = (String) request.getParameter("status");
                    if (st.equals("0")) {
            %>
                document.getElementById('message').innerHTML = "Invalid User Name";
            <%      } else if (st.equals("1")) {%>
                document.getElementById('message').innerHTML = 'Already Logged In. Please <a href="javascript://" style="color:red;text-decoration:underline" onclick="logOut();"> Logout </a>';
            <%      }
            } else {%>
                document.getElementById('message').innerHTML = "";
            <%}%>
            }
            
            function checkForm()
            {
                //versionInfo = Rho.System.osVersion;
                //uuId = Rho.System.uuid; // Valid only for Motorolla Solutions through App
                //phoneId = Rho.System.phoneId;
                //deviceName = Rho.System.deviceName;
                //alert("Client JS2. VersionInfo:"+versionInfo+" DeviceUuId:"+uuId+" PhoneId:"+phoneId+" Device Name:"+deviceName);
                //(phoneId != ""){
                //    document.getElementById('clientId').value=phoneId;
                //    document.getElementById('clientName').value=deviceName;
                //} else{
                //    if(deviceName != ""){
                //        document.getElementById('clientId').value=deviceName;
                //        document.getElementById('clientName').value=deviceName;
                //    } else{
                        //alert("Neither PhoneId Nor DeviceName is Found.");
                        //return false;
                //    }
                //}
                
                var t = 0;
                //if (document.getElementById('Lusername').value === "" && document.getElementById('Lpassword').value === "")
                //{
                //    t = 1;
                //    document.getElementById('message').innerHTML = "Enter User Name & Password";
                //}
                //else
                if (document.getElementById('Lusername').value === "")
                {
                    t = 1;
                    document.getElementById('message').innerHTML = "Enter User Name";
                }
                //else
                //if (document.getElementById('Lpassword').value === "") {
                //    document.getElementById('message').innerHTML = "Enter Password";
                //    t = 1
                //}

                if (t == 0){
                    return true;
                }
                else{
                    return false;
                }
            }
        </script>

    </head>
    <%-- session.setAttribute("employeeId", null); --%>
    <%-- session.setAttribute("clientId", null); --%>

    <body onload="err();">
        <header><!--header start-->
        </header><!--header end-->
        <article><!--article start-->
            <section><!--section start-->
                <div class="loginAreaMain">
                    <div class="head">Login</div>
                    <div class="loginAreaMainFrm">
                        
                        <form id="HLogin" action="Loginservlet" method="POST" onsubmit="return checkForm();">
                            <center><div id="message" style="height: 15px;color: red;"> &nbsp;</div></center>
                            <%-- <label>User Name:</label>	--%>	
                            <input type="text" id="Lusername" title="User Name" name="uid_r" tabindex="1" placeholder="User Name" value="" required style="alignment-adjust: after-edge" />
                            <%-- <label>Password:</label>	--%>	           
                            <%-- <input id="Lpassword" name="pwd_r" title="Password"  type="password" tabindex="2" placeholder="Password" value="" required /> --%>
                            <%--
                            <input type="hidden" id="clientId" name="clientId" />
                            <input type="hidden" id="clientName" name="clientName" 
                             --%>
                            <input type="submit" value="Login" />
                            <input type="reset" value="Reset" />
                        </form>           
                    </div>
                </div>
            </section><!--section end-->
        </article><!--article end-->
    </body>
</html>
