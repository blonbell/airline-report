<%@ Page Language="C#" MasterPageFile="~/Overview.master" AutoEventWireup="true" CodeFile="Administration.aspx.cs" Inherits="Administration" %>

<asp:Content ID="homeHead" ContentPlaceHolderID="headContent" Runat="Server">
    <title>AirlineAccounting - Landing Site</title>

    <script>
        $(document).ready(function () {
            $("li#home-li").addClass("active");
        });
    </script>

    <%--script>
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
    </script --%>
</asp:Content>

<asp:Content ID="homeBody" ContentPlaceHolderID="bodyContent" Runat="Server">
    <%-- 
        NOTE: DO NOT TRY TO CALL a function that create controls in the body because the controls are not activated at all except postback.
        There must be an internal working that happens before page load.

        Calling it here means calling it after page load and so the event handlers assigned will not be responsive.
        makeTable(); 
    --%>
    <div class="panel panel-info">
        <div class="panel-heading">
            <h2 class="panel-title">Accounting Tools</h2>
        </div>
        <div class="panel-body">
            <div id="viewReportDiv" class="row">
                <div class="col-sm-9">
                    <p>View Report</p>
                    <p><small>Generates the Accounting Report. Allows user to filter by date and the 
                        payables and receivables of the invoice.</small></p>
                </div>
                <div class="col-sm-3 text-right">
                    <asp:Button ID="toReportingButton" cssClass="btn-primary btn-lg" 
                        runat="server" PostBackUrl="~/CreateReport.aspx" Text="View Report" />
                </div>
            </div> 
            <hr />
            <div class="clearfix"></div>

            <div id="insertEntryDiv" class="row">
                <div class="col-sm-9">
                    <p>Insert Entries</p>
                    <p><small>For inserting invoices.</small></p>
                    
                </div>
                <div class="col-sm-3 text-right">
                    <asp:Button ID="toInsertButton" cssClass="btn-primary btn-lg" 
                        runat="server" PostBackUrl="~/InsertEntry.aspx" Text="Insert Entries" />
                </div>
            </div> 
            <hr />
            <div class="clearfix"></div>

            <div id="utilitiesDiv" class="row">
                <div class="col-sm-8">
                    <p>General Utilities</p>
                    <p><small>For removing entries and viewing database tables.</small></p>
                </div>
                <div class="col-sm-4 text-right">
                    <asp:Button ID="toGeneralButton" cssClass="btn-primary btn-lg"
                        runat="server" PostBackUrl="~/Utility.aspx" Text="General Utilities" />
                </div>
            </div> 
            <hr />
            <div class="clearfix"></div>
        </div>
    </div>

    <%-- 
        <asp:Literal ID="MessageBox" runat="server">aaa</asp:Literal>

        <span id="txtHint"></span>
        <input id="Button1" type="button" onClick="useAjax()" value="submit" />
    --%>   
</asp:Content>