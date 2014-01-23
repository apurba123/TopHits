function trim(stringToTrim)
{
    return stringToTrim.replace(/^\s+|\s+$/g, "");
}
function showOdd()
{

    for (var i = 1; i <= 152; i = i + 2)
    {

        document.getElementById("lane" + i).style.display = "none";
        document.getElementById("laneportrait" + i).style.display = "none";

    }
    for (var i = 0; i <= 152; i = i + 2)
    {
        document.getElementById("lane" + i).style.display = "";
        document.getElementById("laneportrait" + i).style.display = "";
    }

}
function showEven()
{
    for (var i = 1; i < 152; i = i + 2)
    {
        document.getElementById("lane" + i).style.display = "";
        document.getElementById("laneportrait" + i).style.display = "";
    }

    for (var i = 0; i < 152; i = i + 2)
    {
        document.getElementById("lane" + i).style.display = "none";
        document.getElementById("laneportrait" + i).style.display = "none";
    }

}
function showAll()
{
    for (var i = 0; i < 152; i++)
    {
        document.getElementById("lane" + i).style.display = "";
        document.getElementById("laneportrait" + i).style.display = "";
    }

}
function getColor()
{
    $.ajax({
        url: "LaneStatus",
        type: "POST",
        dataType: "html",
        cache: false,
        crossDomain: true,
        async: false,
        timeout: 3000,
        beforeSend:
                function() {
                    //alert(myClass);
                },
        data: {laneCount: 152},
        success:
                function(data, textStatus, xhr) {
                    var rows = data.split("||");
                    try {
                        if (rows.length > 0) {
                            $.each(rows, function(index, value) {
                                var rowData = value.split("~");
                                var myClass = $("#btn_" + (rowData[0])).attr("class");
                                var myClass1 = $("#pbtn_" + (rowData[0])).attr("class");
                                var setColor = rowData[1];
                                if (setColor == "GREEN") {
                                    $("#btn_" + (rowData[0])).removeClass(myClass).addClass("green basic-modal");
                                    $("#pbtn_" + (rowData[0])).removeClass(myClass1).addClass("green basic-modal");
                                }
                                if (setColor == "YELLOW") {
                                    $("#btn_" + (rowData[0])).removeClass(myClass).addClass("yellow  basic-modal");
                                    $("#pbtn_" + (rowData[0])).removeClass(myClass1).addClass("yellow basic-modal");
                                }
                                if (setColor == "RED") {
                                    $("#btn_" + (rowData[0])).removeClass(myClass).addClass("red basic-modal");
                                    $("#pbtn_" + (rowData[0])).removeClass(myClass1).addClass("red basic-modal");
                                }
                                if (setColor == "BLUE") {
                                    $("#btn_" + (rowData[0])).removeClass(myClass).addClass("blue basic-modal");
                                    $("#pbtn_" + (rowData[0])).removeClass(myClass1).addClass("blue basic-modal");
                                }
                                if (setColor == "GREENBOOKED") {
                                    
                                    $("#btn_" + (rowData[0])).removeClass(myClass).addClass("greenpress basic-modal");
                                    $("#pbtn_" + (rowData[0])).removeClass(myClass1).addClass("greenpress basic-modal");
                                }
                                if (setColor == "YELLOWBOOKED") {
                                    $("#btn_" + (rowData[0])).removeClass(myClass).addClass("yellowpress  basic-modal");
                                    $("#pbtn_" + (rowData[0])).removeClass(myClass1).addClass("yellowpress basic-modal");
                                }
                                if (setColor == "REDBOOKED") {
                                    $("#btn_" + (rowData[0])).removeClass(myClass).addClass("redpress basic-modal");
                                    $("#pbtn_" + (rowData[0])).removeClass(myClass1).addClass("redpress basic-modal");
                                }
                                if (setColor == "BLUEBOOKED") {
                                    $("#btn_" + (rowData[0])).removeClass(myClass).addClass("bluepress basic-modal");
                                    $("#pbtn_" + (rowData[0])).removeClass(myClass1).addClass("bluepress basic-modal");
                                }
                            });
                        }
                    } catch (Exception) {
                        if (console && console.log) {
                            console.log("Error in Data Processing::", Exception);
                        }
                    }
                },
        error: function(xhr, textStatus, errorThrown) {
            //alert("Returns Error:" + xhr.toString());
            if (console && console.log) {
                console.log("Returns Error::", xhr.toString());
            }
        }
    }).done(function(data) {
        if (console && console.log) {
            // console.log("Output:", data);
        }
    });
}

