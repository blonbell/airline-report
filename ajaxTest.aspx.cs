using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class website_Default : System.Web.UI.Page {
    HiddenField hidInvoice = new HiddenField(),
                hidClientId = new HiddenField();

    protected void Page_Load(object sender, EventArgs e) {
        hidInvoice.Value = Request.Form["invoice"];
        Form.Controls.Add(hidInvoice);

        hidClientId.Value = Request.Form["clientId"];
        Form.Controls.Add(hidClientId);

        lblTitle.Text = "Pay Invoice #" + Request.Form["invoice"] + " client " + Request.Form["clientId"];
    }

    protected void PayButton_Click(object sender, EventArgs e) { 
        SqlDataSource1.UpdateCommandType = SqlDataSourceCommandType.Text;
                SqlDataSource1.UpdateParameters.Add(new Parameter("Comments", 
                System.TypeCode.String, CommentBox.Text));

        SqlDataSource1.UpdateParameters.Add(new Parameter("invoice", 
                System.TypeCode.String, hidInvoice.Value));
        SqlDataSource1.UpdateParameters.Add(new Parameter("clientId", 
                System.TypeCode.Int32, hidClientId.Value));
        SqlDataSource1.Update();

        Response.Redirect("~/CreateReport.aspx", true);
    }
}