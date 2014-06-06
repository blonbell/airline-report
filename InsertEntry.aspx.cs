using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;

public partial class InsertEntry : System.Web.UI.Page {

    protected void Page_Load(object sender, EventArgs e) {

    }

    protected void InsertButton_Click(object sender, EventArgs e) {
        //make TReport entry
        insertTReport();

        //make agginvclient entry for each receivable
        HashSet<Client> recList = GlobalClientList.recList;
        foreach (Client client in recList) {
            addClientToInvoice(client, true);
        }

        //make agginvclient entry for each payable
        HashSet<Client> payList = GlobalClientList.payList;
        foreach (Client client in payList) {
            addClientToInvoice(client, false);
        }



        GlobalClientList.clear();
        populateListBox(lbRecNames, GlobalClientList.recList);
        populateListBox(lbPayNames, GlobalClientList.payList);

        DoneMsg.Text = "Entry " + txtInvoice.Text + " has been added";

        txtAP.Text = "";
        txtAR.Text = "";
        txtBSP.Text = "";
        txtCC.Text = "";
        txtCommAgent.Text = "";
        txtCommAir.Text = "";
        txtGSTC.Text = "";
        txtGSTP.Text = "";
        txtNetRemit.Text = "";
        txtInvoice.Text = "";
        txtTransDate.Text = "";
        txtRebate.Text = "";
    }

    protected void addClientToInvoice(Client client, Boolean isReceivable) {
        string ar="", ap="";
        if (isReceivable) {
            ar = client.amount.ToString();
        } else {
            ap = client.amount.ToString();
        }

        ClientDataSource.UpdateCommandType = SqlDataSourceCommandType.StoredProcedure;
        ClientDataSource.UpdateCommand = "dbo.AddClientToInvoice";

        ClientDataSource.UpdateParameters.Clear();
        ClientDataSource.UpdateParameters.Add(new Parameter("Invoice", System.TypeCode.String, txtInvoice.Text));
        ClientDataSource.UpdateParameters.Add(new Parameter("Name", System.TypeCode.String,  client.name));
        ClientDataSource.UpdateParameters.Add(new Parameter("AccountPayable", System.TypeCode.Decimal, ap));
        ClientDataSource.UpdateParameters.Add(new Parameter("AccountReceivable", System.TypeCode.Decimal, ar));
        ClientDataSource.UpdateParameters.Add(new Parameter("comments", System.TypeCode.String, client.comment));
        ClientDataSource.UpdateParameters.Add(new Parameter("paid", System.TypeCode.Boolean, client.paid.ToString()));
        
        ClientDataSource.Update();
    }

