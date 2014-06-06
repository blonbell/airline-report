using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Reporting : System.Web.UI.Page {

    Double[] footerTotals = new Double[10];
    Double profitTotal = 0.0;

    protected void Page_Load(object sender, EventArgs e) {
        if (Page.IsPostBack) {
            Session.Add("startDate", txtStartDate.Text);
            Session.Add("endDate", txtEndDate.Text);
            Session.Add("clientId", ddlClients.SelectedValue);
        } else {
            txtStartDate.Text = Session["startDate"] as String;
            txtEndDate.Text = Session["endDate"] as String;
            ddlClients.SelectedValue = Session["clientId"] as String;
        }
    }

    protected void PayButton_Click(object sender, EventArgs e) {
        Configuration rootWebConfig =
            System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~\\");
        ConnectionStringSettings connString =
            rootWebConfig.ConnectionStrings.ConnectionStrings["ReportingDBConnectionString"];

        SqlConnection connection = new SqlConnection(connString.ConnectionString);
    
        connection.Open();
        
        string updateClient = "UPDATE AggInvoiceClient " +
                "SET paid=1 " +
                "WHERE ClientId=@ClientId AND Invoice=@Invoice";
        
        SqlCommand cmd = new SqlCommand(updateClient, connection);
        
        Button btnPayThis = (Button) sender;
        string invoice = btnPayThis.Attributes["Invoice"];
        string clientId = btnPayThis.Attributes["ClientId"];
        Response.Write("Invoice" + invoice + ", " + clientId);
    }

    protected void SubmitPayButton_Click(object sender, EventArgs e) {
        string accountType = rblAccountType.SelectedValue;
        string amt = dialogAmount.Text;
        string ar="", ap="";
        if (accountType.Equals("P")) {
            ap = amt;
        } else if (accountType.Equals("R")) {
            ar = amt;
        }

        AddClientSource.UpdateCommandType = SqlDataSourceCommandType.StoredProcedure;
        AddClientSource.UpdateCommand = "dbo.AddClientToInvoice";

        AddClientSource.UpdateParameters.Add(new Parameter("Invoice", System.TypeCode.String, dialogInvoice.Text));
        AddClientSource.UpdateParameters.Add(new Parameter("Name", System.TypeCode.String,  dialogClientName.Text));
        AddClientSource.UpdateParameters.Add(new Parameter("AccountPayable", System.TypeCode.Decimal, ap));
        AddClientSource.UpdateParameters.Add(new Parameter("AccountReceivable", System.TypeCode.Decimal, ar));
        AddClientSource.UpdateParameters.Add(new Parameter("comments", System.TypeCode.String, CommentBox.Text));
        AddClientSource.UpdateParameters.Add(new ControlParameter("paid", "cbxPaid", "Checked"));
        
        AddClientSource.Update();

        Response.Redirect("~/CreateReport.aspx", true);
    }

    public string calcTotal(Object al, Object ag, Object ar, Object ap, Object reb, Object gstc, Object gstp) {
        Double E = convertToDouble(al),
               F = convertToDouble(ag),
               G = convertToDouble(ar),
               H = convertToDouble(ap),
               K = convertToDouble(reb),
               L = convertToDouble(gstc),
               M = convertToDouble(gstp);
       
        Double total = E + F + G - H - K - L + M;
        profitTotal += total;
        return String.Format("{0:c}", total);
    }

    public Double convertToDouble(Object obj) {
        try {
            return Convert.ToDouble(obj);
        } catch (InvalidCastException ex) {
            return 0.0;
        }
    }

    protected void ReportGridView_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            DataRowView datarows = (DataRowView) e.Row.DataItem;

            if (!isPrincipleRow(datarows["zIndex"])) {
                e.Row.CssClass = "trSecondaryRow inv" + datarows["invoice"];
            } else {
                for (int i=4; i < 14; i++) {
                    footerTotals[i-4] += convertToDouble(datarows[i]);
                }
            }

            Button pvButton = new Button();
            if (!isPaidRow(datarows["Paid"]) && !isPrincipleRow(datarows["zIndex"])) {
                pvButton.Text = "Pay";
                pvButton.CssClass = "PayButtonClass";  
            } else if(isPaidRow(datarows["Paid"]) && !isPrincipleRow(datarows["zIndex"])) {
                pvButton.Text = "View";
                pvButton.CssClass = "ReviewButtonClass";
            } else if(isPrincipleRow(datarows["zIndex"])) {
                pvButton.Text = "Add";
                pvButton.CssClass = "AddClientButtonClass";
            }
            pvButton.Attributes.Add("invoice", datarows["invoice"].ToString());
            pvButton.Attributes.Add("clientId", datarows["clientId"].ToString());
            pvButton.OnClientClick = "return false";
            e.Row.Cells[0].Controls.Add(pvButton);

            for (int i = 6; i < 16; i++) {
                e.Row.Cells[i].Text = convertNumbersToChinese(e.Row.Cells[i].Text);
            }
        } else if (e.Row.RowType == DataControlRowType.Footer) {
            e.Row.Cells[0].Text = "Report Summary";
            for (int i=4; i < 14; i++) {
                e.Row.Cells[i+2].Text = convertNumbersToChinese(String.Format("{0:c}", footerTotals[i-4]));
            }
            
            lblSummaryAR.Text = convertNumbersToChinese(String.Format("{0:C}", footerTotals[3]));
            lblSummaryCC.Text = convertNumbersToChinese(String.Format("{0:C}", footerTotals[0]));
            
            double commRec = footerTotals[1] + footerTotals[2] + footerTotals[5];
            lblSummarySales.Text =  convertNumbersToChinese(String.Format("{0:C}", (footerTotals[0] + footerTotals[3]) -
                                    (footerTotals[8] + footerTotals[7])));
            lblSummaryGSTC.Text = convertNumbersToChinese(String.Format("{0:C}", footerTotals[8]));
            lblSummaryRebate.Text = convertNumbersToChinese(String.Format("{0:C}", footerTotals[7]));
            lblSummaryPur.Text = convertNumbersToChinese(String.Format("{0:C}", (footerTotals[4] + footerTotals[0] + footerTotals[5]) -
                                    (footerTotals[9] + commRec)));                
            lblSummaryGSTP.Text = convertNumbersToChinese(String.Format("{0:C}", footerTotals[9]));
            lblSummaryCommRec.Text = convertNumbersToChinese(String.Format("{0:C}", commRec));

            lblSummaryAP.Text = convertNumbersToChinese(String.Format("{0:C}", footerTotals[4]));
            lblSummaryCC2.Text = convertNumbersToChinese(String.Format("{0:C}", footerTotals[0]));
            lblSummaryBSP.Text = convertNumbersToChinese(String.Format("{0:C}", footerTotals[5]));
            
            e.Row.Cells[16].Text = convertNumbersToChinese(String.Format("{0:c}", profitTotal));
        }
    }

    public String convertNumbersToChinese(String numberStr) {
        if (false)
            return numberStr.Replace('0','零').
                Replace('1','一').
                Replace('2','二').
                Replace('3','三').
                Replace('4','四').
                Replace('5','五').
                Replace('6','六').
                Replace('7','七').
                Replace('8','八').
                Replace('9','九');
        else
            return numberStr;
    }

    public Boolean isPrincipleRow(Object zIndex) {
        int z = Convert.ToInt32(zIndex);
        return z == 1;
    }
    
    public Boolean isPaidRow(Object paid) {
        if (paid == null || DBNull.Value.Equals(paid)) {
            return false;
        }
        int p = Convert.ToInt16(paid);
        return p == 1;
    }

    protected void ReportingSource_Selected(object sender, SqlDataSourceStatusEventArgs e) {
        int rowCount = e.AffectedRows;
        if (e.AffectedRows > 0) {
            divSummaryBox.Visible = true;
        } else {
            divSummaryBox.Visible = false;
        }
    }
}