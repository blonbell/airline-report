<%@ Page Language="C#" AutoEventWireup="true" CodeFile="showComment.aspx.cs" Inherits="commentsDefault" %>

<form action="updatePaid.aspx" method="post" runat="server">
    <div id="divPayBox" runat="server" style="border-style: double; border-color: inherit; border-width: medium; width:300px; height:174px; padding:10px;">
        <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
        <br />
        <hr >
        <asp:label id="lblComment" runat="server" text=""></asp:label>
        <asp:sqldatasource id="CommentSource" runat="server" 
            ConnectionString="<%$ ConnectionStrings:ReportingDBConnectionString %>" 
            SelectCommand=  "SELECT [comments] FROM [AggInvoiceClient] 
                            WHERE ([ClientId] = @ClientId AND [Invoice] = @Invoice)">
            <SelectParameters>
                <asp:FormParameter FormField="clientId" Name="ClientId" Type="Int32" />
                <asp:FormParameter FormField="invoice" Name="Invoice" Type="String" />
            </SelectParameters>
        </asp:sqldatasource>
        </div>
</form>