<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ViewReport.aspx.cs" Inherits="ViewReport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>View Report</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:LinkButton ID="prevButton" runat="server" PostBackUrl="~/CreateReport.aspx">Back to Previous</asp:LinkButton>
        
        <asp:Label ID="Label1" runat="server" Text="Label" />
        <asp:Label ID="Label2" runat="server" Text="Label" />
        <asp:Label ID="Label3" runat="server" Text="Label" />
        <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataKeyNames="Invoice" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="TransactionDate" HeaderText="TransactionDate" SortExpression="TransactionDate" >
                </asp:BoundField>
                <asp:BoundField DataField="Receivable" HeaderText="Receivable" SortExpression="Receivable" />
                <asp:BoundField DataField="Payable" HeaderText="Payable" SortExpression="Payable" />
                <asp:BoundField DataField="Invoice" HeaderText="Invoice" ReadOnly="True" SortExpression="Invoice" />
                <asp:BoundField DataField="CCAmount" HeaderText="CCAmount" SortExpression="CCAmount" />
                <asp:BoundField DataField="CommissionAirline" HeaderText="CommissionAirline" SortExpression="CommissionAirline" />
                <asp:BoundField DataField="CommissionAgent" HeaderText="CommissionAgent" SortExpression="CommissionAgent" />
                <asp:BoundField DataField="AccountReceivable" HeaderText="AccountReceivable" SortExpression="AccountReceivable" />
                <asp:BoundField DataField="AccountPayable" HeaderText="AccountPayable" SortExpression="AccountPayable" />
                <asp:BoundField DataField="BSPGST" HeaderText="BSPGST" SortExpression="BSPGST" />
                <asp:BoundField DataField="NetRemit" HeaderText="NetRemit" SortExpression="NetRemit" />
                <asp:BoundField DataField="Rebate" HeaderText="Rebate" SortExpression="Rebate" />
                <asp:BoundField DataField="GSTCollected" HeaderText="GSTCollected" SortExpression="GSTCollected" />
                <asp:BoundField DataField="GSTPaid" HeaderText="GSTPaid" SortExpression="GSTPaid" />
                <asp:BoundField DataField="IsPaid" HeaderText="IsPaid" SortExpression="IsPaid" />
            </Columns>
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" 
        SelectCommand=" SELECT * 
                        FROM [TReport] 
                        WHERE (TransactionDate &gt;= @StartDate AND TransactionDate &lt;= @EndDate)
                        " >
        <SelectParameters>
            <asp:FormParameter FormField="startDatePicker.SelectedDate" Name="StartDate" />
            <asp:FormParameter FormField="endDatePicker.SelectedDate" Name="EndDate" />
        </SelectParameters>
    </asp:SqlDataSource>

        <asp:LinkButton ID="prevButton1" runat="server" PostBackUrl="~/CreateReport.aspx">Back to Previous</asp:LinkButton>
    </form>
</body>
</html>
