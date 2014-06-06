$(document).ready(function () {
    // create our add dialog  
    var dblock = $('#addDialog-block').dialog({
        autoOpen: false,
        draggable: true,
        resizable: true,
        width: 600,
        height: 400
    });
    dblock.parent().appendTo($("form:first"));
    $(".AddClientButtonClass").click(function () {
        var invoice = $(this).attr("invoice");
        $('#dialogInvoice').val(invoice);
        
        dblock.dialog('open');
    });

    // create our pay dialog  
    var pblock = $('#payDialog-block').dialog({
        autoOpen: false,
        draggable: true,
        resizable: false,
        width: 380,
        height: 310
    });
    pblock.parent().appendTo($("form:first"));

    $(".PayButtonClass").click(function () {
        var clientId = $(this).attr("clientId");
        var invoice = $(this).attr("invoice");
        $.post("ajaxTest.aspx", { clientId: clientId, invoice: invoice })
            .done(function (data) {
                pblock.html(data);
                pblock.dialog('open');
            });
    });

    // create our view dialog  
    var vblock = $('#viewDialog-block').dialog({
        autoOpen: false,
        draggable: true,
        resizable: false,
        width: 380,
        height: 310
    });
    vblock.parent().appendTo($("form:first"));

    $(".ReviewButtonClass").click(function () {
        var clientId = $(this).attr("clientId");
        var invoice = $(this).attr("invoice");

        $.post("showComment.aspx", { clientId: clientId, invoice: invoice })
            .done(function (data) {
                vblock.html(data);
                vblock.dialog('open');
            });
    });

    $(".ExpandButtonClass").click(function () {
        var invoice = $(this).attr("invoice");
        $(".inv" + invoice).slideToggle();
    });
});