function displayRange()
{
    var from = document.getElementById('from').value;
    var to = document.getElementById('to').value;

    if (!isNaN(parseInt(from)) && !isNaN(parseInt(to)))
    {
        var ifm = parseInt(from);
        var tm = parseInt(to);

        if (tm >= ifm)
        {
            if ((ifm > 0 && ifm <= 152) && (tm > 0 && tm <= 152))
            {

                for (var j = 0; j < 152; j++)
                {

                    document.getElementById('lane' + j).style.display = "";
                    document.getElementById('laneportrait' + j).style.display = "";
                }

                for (var k = 0; k < ifm - 1; k++)
                {
                    document.getElementById('lane' + k).style.display = "none";
                    document.getElementById('laneportrait' + k).style.display = "none";
                }
                for (var l = tm; l < 152; l++)
                {
                    document.getElementById('lane' + l).style.display = "none";
                    document.getElementById('laneportrait' + l).style.display = "none";
                }
                showLinkOdd();
                showLinkEven()
                showLinkAll()
            }
            else {
                rangeError();
            }
        }
        else {
            rangeError();
        }

    }
    else {
        rangeError();
    }
}
function rangeError()
{
    hide('popDiv');
    hide('popDiv1');
    hide('popDiv2');
    hide('popDiv3');
    hide('popDiv4');
    hide('popDiv5');
    hide('popDiv6');
    hide('popDiv7');
    hide('popDiv8');
    hide('popDiv9');
    hide('popDiv10');
    pop('popDiv11');
}
function populatePrinters()
{
    $.ajax({
        url: "ShowPrinters",
        type: "POST",
        dataType: "html",
        cache: false,
        crossDomain: true,
        beforeSend:
                function() {
                    //alert(myClass);
                },
        success:
                function(data, textStatus, xhr) {
                    var se = data.split(",");
                    document.getElementById('printerList').innerHTML = se[0];
                    document.getElementById('selectedprinter').value = se[1];

                },
        error: function(xhr, textStatus, errorThrown) {
            //alert("Returns Error:" + xhr.toString());
            if (console && console.log) {
                console.log("Returns Error::", xhr.toString());
            }
        }
    }).done(function(data) {
        if (console && console.log) {
            // console.log("Output:", data);
        }
    });
}

function pop(div) {
    document.getElementById(div).style.display = 'block';
}

function hide(div) {
    document.getElementById(div).style.display = 'none';
}
function confirm(laneno)
{

    if (document.getElementById('carton').value != '' && document.getElementById('lpn').value != '')
    {

        if (!document.getElementById('audit').checked)
        {
            persistComment(document.getElementById('carton').value, '');

            hide('popDiv');
            document.getElementById('cartonfinal').value = document.getElementById('carton').value;
            document.getElementById('lpnfinal').value = document.getElementById('lpn').value;

            $.ajax({
                url: "PopulateConfirm",
                type: "POST",
                dataType: "html",
                cache: false,
                crossDomain: true,
                async: false,
                timeout: 3000,
                beforeSend:
                        function() {
                            //alert(myClass);
                        },
                data: {laneno: laneno},
                success:
                        function(data, textStatus, xhr) {
                            var lanedata = data.split(",");
                            //  document.getElementById('auditfinal').value=lanedata[0];
                            document.getElementById('cartonqty').value = lanedata[1];

                        },
                error: function(xhr, textStatus, errorThrown) {
                    //alert("Returns Error:" + xhr.toString());
                    if (console && console.log) {
                        console.log("Returns Error::", xhr.toString());
                    }
                }
            }).done(function(data) {
                if (console && console.log) {
                    // console.log("Output:", data);
                }
            });

            document.getElementById('auditcomment').value = '';
            document.getElementById('auditfinal').value = '';
            pop('popDiv2');
        } else {

            persistComment(document.getElementById('carton').value, document.getElementById('auditcomment').value);
            if (document.getElementById('auditcomment').value != '') {


                hide('popDiv');
                document.getElementById('cartonfinal').value = document.getElementById('carton').value;
                document.getElementById('lpnfinal').value = document.getElementById('lpn').value;

                $.ajax({
                    url: "PopulateConfirm",
                    type: "POST",
                    dataType: "html",
                    cache: false,
                    crossDomain: true,
                    async: false,
                    timeout: 3000,
                    beforeSend:
                            function() {
                                //alert(myClass);
                            },
                    data: {laneno: laneno},
                    success:
                            function(data, textStatus, xhr) {
                                var lanedata = data.split(",");
                                //  document.getElementById('auditfinal').value=lanedata[0];
                                document.getElementById('cartonqty').value = lanedata[1];

                            },
                    error: function(xhr, textStatus, errorThrown) {
                        //alert("Returns Error:" + xhr.toString());
                        if (console && console.log) {
                            console.log("Returns Error::", xhr.toString());
                        }
                    }
                }).done(function(data) {
                    if (console && console.log) {
                        // console.log("Output:", data);
                    }
                });

                document.getElementById('auditfinal').value = document.getElementById('auditcomment').value;
                pop('popDiv2');


            }

        }
    }

}
function popupselection(laneno)
{

    $.ajax({
        url: "CheckLaneState",
        type: "POST",
        dataType: "html",
        cache: false,
        crossDomain: true,
        beforeSend:
                function() {
                    //alert(myClass);
                },
        data: {laneno: laneno},
        success:
                function(data, textStatus, xhr) {

                    if (trim(data) == "booked")
                    {
                        pop('popDiv6');
                    }
                    else if (trim(data) == "idle")
                    {


                        prepopulate(laneno);

                        pop('popDiv');
                    }
                    else
                        pop('popDiv3');
                    // alert('Lane is already locked for closing');

                },
        error: function(xhr, textStatus, errorThrown) {
            //alert("Returns Error:" + xhr.toString());
            if (console && console.log) {
                console.log("Returns Error::", xhr.toString());
            }
        }
    }).done(function(data) {
        if (console && console.log) {
            // console.log("Output:", data);
        }
    });
}

