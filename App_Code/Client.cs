using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Receivable
/// </summary>
public class Client {

	public Client(String name, double amount, String comment, Boolean paid) {
        this.name = name;
        this.amount = amount;
        this.comment = comment;
        this.paid = paid;
    }

    public String name {
        get; set;
    }

    public double amount {
        get; set;
    }

    public String comment {
        get; set;
    }

    public Boolean paid {
        get; set;
    }
}