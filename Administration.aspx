<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Administration.aspx.cs" Inherits="Administration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>
        Landing Site
    </title>

    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>

    <script>
        var config = { a: true, b: false };
        var val = ".0..0.0";
        var firstDecimal = val.indexOf(".");

        console.log(firstDecimal);
        console.log(config.a ? 'a' : config.b ? 'b' : 3);

        function useAjax() {
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    document.getElementById("txtHint").innerHTML = xmlhttp.responseText;
                }
            }
            xmlhttp.open("POST", "ajaxTest.aspx", true);
            xmlhttp.setRequestHeader("Content-type",
                "application/x-www-form-urlencoded");
            xmlhttp.send("clientId=4&invoice=37330");
        }

        $(document).ready(function () {
            var context = SP.ClientContext.get_current();

            console.log(context);
        });
    </script>
</head>
<body>
    <%-- 
        NOTE: DO NOT TRY TO CALL a function that create controls in the body because the controls are not activated at all except postback.
        There must be an internal working that happens before page load.

        Calling it here means calling it after page load and so the event handlers assigned will not be responsive.
        makeTable(); 
    --%>
    <form id="form1" runat="server">
    <div>
        <fieldset>
            <legend>Reporting</legend>
            <p>Reporting module with basic filter and .csv import functionality</p>
            <asp:LinkButton ID="toReportingButton" runat="server" PostBackUrl="~/CreateReport.aspx">Go</asp:LinkButton>
        </fieldset>

        <fieldset>
            <legend>Insert Entries</legend>
            <p>Insert records</p>
            <asp:LinkButton ID="toInsertButton" runat="server" PostBackUrl="~/InsertEntry.aspx">Go</asp:LinkButton>
        </fieldset>

        <fieldset>
            <legend>General Utility</legend>
            <p>For removing entries, clearing databases and database statistics.</p>
            <asp:LinkButton ID="toGeneralButton" runat="server" PostBackUrl="~/Utility.aspx">Go</asp:LinkButton>
        </fieldset>
    </div>
    <%-- 
        <asp:Literal ID="MessageBox" runat="server">aaa</asp:Literal>

        <span id="txtHint"></span>
        <input id="Button1" type="button" onClick="useAjax()" value="submit" />
    --%>   
    </form>
    
    
</body>
</html>