    private void insertTReport()
    {
        Configuration rootWebConfig =
            System.Web.Configuration.WebConfigurationManager.OpenWebConfiguration("~\\");
        ConnectionStringSettings connString =
            rootWebConfig.ConnectionStrings.ConnectionStrings["ReportingDBConnectionString"];

        SqlConnection connection = new SqlConnection(connString.ConnectionString);
        connection.Open();
        string insertGroup = "INSERT INTO TReport(TransactionDate, Invoice, CCAmount, " +
            "CommissionAirline, CommissionAgent, AccountReceivable, AccountPayable, BSPGST, " +
            "NetRemit, Rebate, GSTCollected, GSTPaid) VALUES (@TD, @Inv, @CCA, " +
            "@Airline, @Agent, @AR, @AP, @BSP, @Remit, @Rebate, @GSTC, @GSTP)";
        SqlCommand cmd = new SqlCommand(insertGroup, connection);
        cmd.Parameters.Add(new SqlParameter("TD", txtTransDate.Text));
        cmd.Parameters.Add(new SqlParameter("Inv", txtInvoice.Text));
        if (String.IsNullOrEmpty(txtCC.Text))
        {
            cmd.Parameters.Add(new SqlParameter("CCA", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("CCA", float.Parse(txtCC.Text)));
        }

        if (String.IsNullOrEmpty(txtCommAir.Text))
        {
            cmd.Parameters.Add(new SqlParameter("Airline", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("Airline", float.Parse(txtCommAir.Text)));
        }

        if (String.IsNullOrEmpty(txtCommAgent.Text))
        {
            cmd.Parameters.Add(new SqlParameter("Agent", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("Agent", float.Parse(txtCommAgent.Text)));
        }

        if (String.IsNullOrEmpty(txtAR.Text))
        {
            cmd.Parameters.Add(new SqlParameter("AR", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("AR", float.Parse(txtAR.Text)));
        }

        if (String.IsNullOrEmpty(txtAP.Text))
        {
            cmd.Parameters.Add(new SqlParameter("AP", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("AP", float.Parse(txtAP.Text)));
        }

        if (String.IsNullOrEmpty(txtBSP.Text))
        {
            cmd.Parameters.Add(new SqlParameter("BSP", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("BSP", float.Parse(txtBSP.Text)));
        }

        if (String.IsNullOrEmpty(txtNetRemit.Text))
        {
            cmd.Parameters.Add(new SqlParameter("Remit", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("Remit", float.Parse(txtNetRemit.Text)));
        }

        if (String.IsNullOrEmpty(txtRebate.Text))
        {
            cmd.Parameters.Add(new SqlParameter("Rebate", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("Rebate", float.Parse(txtRebate.Text)));
        }

        if (String.IsNullOrEmpty(txtGSTC.Text))
        {
            cmd.Parameters.Add(new SqlParameter("GSTC", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("GSTC", float.Parse(txtGSTC.Text)));
        }

        if (String.IsNullOrEmpty(txtGSTP.Text))
        {
            cmd.Parameters.Add(new SqlParameter("GSTP", DBNull.Value));
        }
        else
        {
            cmd.Parameters.Add(new SqlParameter("GSTP", float.Parse(txtGSTP.Text)));
        }

        cmd.ExecuteNonQuery();

        connection.Close();
    }

    private void populateListBox(ListBox listBox, HashSet<Client> clients) {
        listBox.Items.Clear();

        foreach (Client client in clients) {
            ListItem item = new ListItem();
            item.Value = client.name;
            item.Text = client.name;
            listBox.Items.Add(item);
        }
    }

    protected void btnAddRec_Click(object sender, EventArgs e) {
        Client receivable = new Client(txtRecName.Text, 
                                       Convert.ToDouble(txtRecAmount.Text), 
                                       txtRecComment.Text, 
                                       cbxRecPaid.Checked);

        GlobalClientList.addReceivable(receivable);
        populateListBox(lbRecNames, GlobalClientList.recList);

        txtRecName.Text = "";
        txtRecAmount.Text = "";
        txtRecComment.Text = "";
        cbxRecPaid.Checked = false;
    }

    protected void btnAddPay_Click(object sender, EventArgs e) {
        Client payable = new Client(txtPayName.Text, 
                                    Convert.ToDouble(txtPayAmount.Text), 
                                    txtPayComment.Text, 
                                    cbxPayPaid.Checked);
        GlobalClientList.addPayable(payable);
        populateListBox(lbPayNames, GlobalClientList.payList);

        txtPayName.Text = "";
        txtPayAmount.Text = "";
        txtPayComment.Text = "";
        cbxPayPaid.Checked = false;
    }

    protected void btnRemRec_Click(object sender, EventArgs e) {
        String clientName = lbRecNames.SelectedValue;
        GlobalClientList.removeReceivable(clientName);

        populateListBox(lbRecNames, GlobalClientList.recList);
    }

    protected void btnRemPay_Click(object sender, EventArgs e) {
        String clientName = lbPayNames.SelectedValue;
        GlobalClientList.removePayable(clientName);

        populateListBox(lbPayNames, GlobalClientList.payList);
    }
}