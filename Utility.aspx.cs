using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Utility : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e) {
        
        DoneMsg.Text = "The entry has been deleted " + e.Keys.Values.Count + " " + e.Values[0];
    }
    protected void GridView1_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        DoneMsg.Text = "The entry has been updated";
    }
    protected void InvoiceToClientView_RowDeleting(object sender, GridViewDeleteEventArgs e) {
        foreach(DictionaryEntry entry in e.Values) {
            Response.Write(entry.Key + " " + entry.Value);
        }
        DoneMsg.Text = "The entry " + e.RowIndex + " " +".";
    }
}