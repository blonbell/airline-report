using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewReport : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        String text = Request.Form["startDatePicker.SelectedDate"];
        Label1.Text = text;

        String text2 = Request.Form["endDatePicker.SelectedDate"];
        Label2.Text = text2;

        String text3 = Request.Form["Hidden1"];
        Label3.Text = text3;
    }
    protected void payButton_Click(object sender, EventArgs e)
    {

    }
    protected void reviewButton_Click(object sender, EventArgs e)
    {

    }
}