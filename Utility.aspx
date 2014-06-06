<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Utility.aspx.cs" Inherits="Utility" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AirlineAccounting - Utilities</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Label ID="DoneMsg" runat="server" Text=""></asp:Label>

        <asp:Button ID="GoBack" runat="server" Text="Back" PostBackUrl="~/Administration.aspx" />

        <br>
        <h1>Invoices</h1>
        <asp:GridView ID="InvoiceView" runat="server" AllowPaging="True" AllowSorting="True" 
            AutoGenerateColumns="False" DataKeyNames="Invoice" DataSourceID="SqlDataSource1" 
            OnRowDeleted="GridView1_RowDeleted" OnRowUpdated="GridView1_RowUpdated" 
            BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="TransactionDate" HeaderText="Date" SortExpression="TransactionDate" DataFormatString="{0:d}" />
                <asp:BoundField DataField="Invoice" HeaderText="Invoice" SortExpression="Invoice" InsertVisible="False" ReadOnly="True" />
                <asp:BoundField DataField="CCAmount" HeaderText="CC Amount" SortExpression="CCAmount" />
                <asp:BoundField DataField="CommissionAirline" HeaderText="Comm Air" SortExpression="CommissionAirline" />
                <asp:BoundField DataField="CommissionAgent" HeaderText="Comm Agent" SortExpression="CommissionAgent"/>
                <asp:BoundField DataField="AccountReceivable" HeaderText="AR" SortExpression="AccountReceivable" />
                <asp:BoundField DataField="AccountPayable" HeaderText="AP" SortExpression="AccountPayable" />
                <asp:BoundField DataField="BSPGST" HeaderText="BSP GST" SortExpression="BSPGST" />
                <asp:BoundField DataField="NetRemit" HeaderText="Net Remit" SortExpression="NetRemit" />
                <asp:BoundField DataField="Rebate" HeaderText="Rebate" SortExpression="Rebate" />
                <asp:BoundField DataField="GSTCollected" HeaderText="GST Coll" SortExpression="GSTCollected" />
                <asp:BoundField DataField="GSTPaid" HeaderText="GST Paid" SortExpression="GSTPaid" />
            </Columns>
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <RowStyle BackColor="White" ForeColor="#330099" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <SortedAscendingCellStyle BackColor="#FEFCEB" />
            <SortedAscendingHeaderStyle BackColor="#AF0101" />
            <SortedDescendingCellStyle BackColor="#F6F0C0" />
            <SortedDescendingHeaderStyle BackColor="#7E0000" />
        </asp:GridView>

        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" 
            OldValuesParameterFormatString="original_{0}"
            DeleteCommand="DELETE FROM [TReport] WHERE ([Invoice] = @original_Invoice)" 
            SelectCommand="SELECT * FROM [TReport]" 
            UpdateCommand="UPDATE TReport 
            SET TransactionDate = @TransactionDate, CCAmount = @CCAmount, 
                CommissionAirline = @CommissionAirline, CommissionAgent = @CommissionAgent, 
                AccountReceivable = @AccountReceivable, AccountPayable = @AccountPayable, BSPGST = @BSPGST, 
                NetRemit = @NetRemit, Rebate = @Rebate, GSTCollected = @GSTCollected, GSTPaid = @GSTPaid
            WHERE Invoice = @original_Invoice">
            <DeleteParameters>
                <asp:Parameter Name="original_Invoice" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="TransactionDate" />
                <asp:Parameter Name="CCAmount" />
                <asp:Parameter Name="CommissionAirline" />
                <asp:Parameter Name="CommissionAgent" />
                <asp:Parameter Name="AccountReceivable" />
                <asp:Parameter Name="AccountPayable" />
                <asp:Parameter Name="BSPGST" />
                <asp:Parameter Name="NetRemit" />
                <asp:Parameter Name="Rebate" />
                <asp:Parameter Name="GSTCollected" />
                <asp:Parameter Name="GSTPaid" />
                <asp:Parameter Name="original_Invoice" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <!-- ClientSource -->
        <hr>
        <h1>Clients</h1>
        <asp:GridView ID="ClientView" runat="server" AllowPaging="True" 
            AllowSorting="True" AutoGenerateColumns="False" BackColor="White" 
            BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
            DataKeyNames="Id" DataSourceID="ClientSource">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowHeader="True" />
                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
            </Columns>
            <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
            <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
            <RowStyle BackColor="White" ForeColor="#330099" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
            <SortedAscendingCellStyle BackColor="#FEFCEB" />
            <SortedAscendingHeaderStyle BackColor="#AF0101" />
            <SortedDescendingCellStyle BackColor="#F6F0C0" />
            <SortedDescendingHeaderStyle BackColor="#7E0000" />
        </asp:GridView>

        <asp:SqlDataSource ID="ClientSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" 
            OldValuesParameterFormatString="original_{0}"
            SelectCommand="SELECT * FROM [TClient] ORDER BY [Name]" 
            DeleteCommand="DELETE FROM TClient WHERE (Id = @original_id)" 
            UpdateCommand="UPDATE TClient SET Name = @Name WHERE (Id = @original_id)">
            <DeleteParameters>
                <asp:Parameter Name="original_id" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="Name" />
                <asp:Parameter Name="original_id" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <hr>

        <!-- InvoiceToClientSource -->
        <h1>Invoice To Clients</h1>
         <asp:GridView ID="InvoiceToClientView" runat="server" AutoGenerateColumns="False" 
             DataSourceID="InvoiceToClientSource" AllowPaging="True" AllowSorting="True" 
             BackColor="White" BorderColor="#CC9966" BorderStyle="None" BorderWidth="1px" 
             CellPadding="4" OnRowDeleting="InvoiceToClientView_RowDeleting" DataKeyNames="Invoice,ClientId">
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                <asp:BoundField DataField="Invoice" HeaderText="Invoice" InsertVisible="False" ReadOnly="True" SortExpression="Invoice" />
                <asp:BoundField DataField="ClientId" HeaderText="ClientId" InsertVisible="False" ReadOnly="True" SortExpression="ClientId" />
                <asp:BoundField DataField="AccountReceivable" HeaderText="AR" SortExpression="AccountReceivable" />
                <asp:BoundField DataField="AccountPayable" HeaderText="AP" SortExpression="AccountPayable" />
                <asp:BoundField DataField="comments" HeaderText="comments" SortExpression="comments" />
                <asp:CheckBoxField DataField="Paid" HeaderText="Paid" SortExpression="Paid" />
            </Columns>
             <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
             <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
             <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
             <RowStyle BackColor="White" ForeColor="#330099" />
             <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
             <SortedAscendingCellStyle BackColor="#FEFCEB" />
             <SortedAscendingHeaderStyle BackColor="#AF0101" />
             <SortedDescendingCellStyle BackColor="#F6F0C0" />
             <SortedDescendingHeaderStyle BackColor="#7E0000" />
        </asp:GridView>

        <asp:SqlDataSource ID="InvoiceToClientSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" 
            OldValuesParameterFormatString="original_{0}"
            SelectCommand="SELECT * FROM [AggInvoiceClient] ORDER BY [Invoice]" 
            DeleteCommand="DELETE FROM AggInvoiceClient WHERE (Invoice = @original_Invoice AND ClientId = @original_ClientId)" 
            UpdateCommand="UPDATE AggInvoiceClient SET 
                                  AccountReceivable = @AccountReceivable, AccountPayable = @AccountPayable, 
                                  comments = @comments, Paid = @Paid 
                                  WHERE (ClientId = @original_clientId) AND (Invoice = @original_invoice)">
            <DeleteParameters>
                <asp:Parameter Name="original_invoice" />
                <asp:Parameter Name="original_clientId" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="AccountReceivable" />
                <asp:Parameter Name="AccountPayable" />
                <asp:Parameter Name="comments" />
                <asp:Parameter Name="Paid" />
                <asp:Parameter Name="original_clientId" />
                <asp:Parameter Name="original_invoice" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
