using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class commentsDefault : System.Web.UI.Page {

    protected void Page_Load(object sender, EventArgs e) {
        lblTitle.Text = "Pay Invoice #" + Request.Form["invoice"] + " client " + Request.Form["clientId"];
        DataView dv = (DataView) CommentSource.Select(DataSourceSelectArguments.Empty);
        if (!System.DBNull.Value.Equals(dv.Table.Rows[0][0])) {
            lblComment.Text = (String) (dv.Table.Rows[0][0]);
        }
    }
}