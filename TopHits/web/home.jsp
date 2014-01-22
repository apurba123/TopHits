<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Lane Status</title>
        <link href="css/global.css" rel="stylesheet" type="text/css" />
        <link href="css/res.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="css/topHits.css" type="text/css" />
        <script src="js/jQuery 1.10.2.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/topHits.js"></script>
        <script type='text/javascript' src='js/jquery.js'></script>
        
        <script type="text/javascript">
            $(document).ready(function() {
                $("#Tbtn").click(function() {
                    $("#mainContentArea").slideToggle("slow");
                    $(this).toggleClass("tOpen");
                });
            });
        </script>

        <script type="text/javascript">
            function pop(div) {
                document.getElementById(div).style.display = 'block';
            }
            function hide(div) {
                document.getElementById(div).style.display = 'none';
            }
            //To detect escape button
            document.onkeydown = function(evt) {
                evt = evt || window.event;
                if (evt.keyCode == 27) {
                    hide('popDiv');
                }
            };
        </script>

        <script type="text/javascript">

            //To Auto ReFresh Lane Colors via Ajax Call
            $(document).ready(function() {
                if ($("#lanes") || $("#planes")) {

                    setInterval(function() {
                        getColor();
                        checkComplete();
                        document.getElementById('lanes').style.display = "";
                        document.getElementById('planes').style.display = "";
                        document.getElementById('loader').style.display = "none";

                    }, 10000);
                }
                else
                {
                    document.getElementById('loader').style.display = "";
                }
            });

        </script>
        <%
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
            response.setDateHeader("Expires", 0); // Proxies.

            if (session.getAttribute("employeeId") == null) {
                response.sendRedirect("index.jsp");
            }
        %>
        <script>
            function disableLinkOdd()
            {
                document.getElementById('oddpress1').disabled = true;
                document.getElementById('oddpress1').removeAttribute('href');

                document.getElementById('oddpress2').disabled = true;
                document.getElementById('oddpress2').removeAttribute('href');

                document.getElementById('oddpress1').className = "headRightBottomOddPress";
                document.getElementById('oddpress2').className = "headRightBottomOddPress"
            }

            function showLinkOdd()
            {
                document.getElementById('oddpress1').disabled = false;
                document.getElementById('oddpress1').href = "#";

                document.getElementById('oddpress2').disabled = false;
                document.getElementById('oddpress2').href = "#";

                document.getElementById('oddpress1').className = "";
                document.getElementById('oddpress2').className = ""
            }

            function disableLinkEven()
            {
                document.getElementById('evenpress1').disabled = true;
                document.getElementById('evenpress1').removeAttribute('href');

                document.getElementById('evenpress2').disabled = true;
                document.getElementById('evenpress2').removeAttribute('href');

                document.getElementById('evenpress1').className = "headRightBottomEvenPress";
                document.getElementById('evenpress2').className = "headRightBottomEvenPress"
            }

            function showLinkEven()
            {
                document.getElementById('evenpress1').disabled = false;
                document.getElementById('evenpress1').href = "#";

                document.getElementById('evenpress2').disabled = false;
                document.getElementById('evenpress2').href = "#";

                document.getElementById('evenpress1').className = "";
                document.getElementById('evenpress2').className = ""
            }

            function disableLinkAll()
            {
                document.getElementById('allpress1').disabled = true;
                document.getElementById('allpress1').removeAttribute('href');

                document.getElementById('allpress2').disabled = true;
                document.getElementById('allpress2').removeAttribute('href');

                document.getElementById('allpress1').className = "headRightBottomAllPress";
                document.getElementById('allpress2').className = "headRightBottomAllPress"
            }

            function showLinkAll()
            {
                document.getElementById('allpress1').disabled = false;
                document.getElementById('allpress1').href = "#";

                document.getElementById('allpress2').disabled = false;
                document.getElementById('allpress2').href = "#";

                document.getElementById('allpress1').className = "";
                document.getElementById('allpress2').className = ""
            }


        </script>

        <style>
            .regular-checkbox {
                display: none;
            }
            .regular-checkbox + label {
                background-color: #fafafa;
                border: 1px solid #cacece;
                box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05);
                padding: 9px;
                border-radius: 3px;
                display: inline-block;
                position: relative;
                left:45px;
                box-shadow: 0 0 8px 1px rgba(82, 172, 255, 0.8);
            }
            .regular-checkbox + label:active, .regular-checkbox:checked + label:active {
                box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px 1px 3px rgba(0,0,0,0.1);
            }
            .regular-checkbox:checked + label {
                background-color: #e9ecee;
                border: 1px solid #adb8c0;
                box-shadow: 0 1px 2px rgba(0,0,0,0.05), inset 0px -15px 10px -12px rgba(0,0,0,0.05), inset 15px 10px -12px rgba(255,255,255,0.1);
                color: #99a1a7;
            }
            .regular-checkbox:checked + label:after {
                content: '\2714';
                font-size: 13px;
                position: absolute;
                top: 0px;
                left: 5px;
                color: #000;
            }

        </style>


    </head>
    <body onload="populateNearCriteria();
            populatePrinters();
            disableLinkAll();">
        <header class="header1024"><!--header start-->
            <div class="headBg" id="mainContentArea" style="display:none;"><!--headBg start-->
                <div class="wrapper"><!--wrapper start-->
                    <div class="headLeft"><!--headLeft start-->
                        <div class="basic-modal">
                            <a href="#" onclick="pop('popDiv1');
                                    populatePrinters();
                                    populateNearCriteria();">
                                <img src="images/gearIcon.png" width="59" alt="Settings" title="Settings"  />
                            </a>

                            <a href="Logout">
                                <img src="images/gridIcon.png" width="59" alt="Logout" title="Logout" />
                            </a>
                            <a href="#">
                                <img src="images/refreshicon.png" width="59" alt="Refresh" title="Refresh" onclick="getColor();" />
                            </a>
                        </div>
                    </div><!--headLeft start-->

                    <div class="headMiddle"><!--headMiddle start-->
                        <div class="headMiddleContent"><!--headMiddleContent start-->
                            <div class="headMiddleContentOne">
                                <div class="greenMain">
                                    <div class="greenLegend"><span class="colorBoxTextLegend">DEFAULT</span></div>
                                </div>
                            </div>
                            <div class="headMiddleContentOne">
                                <div class="redMain">
                                    <div class="redLegend"><span class="colorBoxTextLegend">FULL</span></div>
                                </div>
                            </div>

                            <div class="headMiddleContentOne">
                                <div class="yellowMain">
                                    <div class="yellowLegend"><span class="colorBoxTextLegend">NEAR</span></div>
                                </div>
                            </div>

                            <div class="headMiddleContentOne">
                                <div class="blueMain">
                                    <div class="blueLegend"><span class="colorBoxTextLegend">COMPLETE</span></div>
                                </div>
                            </div>

                        </div><!--headMiddleContent end-->

                    </div><!--headMiddle end-->


                    <div class="headRight"><!--headRight start-->

                        <div class="headRightTop"><!--headRightTop start-->

                            <span>Lane Range:</span>
                            <input type="number" id="from" name="from" placeholder="" value="1" min="1" max="152" maxlength="3" required="required" />
                            <span>To</span>
                            <input type="number" id="to" name="to" placeholder="" value="152" min="1" max="152" maxlength="3"required="required"/>

                            <input type="button" value="Go" onclick="displayRange();"/>

                        </div><!--headRightTop end-->


                        <div class="headRightBottom"><!--headRightBottom start-->

                            <div class="headRightBottomOdd"><!--headRightBottomOdd start--><a href="#" id="oddpress1" onclick="disableLinkOdd();
                                    showLinkEven();
                                    showLinkAll();
                                    showOdd();">Odd Lanes</a></div><!--headRightBottomOdd end-->
                            <div class="headRightBottomEven"><!--headRightBottomEven start--><a href="#" id="evenpress1" onclick="disableLinkEven();
                                    showLinkOdd();
                                    showLinkAll();
                                    showEven();">Even Lanes</a></div><!--headRightBottomEven end-->
                            <div class="headRightBottomAll"><!--headRightBottomAll start--><a href="#" id="allpress1" onclick="disableLinkAll();
                                    showLinkOdd();
                                    showLinkEven();
                                    showAll();">All Lanes</a></div><!--headRightBottomAll end-->

                        </div><!--headRightBottom end-->

                    </div><!--headRight end-->

                </div><!--wrapper end-->

            </div><!--headBg end-->

        </header><!--header end-->

        <header class="header600">
            <div class="headBgTwo"><!--headBgTwo start-->
                <div class="headLeftTwo"><!--headLeft start-->
                    <div class="basic-modal">
                        <a href="#" onclick="pop('popDiv1');
                                populatePrinters();
                                populateNearCriteria();">
                            <img src="images/gearIcon.png" width="59" alt="Settings" title="Settings"  />
                        </a>

                        <a href="Logout">
                            <img src="images/gridIcon.png" width="59" alt="Logout" title="Logout" />
                        </a>
                        <a href="#">
                            <img src="images/refreshicon.png" width="59" alt="Refresh" title="Refresh" style="padding-top:1px; float: right;" onclick="getColor();" />
                        </a>
                    </div>
                </div><!--headLeft start-->

                <div class="headMiddleTwo"><!--headMiddle start-->
                    <div class="headMiddleContent"><!--headMiddleContent start-->

                        <div class="headMiddleContentOne">
                            <div class="greenMain">
                                <div class="greenLegend"><span class="colorBoxTextLegend">Default</span></div>
                            </div>
                        </div>

                        <div class="headMiddleContentOne">
                            <div class="redMain">
                                <div class="redLegend"><span class="colorBoxTextLegend">FULL</span></div>
                            </div>
                        </div>

                        <div class="headMiddleContentOne">
                            <div class="yellowMain">
                                <div class="yellowLegend"><span class="colorBoxTextLegend">NEAR</span></div>
                            </div>
                        </div>

                        <div class="headMiddleContentOne">
                            <div class="blueMain">
                                <div class="blueLegend"><span class="colorBoxTextLegend">COMPLETE</span></div>
                            </div>
                        </div>


                    </div><!--headMiddleContent end-->
                </div><!--headMiddle end-->

                <div class="headRight"><!--headRight start-->
                    <div class="headRightTop"><!--headRightTop start-->
                        <!-- <span>Lane Range:</span>-->

                        <input type="number" id="frompot" name="from" placeholder="" value="1" min="1" max="152" maxlength="3" required="required" />
                        <span>To</span>
                        <input type="number" id="topot" name="to" placeholder="" value="152" min="1" max="152" maxlength="3"required="required"/>


                        <input type="submit" value="Go" onclick="populateFromTo();
                                displayRange();" />
                    </div><!--headRightTop end-->
                    <div class="headRightBottom"><!--headRightBottom start-->
                        <div class="headRightBottomOdd"><!--headRightBottomOdd start--><a href="#" id="oddpress2" onclick="disableLinkOdd();
                                showLinkEven();
                                showLinkAll();
                                showOdd();">Odd Lanes</a></div><!--headRightBottomOdd end-->
                        <div class="headRightBottomEven"><!--headRightBottomEven start--><a href="#" id="evenpress2" onclick="disableLinkEven();
                                showLinkOdd();
                                showLinkAll();
                                showEven();">Even Lanes</a></div><!--headRightBottomEven end-->
                        <div class="headRightBottomAll" ><!--headRightBottomAll start--><a href="#" id="allpress2" onclick="disableLinkAll();
                                showLinkOdd();
                                showLinkEven();
                                showAll();">All Lanes</a></div><!--headRightBottomAll end-->
                    </div><!--headRightBottom end-->
                </div><!--headRight end-->
            </div><!--headBgTwo end-->
        </header>


        <article><!--article start-->
            <section><!--section start-->
                <center><img id="loader" src="images/loading.gif" height="200" width="200" class="imgset"/></center>
                <div class="wrapper" style="display:none" id="lanes"><!--wrapper start-->
                    <div id="Tbtn" class="tBtnArea"><!--tBtnArea start-->
                        <img src="images/toggleBtn.png" width="100" alt="Toggle" title="Toggle" /></div><!--tBtnArea end-->

                    <div  class="mainContentArea"><!--mainContentArea start-->
                        <div class="mainContentAreaOne"  ><!--mainContentAreaOne start-->
                            <% int cnt = 0;
                                for (int i = 0; i < 152; i++) {
                                    cnt++;
                                    if (i % 10 == 0) {
                            %>

                            <%}%>
                            <div class="noArea" id="lane<%=i%>"><!--noArea start-->
                                <div class="yellowMain">
                                    <div id="btn_<%=i + 1%>" class="yellow basic-modal" ><a href="#" class="colorBoxTextNo" onclick="document.getElementById('carton').value =<%=i + 1%>;
                                            document.getElementById('lpn').value = '';
                                            popupselection(<%=i + 1%>)" ><%=i + 1%></a>
                                    </div>
                                </div>
                            </div>
                            <% }%>
                        </div>
                    </div><!--mainContentArea end-->
                </div>


                <div class="wrapperTwo" style="display:none" id="planes"><!--wrapper start-->
                    <div  class="mainContentAreaTwo"><!--mainContentArea start-->
                        <div class="mainContentAreaOne"  ><!--mainContentAreaOne start-->
                            <% int ctr = 0;
                                for (int i = 0; i < 152; i++) {
                                    ctr++;

                            %>
                            <div class="noArea" id="laneportrait<%=i%>"><!--noArea start-->
                                <div class="greenMain">
                                    <div id="pbtn_<%=i + 1%>" class="green basic-modal" ><a href="#" class="colorBoxTextNo" onclick="document.getElementById('carton').value =<%=i + 1%>;
                                            document.getElementById('lpn').value = '';
                                            popupselection(<%=i + 1%>)" ><%=i + 1%></a>
                                    </div>
                                </div>
                            </div>

                            <% }%>
                        </div>
                    </div><!--mainContentArea end-->
                </div><!--wrapper end-->
            </section><!--section end-->
        </article><!--article end-->

        <div id="popDiv" class="ontop">
            <div class="basic-modal-content" id="popup">
                <div class="basic-modal-content_Head">CLOSE CARTON CAPTURE
                    <div class="popCloseBtn"><a href="#" onClick="hide('popDiv')"><img src="images/x.png"/></a></div>
                </div>
                <div class="basic-modal-content_MainformArea">
                    <div class="lArea"><label>CARTON#</label></div>
                    <input type="text" id="carton" name="carton" readonly="true"/>
                </div>
                <div class="basic-modal-content_MainformArea">
                    <div class="lArea"><label>SCAN LPN<font color="red">*</font></label></div>
                    <input type="text" id="lpn" name="lpn" required="required"/>
                </div>
                <div class="basic-modal-content_MainformArea">
                    <div class="lArea"><label>FORCE AUDIT</label></div>
                    <input type="checkbox" height="10" width="10" onclick="show();" id="audit" name="audit" class="regular-checkbox" /><label for="audit"></label>

                </div>
                <div class="basic-modal-content_MainformArea" id="commenttr" style="display:none;">
                    <div class="lArea"><label>COMMENT<font color="red">*</font></label></div>
                    <input type="text" height="10" width="10" id="auditcomment"  name="auditcomment" value="" />
                </div>

                <div class="basic-modal-content_MainformAreaTwo" >
                    <input type="button" value="OK" onclick="confirm(document.getElementById('carton').value);"/>
                </div>
            </div>


        </div>
        <div id="popDiv1" class="ontop">

            <div class="basic-modal-content" id="popupadmin">
                <div class="basic-modal-content_Head">PREFERENCES
                    <div class="popCloseBtn"><a href="#" onClick="hide('popDiv1')"><img src="images/x.png"/></a></div>
                </div>
                <div class="basic-modal-content_MainformArea">
                    <div class="lArea"><label>NEAR FULL CRITERIA</label></div>
                    <div id="nc"></div>
                    <!--                    <input type="text" id="nearcriteria" name="nearcriteria" value=""  />-->
                </div>
                <!--                    <div class="basic-modal-content_MainformArea">
                                        <div class="lArea"><label>Current Default Printer</label></div>
                                        <input type="text"  id="selectedprinter" value="" readonly="true" />
                                    </div>-->
                <div class="basic-modal-content_MainformArea">
                    <div class="lArea"><label>DEFAULT PRINTER</label></div>
                    <select id="printerList" name="printer" >

                    </select>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK"  onclick="saveSettings();"/>
                </div>
            </div>


        </div>
        <div id="popDiv2" class="ontop">
            <div class="basic-modal-content" id="popupadmin">
                <div class="basic-modal-content_Head">CONFIRMATION OF CLOSE
                    <div class="popCloseBtn"><a href="#" onClick="hide('popDiv2')"><img src="images/x.png"/></a></div>
                </div>
                <div class="basic-modal-content_MainformArea">
                    <div class="lArea"><label>CARTON#</label></div>
                    <input type="text" id="cartonfinal" name="cartonfinal" readonly="true"/>
                </div>
                <div class="basic-modal-content_MainformArea">
                    <div class="lArea"><label>SCAN LPN</label></div>
                    <input type="text" id="lpnfinal" name="lpnfinal" readonly="true"/>
                </div>
                <div class="basic-modal-content_MainformArea">
                    <div class="lArea"><label>CARTON QTY</label></div>
                    <input type="text" id="cartonqty" name="cartonqty" readonly="true"/>
                </div>
                <div class="basic-modal-content_MainformArea">
                    <div class="lArea"><label>LABEL FOR AUDIT</label></div>
                    <input type="text" id="auditfinal" name="auditfinal" readonly="true"/>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK" onclick="submitClosing();getColor();"/>
                </div>
            </div>
        </div>

        <div id="popDiv3" class="ontop">
            <div class="basic-modal-content" id="popupclosing">
                <div class="basic-modal-content_Head_new"> A REQUEST TO CLOSE THIS LANE IS ALREADY PENDING <br>UNABLE TO CLOSE LANE AT THIS TIME
                    <div class="popCloseBtn"></div>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK"  onclick="hide('popDiv3');"/>
                </div>
            </div>
        </div>

        <div id="popDiv4" class="ontop">
            <div class="basic-modal-content" id="popupclosing">
                <div class="basic-modal-content_Head_new">SUCCESSFULLY INITIALIZED FOR CLOSING
                    <div class="popCloseBtn"></div>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK"  onclick="hide('popDiv4');"/>
                </div>
            </div>

        </div>

        <div id="popDiv5" class="ontop">
            <div class="basic-modal-content" id="popupclosing">
                <div class="basic-modal-content_Head_new">INITIALIZATION FAILED
                    <div class="popCloseBtn"></div>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK"  onclick="hide('popDiv5');"/>
                </div>
            </div>
        </div>
        <div id="popDiv6" class="ontop">
            <div class="basic-modal-content" id="popupclosing">
                <div class="basic-modal-content_Head_new">YOU HAVE ALREADY SELECTED <br>A LANE FOR CLOSING
                    <div class="popCloseBtn"></div>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK"  onclick="hide('popDiv6');"/>
                </div>
            </div>
        </div>

        <div id="popDiv7" class="ontop">
            <div class="basic-modal-content" id="popupclosing">
                <div class="basic-modal-content_Head_new" id="laneclose">LANE CLOSED SUCCESSFULLY
                    <div class="popCloseBtn"></div>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="hidden" name="closedlane" id="closedlane"/>
                    <input type="button" value="OK" onclick="hide('popDiv7');
                            initializeLane(document.getElementById('closedlane').value);"/>
                </div>
            </div>


        </div>
        <div id="popDiv8" class="ontop">
            <div class="basic-modal-content" id="popupclosing">
                <div class="basic-modal-content_Head_new"> SUCCESSFULLY SAVED
                    <div class="popCloseBtn"></div>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK"  onclick="hide('popDiv8');"/>
                </div>
            </div>
        </div>
        <div id="popDiv9" class="ontop">
            <div class="basic-modal-content" id="popupclosing">
                <div class="basic-modal-content_Head_new"> NOT SUCCESSFULLY SAVED
                    <div class="popCloseBtn"></div>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK"  onclick="hide('popDiv9');"/>
                </div>
            </div>
        </div>
        <div id="popDiv10" class="ontop">
            <div class="basic-modal-content" id="popupclosing">
                <div class="basic-modal-content_Head_new"> ENTER NEAR CRITERIA VALUE CORRECTLY
                    <div class="popCloseBtn"></div>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK"  onclick="hide('popDiv10');"/>
                </div>
            </div>
        </div>
        <div id="popDiv11" class="ontop">
            <div class="basic-modal-content" id="popupclosing">
                <div class="basic-modal-content_Head_new"> INVALID RANGE
                    <div class="popCloseBtn"></div>
                </div>

                <div class="basic-modal-content_MainformAreaTwo">
                    <input type="button" value="OK"  onclick="hide('popDiv11');"/>
                </div>
            </div>
        </div>

    </body>
</html>
