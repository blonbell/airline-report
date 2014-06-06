using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

// Error prone when it's accessed asynchronously
public static class GlobalClientList {

    private static HashSet<Client> _recList = new HashSet<Client>(),
                                   _payList = new HashSet<Client>();

    public static HashSet<Client> recList {
	    get { return _recList; } 
        set { _recList = value;}
    }

    public static HashSet<Client> payList {
	    get { return _payList; } 
        set { _payList = value;}
    }

    public static void clear() {
        _recList.Clear();
        _payList.Clear();
    }

    public static void addReceivable(Client rec) {
        foreach (Client client in _recList) {
            if (client.name.Equals(rec.name)) {
                return;
            }
        }
        _recList.Add(rec);
    }

    public static void removeReceivable(Client rec) {
        _recList.Remove(rec);
    }

    public static void removeReceivable(String recName) {
        Client c = null;
        foreach (Client client in _recList) {
            if (client.name.Equals(recName)) {
                c = client;
            }
        }
        if (c != null) {
            removeReceivable(c);
        }
    }

    public static void addPayable(Client pay) {
        foreach (Client client in _payList) {
            if (client.name.Equals(pay.name)) {
                return;
            }
        }
        _payList.Add(pay);
    }

    public static void removePayable(Client pay) {
        _payList.Remove(pay);
    }

    public static void removePayable(String payName) {
        Client c = null;
        foreach (Client client in _recList) {
            if (client.name.Equals(payName)) {
                c = client;
            }
        }
        if (c != null) {
            removePayable(c);
        }
    }
}