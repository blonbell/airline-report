<%@ Page Language="C#" MasterPageFile="~/Overview.master" AutoEventWireup="true" CodeFile="CreateReport.aspx.cs" Inherits="Reporting" %>

<asp:Content ID="homeHead" ContentPlaceHolderID="headContent" Runat="Server">
    <title>AirlineAccounting - Report Generator</title>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" />
    <script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
    <script src="js/dialogFunc.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(".ReviewButtonClass").parent().parent().addClass("redOut");
            $(".AddClientButtonClass").parent().parent().addClass("greenOut");
            $(".trSecondaryRow").hide();

            $(".UIDateClass").datepicker();

            $("#toggleMinimize").click(function () {
                $("div#botPanel").slideToggle();
            });
        });
    </script>
</asp:Content>

<asp:Content ID="homeBody" ContentPlaceHolderID="bodyContent" Runat="Server">
    <div class="row">
        <h1>View Report</h1>
        <asp:Label ID="DoneMsg" CssClass="text-success" runat="server" Text=""></asp:Label>
    </div>

    <div id="divSummaryBox" class="crSummaryDiv" visible="false" runat="server">
            <h2>Summary</h2>
            <a id ="toggleMinimize" class="topRightStick smallFont miniButton">Min/Max [x]</a>
            <div id="botPanel">
                <div id="divAR">
                    <span class="firstIndent">A/R</span>
                    <asp:Label ID="lblSummaryAR" CssClass="firstRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divCC">
                    <span class="firstIndent">Credit Card</span>
                    <asp:Label ID="lblSummaryCC" CssClass="firstRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divSales">
                    <span class="secIndent">Sales</span>
                    <asp:Label ID="lblSummarySales" CssClass="secRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divGSTC">
                    <span class="secIndent">GST Collected</span>
                    <asp:Label ID="lblSummaryGSTC" CssClass="secRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divRebate">
                    <span class="secIndent">Rebate Payable</span>
                    <asp:Label ID="lblSummaryRebate" CssClass="secRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divPur">
                    <span class="firstIndent">Purchases</span>
                    <asp:Label ID="lblSummaryPur" CssClass="firstRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divGSTP">
                    <span class="firstIndent">GST Paid</span>
                    <asp:Label ID="lblSummaryGSTP" CssClass="firstRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divCommRec">
                    <span class="firstIndent">Comm. Rec.</span>
                    <asp:Label ID="lblSummaryCommRec" CssClass="firstRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divAP">
                    <span class="secIndent">A/P</span>
                    <asp:Label ID="lblSummaryAP" CssClass="secRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divCC2">
                    <span class="secIndent">Credit Card</span>
                    <asp:Label ID="lblSummaryCC2" CssClass="secRight" runat="server" Text=""></asp:Label>
                </div>
                <div id="divBSP">
                    <span class="secIndent">GST Paid</span>
                    <asp:Label ID="lblSummaryBSP" CssClass="secRight" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </div>
    <div id="payDialog-block" title="Pay Invoice"></div>
    <div id="viewDialog-block" title="View Comments"></div>
    <div id="addDialog-block" title="Add Client To Invoice">  
        <div>
            Create an AR or AP associated with this invoice.
        </div>
        <hr>    
        <table style="padding-left:10px;">
            <tr>
                <td align="right">
                    Invoice #: 
                </td>
                <td>
                    <asp:TextBox ID="dialogInvoice" runat="server" BackColor="#79EAAC" ></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    Client Name:
                </td>
                <td>
                    <asp:TextBox ID="dialogClientName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:RadioButtonList ID="rblAccountType" runat="server" RepeatDirection="Horizontal">
                        <asp:ListItem Value="R">Receivable</asp:ListItem>
                        <asp:ListItem Value="P">Payable</asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Amount: 
                </td>
                <td>
                    <asp:TextBox ID="dialogAmount" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td align="right">
                    Comment:
                </td>
                <td>
                    <asp:TextBox ID="CommentBox" runat="server" TextMode="MultiLine" Rows="3" Columns="30"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:CheckBox ID="cbxPaid" runat="server" Text="Paid Already" />
                </td>
            </tr>
        </table>
        <asp:Button ID="SubmitPayButton" runat="server" Text="Pay" CssClass="greyButton" 
            OnClick="SubmitPayButton_Click" UseSubmitBehavior="False" />
    </div>

    <div id="leftPanel" class="row col-sm-4 col-xs-6 bg-success">
        <div id="filtersDiv">
            <h2>Reporting Filters</h2>
            <div class="form-group text-info">
                <asp:Label id="lblStartDatePicker" CssClass="col-xs-4 control-label" runat="server" Text="Start Date" for="txtStartDate"></asp:Label>
                <div class="col-xs-6">
                    <asp:TextBox ID="txtStartDate" CssClass="form-control UIDateClass" runat="server" AutoPostBack="True"></asp:TextBox>
                </div>
            </div>
            <div class="form-group text-info">
                <asp:Label id="lblEndDatePicker" CssClass="col-xs-4 control-label" runat="server" Text="End Date" for="txtEndDate"></asp:Label>
                <div class="col-xs-6">
                    <asp:TextBox ID="txtEndDate" CssClass="form-control UIDateClass" runat="server"  AutoPostBack="True" ></asp:TextBox>
                </div>
            </div>
            <div class="form-group text-info">
                <asp:Label ID="rpLabel" CssClass="col-xs-4 control-label" runat="server" Text="Choose Client" for="ddlClients"/>
                <div class="col-xs-6">
                    <asp:DropDownList ID="ddlClients" CssClass="form-control" runat="server" DataSourceID="ClientDataSource" 
                        DataTextField="Name" DataValueField="Id" AutoPostBack="True">
                    </asp:DropDownList>
                </div>
                <asp:SqlDataSource ID="ClientDataSource" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" 
                    SelectCommand="SELECT [Name], [Id] FROM [TClient] ORDER BY [Name]">
                </asp:SqlDataSource>
            </div>
        </div>
    </div>
    <div class="clearfix"></div>

    <div id="rightPanel" class="row table-responsive">
        <asp:GridView ID="ReportGridView" runat="server" AutoGenerateColumns="False" DataKeyNames="Invoice" DataSourceID="ReportingSource"  AllowSorting="True" ShowFooter="True" OnRowDataBound="ReportGridView_RowDataBound">
            <Columns>
                <asp:TemplateField HeaderText="Add Client">
                    <ItemTemplate>

                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Expand">
                    <ItemTemplate>
                        <asp:Button ID="btnExpand" class="ExpandButtonClass" runat="server" Text="Expand" 
                            OnClientClick="return false;" Visible='<%# isPrincipleRow(Eval("Zindex")) %>' invoice='<%# Eval("Invoice") %>' />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="TransactionDate" HeaderText="Date" ReadOnly="True" SortExpression="TransactionDate" />
                <asp:BoundField DataField="Receivables" HeaderText="Receivables" ReadOnly="True" SortExpression="Receivables" />
                <asp:BoundField DataField="Payable" HeaderText="Payable" ReadOnly="True" SortExpression="Payable" />
                <asp:BoundField DataField="Invoice" HeaderText="Invoice" ReadOnly="True" SortExpression="Invoice" />
                <asp:BoundField DataField="CCAmount" HeaderText="CC Amt" ReadOnly="True" SortExpression="CCAmount" DataFormatString="{0:c}" />
                <asp:BoundField DataField="CommissionAirline" HeaderText="Comm Airline" ReadOnly="True" SortExpression="CommissionAirline" DataFormatString="{0:c}" />
                <asp:BoundField DataField="CommissionAgent" HeaderText="Comm Agent" ReadOnly="True" SortExpression="CommissionAgent" DataFormatString="{0:c}" />
                <asp:BoundField DataField="AccountReceivable" HeaderText="AR" ReadOnly="True" SortExpression="AccountReceivable" DataFormatString="{0:c}" />
                <asp:BoundField DataField="AccountPayable" HeaderText="AP" ReadOnly="True" SortExpression="AccountPayable" DataFormatString="{0:c}" />
                <asp:BoundField DataField="BSPGST" HeaderText="BSPGST" ReadOnly="True" SortExpression="BSPGST" DataFormatString="{0:c}" />
                <asp:BoundField DataField="NetRemit" HeaderText="NetRemit" ReadOnly="True" SortExpression="NetRemit" DataFormatString="{0:c}" />
                <asp:BoundField DataField="Rebate" HeaderText="Rebate" ReadOnly="True" SortExpression="Rebate" DataFormatString="{0:c}" />
                <asp:BoundField DataField="GSTCollected" HeaderText="GSTCollected" ReadOnly="True" SortExpression="GSTCollected" DataFormatString="{0:c}" />
                <asp:BoundField DataField="GSTPaid" HeaderText="GSTPaid" ReadOnly="True" SortExpression="GSTPaid" DataFormatString="{0:c}" />
                <asp:TemplateField HeaderText="Pro/Loss">
                    <ItemTemplate>
                        <%# convertNumbersToChinese(calcTotal(Eval("CommissionAirline"),
                                        Eval("CommissionAgent"),
                                        Eval("AccountReceivable"),
                                        Eval("AccountPayable"),
                                        Eval("Rebate"),
                                        Eval("GSTCollected"), 
                                        Eval("GSTPaid"))) %>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
            <EmptyDataTemplate>
                <h2>No Entries match the Filter parameters.</h2>
            </EmptyDataTemplate>
            <FooterStyle BackColor="#C2F1BA" />
            <HeaderStyle BackColor="Gray" />
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="ReportingSource" runat="server" ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" SelectCommand="SelectReport" SelectCommandType="StoredProcedure" OnSelected="ReportingSource_Selected">
        <SelectParameters>
            <asp:SessionParameter DbType="String" Name="StartDate" SessionField="startDate" />
            <asp:SessionParameter DbType="String" Name="EndDate" SessionField="endDate" />
            <asp:SessionParameter Name="ClientId" SessionField="clientId" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="AddClientSource" runat="server" ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" InsertCommand="AddClientToInvoice" InsertCommandType="StoredProcedure" SelectCommand="SELECT AggInvoiceClient.* FROM AggInvoiceClient">
        <InsertParameters>
            <asp:Parameter Name="Invoice" Type="String" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="AccountReceivable" Type="Decimal" />
            <asp:Parameter Name="AccountPayable" Type="Decimal" />
            <asp:Parameter Name="comments" Type="String" />
            <asp:Parameter Name="paid" Type="Boolean" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>