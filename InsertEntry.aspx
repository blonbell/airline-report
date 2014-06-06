<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InsertEntry.aspx.cs" Inherits="InsertEntry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Insert Entry</title>
    <link href="css/MasterPageStyleSheet.css" rel="stylesheet" type="text/css" />
    <link href="css/InsertEntry.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />

    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="js/jquery.numeric.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#txtTransDate").datepicker();

            $("input.numeric").numeric();

            $("input.numericP").numeric({ negative: false })
        });
    </script>
</head>
<body>
    <h1>Insert Entry Page</h1>
    <form id="form1" runat="server">
        <asp:Label ID="DoneMsg" runat="server" Text=""></asp:Label>
        <br>
        <asp:Button ID="GoBack" runat="server" Text="Back" PostBackUrl="~/Administration.aspx" />
        <br>
        <fieldset id="divReport" class="divReportStyle">
            <legend>Report</legend>
            <div>
                <span class="subjectText">Date:</span>
                <span class="subjectValue"><asp:TextBox ID="txtTransDate" runat="server"></asp:TextBox></span>
            </div>
            <div class="divSingLine">
                <span class="subjectText">Inv #:</span>
                <span class="subjectValue"><asp:TextBox ID="txtInvoice" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">CCAmount:</span>
                <span class="subjectValue"><asp:TextBox ID="txtCC" CssClass="numeric" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">Comm Airline:</span>
                <span class="subjectValue"><asp:TextBox ID="txtCommAir" CssClass="numeric" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">Comm Agent:</span>
                <span class="subjectValue"><asp:TextBox ID="txtCommAgent" CssClass="numeric" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">Acct Rec:</span>
                <span class="subjectValue"><asp:TextBox ID="txtAR" CssClass="numericP" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">Acct Pay:</span>
                <span class="subjectValue"><asp:TextBox ID="txtAP" CssClass="numericP" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">BSP GST:</span>
                <span class="subjectValue"><asp:TextBox ID="txtBSP" CssClass="numeric" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">Net Remit:</span>
                <span class="subjectValue"><asp:TextBox ID="txtNetRemit" CssClass="numeric" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">Rebate:</span>
                <span class="subjectValue"><asp:TextBox ID="txtRebate" CssClass="numeric" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">GST Coll:</span>
                <span class="subjectValue"><asp:TextBox ID="txtGSTC" CssClass="numericP" runat="server"></asp:TextBox></span>
            </div>
            <div>
                <span class="subjectText">GST Paid:</span>
                <span class="subjectValue"><asp:TextBox ID="txtGSTP" CssClass="numericP" runat="server"></asp:TextBox></span>
            </div>
        </fieldset>

        <fieldset id="aggReceivable" class="divAggReportStyle">
            <legend>Add Receivable</legend>
            <div>
                <span class="subjectText">Name: </span>
                <span class="subjectValue">
                    <asp:TextBox ID="txtRecName" runat="server"></asp:TextBox>
                </span>
            </div>
            <div>
                <span class="subjectText">Amount: </span>
                <span class="subjectValue">
                    <asp:TextBox ID="txtRecAmount" runat="server"></asp:TextBox>
                </span>
            </div>
            <div>
                <span class="subjectText">Comment: </span>
                <span class="subjectValue">
                    <asp:TextBox ID="txtRecComment" runat="server" Rows="3" 
                        TextMode="MultiLine" Width="135px"></asp:TextBox>
                </span>
            </div>
            <div>
                <span class="subjectText">Paid: <asp:CheckBox ID="cbxRecPaid" runat="server" /></span>
            </div>

            
            <div style="padding-bottom:5px; padding-top:10px">
                <asp:ListBox ID="lbRecNames" runat="server" Width="238px" style="margin-bottom:5px;"></asp:ListBox>
                <asp:Button ID="btnAddRec" runat="server" Text="Add" OnClick="btnAddRec_Click" />
                <asp:Button ID="btnRemRec" runat="server" Text="Remove" OnClick="btnRemRec_Click" />
            </div>
        </fieldset>

        <fieldset id="aggPayable" class="divAggReportStyle">
            <legend>Add Payable</legend>
            <div>
                <span class="subjectText">Name: </span>
                <span class="subjectValue">
                    <asp:TextBox ID="txtPayName" runat="server"></asp:TextBox>
                </span>
            </div>
            <div>
                <span class="subjectText">Amount: </span>
                <span class="subjectValue">
                    <asp:TextBox ID="txtPayAmount" runat="server"></asp:TextBox>
                </span>
            </div>
            <div>
                <span class="subjectText">Comment: </span>
                <span class="subjectValue">
                    <asp:TextBox ID="txtPayComment" runat="server" Rows="3" 
                        TextMode="MultiLine" Width="135px"></asp:TextBox>
                </span>
            </div>
            <div>
                <span class="subjectText">Paid: <asp:CheckBox ID="cbxPayPaid" runat="server" /></span>
            </div>

            
            <div style="padding-bottom:5px; padding-top:10px">
                <asp:ListBox ID="lbPayNames" runat="server" Width="238px" style="margin-bottom:5px;"></asp:ListBox>
                <asp:Button ID="btnAddPay" runat="server" Text="Add" OnClick="btnAddPay_Click" />
                <asp:Button ID="btnRemPay" runat="server" Text="Remove" OnClick="btnRemPay_Click" />
            </div>
        </fieldset>
        


        <div style="float:left; width:100%;">
            <asp:Button ID="btnInsert" runat="server" Text="Insert" OnClick="InsertButton_Click" />
            <asp:SqlDataSource ID="ClientDataSource" runat="server" 
                ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" 
                SelectCommand="SELECT [Name], [Id] FROM [TClient] ORDER BY [Name]" 
                InsertCommand="AddClientToInvoice" InsertCommandType="StoredProcedure">
                <InsertParameters>
                    <asp:Parameter Name="Invoice" Type="String" />
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="AccountReceivable" Type="Decimal" />
                    <asp:Parameter Name="AccountPayable" Type="Decimal" />
                    <asp:Parameter Name="comments" Type="String" />
                    <asp:Parameter Name="paid" Type="Boolean" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
        
    </form>
</body>
</html>
