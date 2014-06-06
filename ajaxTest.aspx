<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ajaxTest.aspx.cs" Inherits="website_Default" %>

<form id="form1" runat="server">
    <div id="divPayBox" runat="server" style="width:300px; height:200px; border:double; padding:10px;">
        <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
        <hr >
        <asp:textbox id="CommentBox" runat="server" Height="106px" TextMode="MultiLine" Width="272px"></asp:textbox>
        <asp:Button ID="PayButton" runat="server" Text="Pay" OnClick="PayButton_Click" />
        
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" 
            OldValuesParameterFormatString="original_{0}"
            SelectCommand="SELECT Invoice, ClientId FROM AggInvoiceClient" 
            UpdateCommand="UPDATE AggInvoiceClient 
                           SET comments = @Comments, Paid = 1 
                           WHERE (Invoice = @invoice AND ClientId = @clientId) ">
        </asp:SqlDataSource>
    </div>
</form>