function prepopulate(laneno)
{

    $.ajax({
        url: "PrepopulateCancel",
        type: "POST",
        dataType: "html",
        cache: false,
        crossDomain: true,
        async: true,
        beforeSend:
                function() {
                    //alert(myClass);
                },
        data: {laneno: laneno},
        success:
                function(data, textStatus, xhr) {

                    if (trim(data) != "")
                    {
                        document.getElementById('commenttr').style.display = '';
                        document.getElementById('auditcomment').value = data;
                        document.getElementById('audit').checked = true;

                    } else {
                        document.getElementById('commenttr').style.display = 'none';
                        document.getElementById('auditcomment').value = '';
                        document.getElementById('audit').checked = false;
                    }


                },
        error: function(xhr, textStatus, errorThrown) {
            //alert("Returns Error:" + xhr.toString());
            if (console && console.log) {
                console.log("Returns Error::", xhr.toString());
            }
        }
    }).done(function(data) {
        if (console && console.log) {
            // console.log("Output:", data);
        }
    });
}
function persistComment(laneno, comment)
{
    $.ajax({
        url: "PersistCommentOk",
        type: "POST",
        dataType: "html",
        cache: false,
        crossDomain: true,
        async: false,
        timeout: 3000,
        beforeSend:
                function() {
                    //alert(myClass);
                },
        data: {laneno: laneno, comment: comment},
        success:
                function(data, textStatus, xhr) {



                },
        error: function(xhr, textStatus, errorThrown) {
            //alert("Returns Error:" + xhr.toString());
            if (console && console.log) {
                console.log("Returns Error::", xhr.toString());
            }
        }
    }).done(function(data) {
        if (console && console.log) {
            // console.log("Output:", data);
        }
    });
}
function checkComplete()
{

    $.ajax({
        url: "LaneComplete",
        type: "POST",
        dataType: "html",
        cache: false,
        crossDomain: true,
        async: false,
        timeout: 3000,
        beforeSend:
                function() {
                    //alert(myClass);
                },
        success:
                function(data, textStatus, xhr) {
                    var closedata = data.split(",");
                    if (trim(closedata[1]) == "closed")
                    {
                        hide('popDiv');
                        hide('popDiv1');
                        hide('popDiv2');
                        hide('popDiv3');
                        hide('popDiv4');
                        hide('popDiv5');
                        hide('popDiv6');
                        document.getElementById('closedlane').value = trim(closedata[0]);
                        if (trim(closedata[2]) == "")
                            document.getElementById('laneclose').innerHTML = "<h3> LANE NO " + trim(closedata[0]) + " CLOSED SUCCESSFULLY</h3>";
                        else
                            document.getElementById('laneclose').innerHTML = "<h3> LANE NO " + trim(closedata[0]) + " CLOSED WITH ERROR</h3><br>" + trim(closedata[2]);
                        pop('popDiv7');

                    }



                },
        error: function(xhr, textStatus, errorThrown) {
            //alert("Returns Error:" + xhr.toString());
            if (console && console.log) {
                console.log("Returns Error::", xhr.toString());
            }
        }
    }).done(function(data) {
        if (console && console.log) {
            // console.log("Output:", data);
        }
    });
}


