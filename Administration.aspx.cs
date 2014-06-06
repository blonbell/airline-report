using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Administration : System.Web.UI.Page {
    
    TableRow row1 = new TableRow(),
             row2 = new TableRow();

    protected void Page_Load(object sender, EventArgs e) {
        //makeTable();
    }

    public void makeTable() {
        Table table = new Table();
        table.BorderStyle = BorderStyle.Double;
        table.CellPadding = 20;
        table.GridLines = GridLines.Both; 

        TableCell c00, c01, c02, c03,
                  d00, d01, d03;

        c00 = new TableCell();
        c00.ID = "c00";
        Button j = new Button();
        
        j.Click += new EventHandler(this.j_Click);
        j.ID = "HideButton";
        j.Text = "press me";
        c00.Controls.Add(j);

        c01 = new TableCell();
        c01.ID = "c01";
        c01.Text = "Something";
        
        c02 = new TableCell();
        c02.ID = "c02";
        Label k = new Label();
        k.Text = "ASDF\n";
        LiteralControl k2 = new LiteralControl();
        k2.Text = "BCEDF";
        c02.Controls.Add(k);
        c02.Controls.Add(k2);

        d00 = new TableCell();
        d00.Text = "asdf";
        

        d01 = new TableCell();
        d01.ColumnSpan = 2;

        d03 = new TableCell();
        d03.Text = "test";

        row1.Cells.Add(c00);
        row1.Cells.Add(c01);
        row1.Cells.Add(c02);

        row2.Controls.Add(d00);
        row2.Controls.Add(d01);
        row2.Controls.Add(d03);

        table.Rows.Add(row1);
        table.Rows.Add(row2);
        Form.Controls.Add(table);

        Button Button1 = new Button();
        Button1.Text = "Error";
        Button1.Click += new EventHandler(this.GreetingBtn_Click);

        Form.Controls.Add(Button1);
    }

    public void j_Click(Object sender, EventArgs e) {
        row2.Visible = !row2.Visible;
    }

    public void GreetingBtn_Click(Object sender, EventArgs e) {
        // When the button is clicked,
        // change the button text, and disable it.

        Button clickedButton = (Button)sender;
        clickedButton.Text = "...button clicked...";
        clickedButton.Enabled = false;
    }
}