function submitClosing()
{
    var laneno = document.getElementById('cartonfinal').value;
    var lpn = document.getElementById('lpnfinal').value;
    var audit = 'no';
    if (document.getElementById('audit').checked)
        audit = 'yes';
    hide('popDiv2');
    $.ajax({
        url: "LaneClosing",
        type: "POST",
        dataType: "html",
        cache: false,
        crossDomain: true,
        async: false,
        timeout: 3000,
        beforeSend:
                function() {
                    //alert(myClass);
                },
        data: {laneno: laneno, lpn: lpn, audit: audit},
        success:
                function(data, textStatus, xhr) {
                    if (trim(data) == "success")
                    {
                        pop('popDiv4');

                    }
                    else
                    if (trim(data) == "duplicate")
                    {
                        pop('popDiv3');
                    } else
                    {
                        pop('popDiv5');
                    }



                },
        error: function(xhr, textStatus, errorThrown) {
            //alert("Returns Error:" + xhr.toString());
            if (console && console.log) {
                console.log("Returns Error::", xhr.toString());
            }
        }
    }).done(function(data) {
        if (console && console.log) {
            // console.log("Output:", data);
        }
    });
}

function initializeLane(laneno)
{

    $.ajax({
        url: "InitializeLane",
        type: "POST",
        dataType: "html",
        cache: false,
        crossDomain: true,
        async: false,
        timeout: 3000,
        beforeSend:
                function() {
                    //alert(myClass);
                },
        data: {laneno: laneno},
        success:
                function(data, textStatus, xhr) {

                    if (trim(data) == "success")
                    {
                        //  alert('success');
                    }


                },
        error: function(xhr, textStatus, errorThrown) {
            //alert("Returns Error:" + xhr.toString());
            if (console && console.log) {
                console.log("Returns Error::", xhr.toString());
            }
        }
    }).done(function(data) {
        if (console && console.log) {
            // console.log("Output:", data);
        }
    });
}

function show() {
    if (document.getElementById('audit').checked)
    {
        document.getElementById('commenttr').style.display = "";

    }
    else
        document.getElementById('commenttr').style.display = "none";
}

function populateNearCriteria() {

    $.ajax({
        url: "NearCriteria",
        type: "POST",
        dataType: "html",
        cache: false,
        crossDomain: true,
        async: false,
        timeout: 3000,
        beforeSend:
                function() {
                    //alert(myClass);
                },
        success:
                function(data, textStatus, xhr) {

                    if (trim(data) != "")
                    {
                        document.getElementById('nc').innerHTML = " <input min='70' max='99' id='nearcriteria' maxlength=2 name='nearcriteria' required='required' type='number' value='" + trim(data) + "'/>"
//                        document.getElementById('nearcriteria').value = data;
                    }


                },
        error: function(xhr, textStatus, errorThrown) {
            //alert("Returns Error:" + xhr.toString());
            if (console && console.log) {
                console.log("Returns Error::", xhr.toString());
            }
        }
    }).done(function(data) {
        if (console && console.log) {
            // console.log("Output:", data);
        }
    });


}

function saveSettings()
{
    var percent = document.getElementById('nearcriteria').value;
    var printer = document.getElementById("printerList").options[document.getElementById("printerList").selectedIndex].value;

    if (trim(percent) != '')
    {
        $.ajax({
            url: "Settings",
            type: "POST",
            dataType: "html",
            cache: false,
            crossDomain: true,
            async: false,
            beforeSend:
                    function() {
                        //alert(myClass);
                    },
            data: {percent: percent, printer: printer},
            success:
                    function(data, textStatus, xhr) {

                        if (trim(data) == "success")
                        {
                            hide('popDiv1');
                            pop('popDiv8');

                        }
                        else
                        {
                            hide('popDiv1');
                            pop('popDiv9');
                        }


                    },
            error: function(xhr, textStatus, errorThrown) {
                //alert("Returns Error:" + xhr.toString());
                if (console && console.log) {
                    console.log("Returns Error::", xhr.toString());
                }
            }
        }).done(function(data) {
            if (console && console.log) {
                // console.log("Output:", data);
            }
        });
    }
    else {
        hide('popDiv1');
        pop('popDiv10');
    }

}

function populateFromTo() {
    document.getElementById('from').value = document.getElementById('frompot').value;
    document.getElementById('to').value = document.getElementById('topot').value;
}
