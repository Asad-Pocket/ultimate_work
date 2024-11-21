<%@ Application Language="VB" %>
<%@ Import Namespace="System.Globalization" %>
<script RunAt="server">
    Protected Sub Application_BeginRequest(ByVal sender As [Object], ByVal e As EventArgs)


        Dim newCulture As CultureInfo = DirectCast(System.Threading.Thread.CurrentThread.CurrentCulture.Clone(), CultureInfo)
        newCulture.DateTimeFormat.ShortDatePattern = "dd-MM-yyyy"
        newCulture.DateTimeFormat.DateSeparator = "-"
        Threading.Thread.CurrentThread.CurrentCulture = newCulture
    End Sub
    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application startup
        RegisterRoute(Routing.RouteTable.Routes)
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs on application shutdown
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when an unhandled error occurs
    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a new session is started
        Dim domainName As String
        domainName = ConfigurationManager.AppSettings("RedirectUrl").ToString

        Session("domainName") = domainName
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Code that runs when a session ends. 
        ' Note: The Session_End event is raised only when the sessionstate mode
        ' is set to InProc in the Web.config file. If session mode is set to StateServer 
        ' or SQLServer, the event is not raised.
    End Sub
    Sub RegisterRoute(ByVal routes As Routing.RouteCollection)

        ''//Global Item
        routes.MapPageRoute("Default", "Default", "~/Default.aspx")
        routes.MapPageRoute("CompanySelect", "CompanySelect", "~/CompanySelect.aspx")
        routes.MapPageRoute("Dashboard", "Dashboard", "~/Dashboard.aspx")
        routes.MapPageRoute("UpdateCompanyInfo", "UpdateCompanyInfo", "~/UpdateCompanyInfo.aspx")
        routes.MapPageRoute("Accessdenied", "Accessdenied", "~/Accessdenied.aspx")
        'Folder SharedItems
        '---------------------------------
        '//User Section 
        routes.MapPageRoute("UserAdd", "UserAdd", "~/SharedItems/UserAdd.aspx")
        routes.MapPageRoute("UserList", "UserList", "~/SharedItems/UserList.aspx")
        routes.MapPageRoute("StoreAdd", "StoreAdd", "~/SharedItems/StoreAdd.aspx")
        routes.MapPageRoute("Stores", "Stores", "~/SharedItems/Stores.aspx")
        routes.MapPageRoute("TermsCondition", "TermsCondition", "~/SharedItems/TermsCondition.aspx")


        routes.MapPageRoute("CustomerAdd", "CustomerAdd", "~/SharedItems/CustomerAdd.aspx")
        routes.MapPageRoute("Customers", "Customers", "~/SharedItems/Customers.aspx")
        routes.MapPageRoute("SupplierAdd", "SupplierAdd", "~/SharedItems/SupplierAdd.aspx")
        routes.MapPageRoute("Suppliers", "Suppliers", "~/SharedItems/Suppliers.aspx")

        '//settings
        routes.MapPageRoute("ProductCategoryAdd", "ProductCategoryAdd", "~/SharedItems/ProductCategoryAdd.aspx")
        routes.MapPageRoute("ProductCategoryList", "ProductCategoryList", "~/SharedItems/ProductCategoryList.aspx")
        routes.MapPageRoute("ProductAdd", "ProductAdd", "~/SharedItems/ProductAdd.aspx")
        routes.MapPageRoute("Products", "Products", "~/SharedItems/Products.aspx")
        routes.MapPageRoute("PlaceTypeAdd", "PlaceTypeAdd", "~/SharedItems/PlaceTypeAdd.aspx")
        routes.MapPageRoute("PlaceType", "PlaceType", "~/SharedItems/PlaceType.aspx")
        routes.MapPageRoute("Brands", "Brands", "~/SharedItems/Brands.aspx")
        routes.MapPageRoute("UnitAdd", "UnitAdd", "~/SharedItems/UnitAdd.aspx")
        routes.MapPageRoute("UNIT", "UNIT", "~/SharedItems/Unit.aspx")
        routes.MapPageRoute("PartyAdd", "PartyAdd", "~/SharedItems/PartyAdd.aspx")
        routes.MapPageRoute("Party", "Party", "~/SharedItems/Party.aspx")

        '---------------------------------


        '//Folder UAccess
        '---------------------------------
        routes.MapPageRoute("MainModule", "MainModule", "~/UAccess/MainModule.aspx")
        routes.MapPageRoute("ModuleAccess", "ModuleAccess", "~/UAccess/ModuleAccess.aspx")
        routes.MapPageRoute("ModuleAdd", "ModuleAdd", "~/UAccess/ModuleAdd.aspx")
        routes.MapPageRoute("ModuleSubMenu", "ModuleSubMenu", "~/UAccess/ModuleSubMenu.aspx")
        routes.MapPageRoute("ModuleSubMenuAdd", "ModuleSubMenuAdd", "~/UAccess/ModuleSubMenuAdd.aspx")
        routes.MapPageRoute("UserAccess", "UserAccess", "~/UAccess/UserAccess.aspx")
        routes.MapPageRoute("UserRole", "UserRole", "~/UAccess/UserRole.aspx")
		routes.MapPageRoute("RoleAdd", "RoleAdd", "~/UAccess/RoleAdd.aspx")




        '//AutoParts
        '----------------------------------------

        '//Sale   

        routes.MapPageRoute("SalesEntry", "SalesEntry", "~/AutoParts/SalesEntry.aspx")
        routes.MapPageRoute("Sales", "Sales", "~/AutoParts/Sales.aspx")
        routes.MapPageRoute("DeliveyChallanprint", "DeliveyChallanprint", "~/AutoParts/DeliveyChallanprint.aspx")
        routes.MapPageRoute("SaleDetailprev", "SaleDetailprev", "~/AutoParts/SaleDetailprev.aspx")
        routes.MapPageRoute("SaleReturnEntry", "SaleReturnEntry", "~/AutoParts/SaleReturnEntry.aspx")
        routes.MapPageRoute("SalesreturnList", "SalesreturnList", "~/AutoParts/SalesreturnList.aspx")
        routes.MapPageRoute("SaleLedger", "SaleLedger", "~/AutoParts/SaleLedger.aspx")
        routes.MapPageRoute("SaleLedgerPreview", "SaleLedgerPreview", "~/AutoParts/SaleLedgerPreview.aspx")
        routes.MapPageRoute("SaleReturnprint", "SaleReturnprint", "~/AutoParts/SaleReturnprint.aspx")
        routes.MapPageRoute("DailySaleSheet", "DailySaleSheet", "~/AutoParts/DailySaleSheet.aspx")
        routes.MapPageRoute("productconversionentry", "stock-conversion-entry", "~/AutoParts/productconversionentry.aspx")
        routes.MapPageRoute("productconversionlist", "stock-conversion-list", "~/AutoParts/productconversionlist.aspx")
        routes.MapPageRoute("stockconversionview", "stock-conversion-view", "~/AutoParts/stockconversionview.aspx")


        '//PurchaseOrderEntry
        routes.MapPageRoute("PurchaseOrderEntry", "PurchaseOrderEntry", "~/AutoParts/PurchaseOrderEntry.aspx")
        routes.MapPageRoute("PurchaseOrderList", "PurchaseOrderList", "~/AutoParts/PurchaseOrderList.aspx")
        routes.MapPageRoute("PurchaseEntry", "PurchaseEntry", "~/AutoParts/PurchaseEntry.aspx")
        routes.MapPageRoute("Purchase", "Purchase", "~/AutoParts/Purchase.aspx")
        routes.MapPageRoute("PurchaseReturnEntry", "PurchaseReturnEntry", "~/AutoParts/PurchaseReturnEntry.aspx")
        routes.MapPageRoute("PurchaseReturn", "PurchaseReturn", "~/AutoParts/PurchaseReturn.aspx")
        routes.MapPageRoute("ReportonProductwisepurchase", "ReportonProductwisepurchase", "~/AutoParts/ReportonProductwisepurchase.aspx")
        routes.MapPageRoute("ReportonProductwisepurchasePDF", "ReportonProductwisepurchasePDF", "~/AutoParts/ReportonProductwisepurchasePDF.aspx")
        routes.MapPageRoute("ReportonProductwisesale", "ReportonProductwisesale", "~/AutoParts/ReportonProductwisesale.aspx")
        routes.MapPageRoute("ReportonProductwisesalePDF", "ReportonProductwisesalePDF", "~/AutoParts/ReportonProductwisesalePDF.aspx")



        '//ProductTransfer
        routes.MapPageRoute("ProductTransfer", "ProductTransfer", "~/AutoParts/ProductTransfer.aspx")
        routes.MapPageRoute("ProductTransferAdd", "ProductTransferAdd", "~/AutoParts/ProductTransferAdd.aspx")
        routes.MapPageRoute("producttransferdetails", "producttransferdetails", "~/AutoParts/producttransferdetails.aspx")
        routes.MapPageRoute("producttransferreceivedetails", "producttransferreceivedetails", "~/AutoParts/producttransferreceivedetails.aspx")
        routes.MapPageRoute("TransferPrint", "TransferPrint", "~/AutoParts/TransferPrint.aspx")
        routes.MapPageRoute("transferReceive", "transferReceive", "~/AutoParts/transferReceive.aspx")
        routes.MapPageRoute("WastageEntry", "WastageEntry", "~/AutoParts/WastageEntry.aspx")
        routes.MapPageRoute("WastageList", "WastageList", "~/AutoParts/WastageList.aspx")
        routes.MapPageRoute("Stockledgernew", "Stockledgernew", "~/AutoParts/Stockledgernew.aspx")
        routes.MapPageRoute("FOB", "FOB", "~/AutoParts/LcWiseFobRate.aspx")
        routes.MapPageRoute("StockLedgerPDF", "StockLedgerPDF", "~/AutoParts/StockLedgerPDF.aspx")
        routes.MapPageRoute("PurchaseLedger", "PurchaseLedger", "~/AutoParts/PurchaseLedger.aspx")
        routes.MapPageRoute("SupplierLedgerPreview", "SupplierLedgerPreview", "~/AutoParts/SupplierLedgerPreview.aspx")
        routes.MapPageRoute("TransferDetailsList", "TransferDetailsList", "~/AutoParts/TransferDetailsList.aspx")
        routes.MapPageRoute("TransferReceiveUpdate", "TransferReceiveUpdate", "~/AutoParts/TransferReceiveUpdate.aspx")
        routes.MapPageRoute("ProductAdjustment", "ProductAdjustment", "~/AutoParts/ProductAdjustment.aspx")
        routes.MapPageRoute("ProductAdjustmentList", "ProductAdjustmentList", "~/AutoParts/ProductAdjustmentList.aspx")





        '//LC
        '-----------------------------------------------
        routes.MapPageRoute("LCInfoEntry", "LCInfoEntry", "~/LC/LCInfoEntry.aspx")
        routes.MapPageRoute("LCInfoList", "LCInfoList", "~/LC/LCInfoList.aspx")
        routes.MapPageRoute("LCShipmentExpensePDF", "LCShipmentExpensePDF", "~/LC/LCShipmentExpensePDF.aspx")
        routes.MapPageRoute("LCShipmentOverview", "LCShipmentOverview", "~/LC/LCShipmentOverview.aspx")
        routes.MapPageRoute("LCShipmentOverviewPDF", "LCShipmentOverviewPDF", "~/LC/LCShipmentOverviewPDF.aspx")
        routes.MapPageRoute("LCExpenseEntry", "LCExpenseEntry", "~/LC/LCExpenseEntry.aspx")
        routes.MapPageRoute("LCExpenseList", "LCExpenseList", "~/LC/LCExpenseList.aspx")
        routes.MapPageRoute("lc-custom-duty-calculation", "lc-custom-duty-calculation", "~/LC/lc-custom-duty-calculation.aspx")

        '//Accounts
        '----------------------------------------
        routes.MapPageRoute("AccHeadAdd", "AccHeadAdd", "~/Accounts/AccHeadAdd.aspx")
        routes.MapPageRoute("AccHeadList", "AccHeadList", "~/Accounts/AccHeadList.aspx")
        routes.MapPageRoute("ReceivePaymentVoucherAdd", "ReceivePaymentVoucherAdd", "~/Accounts/ReceivePaymentVoucherAdd.aspx")
        routes.MapPageRoute("ReceivePaymentVoucherlist", "ReceivePaymentVoucherlist", "~/Accounts/ReceivePaymentVoucherlist.aspx")
        routes.MapPageRoute("JournalVoucherAdd", "JournalVoucherAdd", "~/Accounts/JournalVoucherAdd.aspx")
        routes.MapPageRoute("JournalVoucherList", "JournalVoucherList", "~/Accounts/JournalVoucherList.aspx")
        routes.MapPageRoute("ChequeEntry", "ChequeEntry", "~/Accounts/ChequeEntry.aspx")
        routes.MapPageRoute("Cheques", "Cheques", "~/Accounts/Cheques.aspx")
        routes.MapPageRoute("chequereceive", "chequereceive", "~/Accounts/chequereceive.aspx")
        routes.MapPageRoute("ChequesView", "ChequesView", "~/Accounts/ChequesView.aspx")
        routes.MapPageRoute("VoucherList", "VoucherList", "~/Accounts/VoucherList.aspx")
        routes.MapPageRoute("VoucherListPreview", "VoucherListPreview", "~/Accounts/VoucherListPreview.aspx")
        routes.MapPageRoute("VoucherListDetails", "VoucherListDetails", "~/Accounts/VoucherListDetails.aspx")
        routes.MapPageRoute("VoucherForm", "VoucherForm", "~/Accounts/VoucherForm.aspx")
        routes.MapPageRoute("CusPaymentPrint", "CusPaymentPrint", "~/Accounts/Cuspaymentprint.aspx")
        routes.MapPageRoute("MoneyReceiptPriview", "MoneyReceiptPriview", "~/Accounts/MoneyReceiptPriview.aspx")
        routes.MapPageRoute("JournalPrint", "JournalPrint", "~/Accounts/JournalPrint.aspx")
        routes.MapPageRoute("cogs", "cogs", "~/Accounts/cogs.aspx")
        routes.MapPageRoute("ChequeDetailsView", "ChequeDetailsView", "~/Accounts/ChequeDetailsView.aspx")

        routes.MapPageRoute("CashBook", "CashBook", "~/Accounts/CashBook.aspx")
        routes.MapPageRoute("BankBook", "BankBook", "~/Accounts/BankBook.aspx")
        routes.MapPageRoute("LedgerShow", "LedgerShow", "~/Accounts/LedgerShow.aspx")
        routes.MapPageRoute("TrialBalanceShow", "TrialBalanceShow", "~/Accounts/TrialBalanceShow.aspx")
        routes.MapPageRoute("TrialBalanceDateRange", "TrialBalanceDateRange", "~/Accounts/TrialBalanceDateRange.aspx")
        routes.MapPageRoute("TrialBalanceDateRangePDF", "TrialBalanceDateRangePDF", "~/Accounts/TrialBalanceDateRangePDF.aspx")
        routes.MapPageRoute("TrialBalanceUpTo", "TrialBalanceUpTo", "~/Accounts/TrialBalanceUpTo.aspx")
        routes.MapPageRoute("BankBookPDF", "BankBookPDF", "~/Accounts/BankBookPDF.aspx")
        routes.MapPageRoute("ReceiptPayment", "ReceiptPayment", "~/Accounts/ReceiptPayment.aspx")
        routes.MapPageRoute("LedgerChildLess", "LedgerChildLess", "~/Accounts/LedgerChildLess.aspx")
        routes.MapPageRoute("LedgerParent", "LedgerParent", "~/Accounts/LedgerParent.aspx")
        routes.MapPageRoute("LedgerLessPDF", "LedgerLessPDF", "~/Accounts/LedgerLessPDF.aspx")
        routes.MapPageRoute("LedgerParentPDF", "LedgerParentPDF", "~/Accounts/LedgerParentPDF.aspx")
        routes.MapPageRoute("DailyCashBankStatement", "DailyCashBankStatement", "~/Accounts/DailyCashBankStatement.aspx")
        routes.MapPageRoute("DailyCashBankStatementView", "DailyCashBankStatementView", "~/Accounts/DailyCashBankStatementView.aspx")
        routes.MapPageRoute("DailyReceiptPayment", "DailyReceiptPayment", "~/Accounts/DailyReceiptPayment.aspx")
        routes.MapPageRoute("ReceiptPaymentPDF", "ReceiptPaymentPDF", "~/Accounts/ReceiptPaymentPDF.aspx")
        routes.MapPageRoute("ISShow", "ISShow", "~/Accounts/ISShow.aspx")
        'routes.MapPageRoute("ISYearly", "ISYearly", "~/Accounts/ISYearly.aspx")
        routes.MapPageRoute("ISYearly", "ISYearly", "~/Accounts/income-statement-view.aspx")
        routes.MapPageRoute("incomestatementpreview", "incomestatementpreview", "~/Accounts/income-statement-preview.aspx")
        routes.MapPageRoute("ISPdf", "ISPdf", "~/Accounts/ISPdf.aspx")
        routes.MapPageRoute("BSShow", "BSShow", "~/Accounts/BSShow.aspx")
        routes.MapPageRoute("BS", "BS", "~/Accounts/BS.aspx")
        routes.MapPageRoute("BSPdf", "BSPdf", "~/Accounts/BSPdf.aspx")
        routes.MapPageRoute("isservice", "is-service", "~/Accounts/is-service.aspx")
        routes.MapPageRoute("bsservice", "bs-service", "~/Accounts/bs-service.aspx")
        routes.MapPageRoute("ISPdfService", "ISPdfService", "~/Accounts/ISPdfService.aspx")
        routes.MapPageRoute("BSPdfservice", "BSPdfservice", "~/Accounts/BSPdfservice.aspx")
        routes.MapPageRoute("ChequeDetailsList", "ChequeDetailsList", "~/Accounts/ChequeDetailsList.aspx")
        routes.MapPageRoute("balancesheet", "balancesheet", "~/Accounts/balance-sheet.aspx")
        routes.MapPageRoute("balancesheetview", "balancesheetview", "~/Accounts/balance-sheet-view.aspx")
        routes.MapPageRoute("balancesheetpreview", "balancesheetpreview", "~/Accounts/balance-sheet-preview.aspx")

        '//C&F
        '-----------------------------------------------
        '-----------------------------------------------
        routes.MapPageRoute("JobAdd", "JobAdd", "~/CF/JobAdd.aspx")
        routes.MapPageRoute("JobList", "JobList", "~/CF/JobList.aspx")
        routes.MapPageRoute("BillPrint", "BillPrint", "~/CF/BillPrint.aspx")
        routes.MapPageRoute("BillPrintNew", "BillPrintNew", "~/CF/BillPrintNew.aspx")
        routes.MapPageRoute("ExpenseAdd", "ExpenseAdd", "~/CF/ExpenseAdd.aspx")
        routes.MapPageRoute("ExpenseList", "ExpenseList", "~/CF/ExpenseList.aspx")
        routes.MapPageRoute("POPUPApprovedAmount", "POPUPApprovedAmount", "~/CF/POPUPApprovedAmount.aspx")
        routes.MapPageRoute("FCLExpensePreview", "FCLExpensePreview", "~/CF/FCLExpensePreview.aspx")
        routes.MapPageRoute("ExpensePrint", "ExpensePrint", "~/CF/ExpensePrint.aspx")
        routes.MapPageRoute("ApprovedPrint", "ApprovedPrint", "~/CF/ApprovedPrint.aspx")
        routes.MapPageRoute("ExpenseReport", "ExpenseReport", "~/CF/ExpenseReport.aspx")
        routes.MapPageRoute("JobwiseExpensePreview", "JobwiseExpensePreview", "~/CF/JobwiseExpensePreview.aspx")
        routes.MapPageRoute("ShortShipmentPDF", "ShortShipmentPDF", "~/CF/ShortShipmentPDF.aspx")
        routes.MapPageRoute("JobDetailsPDF", "JobDetailsPDF", "~/CF/JobDetailsPDF.aspx")


        routes.MapPageRoute("AdvanceAdd", "AdvanceAdd", "~/CF/AdvanceAdd.aspx")
        routes.MapPageRoute("AdvanceList", "AdvanceList", "~/CF/AdvanceList.aspx")
        routes.MapPageRoute("AdvancePreview", "AdvancePreview", "~/CF/AdvancePreview.aspx")
        routes.MapPageRoute("BillReceiveEntry ", "BillReceiveEntry", "~/CF/BillReceiveEntry.aspx")
        ' routes.MapPageRoute("BillReceiveEntry ", "BillReceiveEntry", "~/CF/BillReceiveEntry.aspx")
        routes.MapPageRoute("BillEntry", "BillEntry", "~/CF/BillEntry.aspx")
        routes.MapPageRoute("BillList", "BillList", "~/CF/BillList.aspx")
        routes.MapPageRoute("BillReceiveList", "BillReceiveList", "~/CF/BillReceiveList.aspx")
        routes.MapPageRoute("BillListPreview", "BillListPreview", "~/CF/BillListPreview.aspx")


        routes.MapPageRoute("ExportBillEntry", "ExportBillEntry", "~/CF/ExportBillEntry.aspx")
        routes.MapPageRoute("ExportBillList", "ExportBillList", "~/CF/ExportBillList.aspx")
        routes.MapPageRoute("BillSummary", "BillSummary", "~/CF/BillSummary.aspx")
        routes.MapPageRoute("BillSummaryPDF", "BillSummaryPDF", "~/CF/BillSummaryPDF.aspx")
        routes.MapPageRoute("Employeewisejobexpense", "Employeewisejobexpense", "~/CF/Employeewisejobexpense.aspx")
        routes.MapPageRoute("Employeewiseexpense", "Employeewiseexpense", "~/CF/Employeewiseexpense.aspx")
        routes.MapPageRoute("BillParticularsAdd", "BillParticularsAdd", "~/CF/BillParticularsAdd.aspx")
        routes.MapPageRoute("BillParticlarsList", "BillParticlarsList", "~/CF/BillParticlarsList.aspx")
        routes.MapPageRoute("AgreementEntry", "AgreementEntry", "~/CF/AgreementEntry.aspx")
        routes.MapPageRoute("AgreementList", "AgreementList", "~/CF/AgreementList.aspx")
        routes.MapPageRoute("ShippingAgent", "ShippingAgent", "~/CF/ShippingAgent.aspx")
        routes.MapPageRoute("ShippingAgentAdd", "ShippingAgentAdd", "~/CF/ShippingAgentAdd.aspx")
        routes.MapPageRoute("pay-order-payment", "pay-order-refund", "~/CF/pay-order-payment.aspx")
        routes.MapPageRoute("pay-order-refund-list", "pay-order-refund-list", "~/CF/pay-order-refund-list.aspx")

        '================================C&F=============================
        routes.MapPageRoute("DriverEntry", "DriverEntry", "~/CF/DriverEntry.aspx")
        routes.MapPageRoute("DriverList", "DriverList", "~/CF/DriverList.aspx")
        routes.MapPageRoute("VehicleEntry", "VehicleEntry", "~/CF/VehicleEntry.aspx")
        routes.MapPageRoute("ConsignmentEntry", "ConsignmentEntry", "~/CF/ConsignmentEntry.aspx")
        routes.MapPageRoute("ConsignmentList", "ConsignmentList", "~/CF/ConsignmentList.aspx")
        routes.MapPageRoute("ConsignmentWiseStatement", "ConsignmentWiseStatement", "~/CF/ConsignmentWiseStatement.aspx")
        routes.MapPageRoute("ConsWiseStatementDetails", "ConsWiseStatementDetails", "~/CF/ConsWiseStatementDetails.aspx")
        routes.MapPageRoute("ConsWiseStatementDetailsPreview", "ConsWiseStatementDetailsPreview", "~/CF/ConsWiseStatementDetailsPreview.aspx")
        routes.MapPageRoute("VehicleList", "VehicleList", "~/CF/VehicleList.aspx")
        routes.MapPageRoute("POPUPDriver", "POPUPDriver.aspx", "~/CF/POPUPDriver.aspx")
        routes.MapPageRoute("VehicleExpEntry", "VehicleExpEntry", "~/CF/VehicleExpEntry.aspx")
        routes.MapPageRoute("VehicleExpList", "VehicleExpList", "~/CF/VehicleExpList.aspx")

        routes.MapPageRoute("VehiclePaperType", "VehiclePaperType", "~/VehiclePaperType.aspx")
        routes.MapPageRoute("VehiclePaperTypeAdd", "VehiclePaperTypeAdd", "~/VehiclePaperTypeAdd.aspx")

        routes.MapPageRoute("VehiclePaperStatus", "VehiclePaperStatus", "~/VehiclePaperStatus.aspx")
        routes.MapPageRoute("VehiclePaperStatusAdd", "VehiclePaperStatusAdd", "~/VehiclePaperStatusAdd.aspx")

        routes.MapPageRoute("VehicleExpensePreview", "VehicleExpensePreview", "~/CF/VehicleExpensePreview.aspx")
        routes.MapPageRoute("TripEntry", "TripEntry", "~/CF/TripEntry.aspx")
        routes.MapPageRoute("TripEntryTransport", "TransTripEntry", "~/Transport/TripEntry.aspx")
        routes.MapPageRoute("DetentionEntry", "DetentionEntry", "~/CF/DetentionEntry.aspx")
        routes.MapPageRoute("DetentionList", "DetentionList", "~/CF/DetentionList.aspx")
        routes.MapPageRoute("TripList", "TripList", "~/CF/TripList.aspx")
        routes.MapPageRoute("TripPreview", "TripPreview", "~/CF/TripPreview.aspx")
        routes.MapPageRoute("TripPayment", "TripPayment", "~/CF/TripPayment.aspx")
        routes.MapPageRoute("TripPaymentList", "TripPaymentList", "~/CF/TripPaymentList.aspx")
        routes.MapPageRoute("TripPaymentPreview", "TripPaymentPreview", "~/CF/TripPaymentPreview.aspx")
        routes.MapPageRoute("MonthlyVSSummary", "MonthlyVSSummary", "~/CF/MonthlyVSSummary.aspx")
        routes.MapPageRoute("MonthlyPreview", "MonthlyPreview", "~/CF/MonthlyPreview.aspx")
        routes.MapPageRoute("VehicleWiseProfitLoss", "VehicleWiseProfitLoss", "~/CF/VehicleWiseProfitLoss.aspx")
        routes.MapPageRoute("VehicleProfitLossPreview", "VehicleProfitLossPreview", "~/CF/VehicleProfitLossPreview.aspx")

        routes.MapPageRoute("OtherIncomeAdd", "OtherIncomeAdd", "~/CF/OtherIncomeAdd.aspx")
        routes.MapPageRoute("OtherIncomeList", "OtherIncomeList", "~/CF/OtherIncomeList.aspx")
        routes.MapPageRoute("OtherIncomePrint", "OtherIncomePrint", "~/CF/OtherIncomePrint.aspx")
        routes.MapPageRoute("OtherIncomePreview", "OtherIncomePreview", "~/CF/OtherIncomePreview.aspx")

         routes.MapPageRoute("VoucherPaymentPreviewNew", "VoucherPaymentPreviewNew", "~/CF/VoucherPaymentPreviewNew.aspx")


        '=============================Transport==========================

        routes.MapPageRoute("TransportDriverEntry", "TransportDriverEntry", "~/Transport/DriverEntry.aspx")
        routes.MapPageRoute("TransportDriverList", "TransportDriverList", "~/Transport/DriverList.aspx")

        routes.MapPageRoute("TransportConsignmentEntry", "TransportConsignmentEntry", "~/Transport/ConsignmentEntry.aspx")
        routes.MapPageRoute("TransportConsignmentList", "TransportConsignmentList", "~/Transport/ConsignmentList.aspx")
        'routes.MapPageRoute("TransportConsignmentWiseStatement", "TransportConsignmentWiseStatement", "~/Transport/ConsignmentWiseStatement.aspx")
        'routes.MapPageRoute("TransportConsWiseStatementDetails", "TransportConsWiseStatementDetails", "~/Transport/ConsWiseStatementDetails.aspx")
        'routes.MapPageRoute("TransportConsWiseStatementDetailsPreview", "TransportConsWiseStatementDetailsPreview", "~/Transport/ConsWiseStatementDetailsPreview.aspx")
        routes.MapPageRoute("TransportVehicleEntry", "TransportVehicleEntry", "~/Transport/VehicleEntry.aspx")
        routes.MapPageRoute("TransportVehicleList", "TransportVehicleList", "~/Transport/VehicleList.aspx")
        routes.MapPageRoute("TransportVehicleReport", "TransportVehicleReport", "~/Transport/VehicleReport.aspx")
        'routes.MapPageRoute("TransportPOPUPDriver", "TransportPOPUPDriver.aspx", "~/Transport/POPUPDriver.aspx")
        routes.MapPageRoute("TransportVehicleExpEntry", "TransportVehicleExpEntry", "~/Transport/VehicleExpEntry.aspx")

        routes.MapPageRoute("TransportVehicleExpEntryNew", "TransportVehicleExpEntryNew", "~/Transport/VehicleExpEntry_nw.aspx")

        routes.MapPageRoute("TransportVehicleExpListNew", "TransportVehicleExpListNew", "~/Transport/VehicleExpList_nw.aspx")
        routes.MapPageRoute("TransportVehicleExpNewPreview", "TransportVehicleExpNewPreview", "~/Transport/TransportVehicleExpNewPreview.aspx")


        routes.MapPageRoute("TransportVehicleExpList", "TransportVehicleExpList", "~/Transport/VehicleExpList.aspx")
        routes.MapPageRoute("TransportVehiclePaperType", "TransportVehiclePaperType", "~/Transport/VehiclePaperType.aspx")
        routes.MapPageRoute("TransportVehiclePaperTypeAdd", "TransportVehiclePaperTypeAdd", "~/Transport/VehiclePaperTypeAdd.aspx")
        routes.MapPageRoute("TransportVehiclePaperStatus", "TransportVehiclePaperStatus", "~/Transport/VehiclePaperStatus.aspx")
        routes.MapPageRoute("TransportVehiclePaperStatusAdd", "TransportVehiclePaperStatusAdd", "~/Transport/VehiclePaperStatusAdd.aspx")
        'routes.MapPageRoute("TransportVehicleExpensePreview", "TransportVehicleExpensePreview", "~/Transport/VehicleExpensePreview.aspx")

        routes.MapPageRoute("TransportTripEntry", "TransportTripEntry", "~/Transport/TripEntry.aspx")
        routes.MapPageRoute("TransportTripList", "TransportTripList", "~/Transport/TripList.aspx")

        routes.MapPageRoute("TransportDetentionEntry", "TransportDetentionEntry", "~/Transport/DetentionEntry.aspx")
        routes.MapPageRoute("TransportDetentionList", "TransportDetentionList", "~/Transport/DetentionList.aspx")

        'routes.MapPageRoute("TransportTripPreview", "TransportTripPreview", "~/Transport/TripPreview.aspx")
        'routes.MapPageRoute("TransportTripPayment", "TransportTripPayment", "~/Transport/TripPayment.aspx")
        'routes.MapPageRoute("TransportTripPaymentList", "TransportTripPaymentList", "~/Transport/TripPaymentList.aspx")
        'routes.MapPageRoute("TransportMonthlyVSSummary", "TransportMonthlyVSSummary", "~/Transport/MonthlyVSSummary.aspx")
        'routes.MapPageRoute("TransportMonthlyPreview", "TransportMonthlyPreview", "~/Transport/MonthlyPreview.aspx")
        routes.MapPageRoute("TransportVehicleWiseProfitLoss", "TransportVehicleWiseProfitLoss", "~/Transport/VehicleWiseProfitLoss.aspx")
        routes.MapPageRoute("TransportVehicleProfitLossPreview", "TransportVehicleProfitLossPreview", "~/Transport/VehicleProfitLossPreview.aspx")

        routes.MapPageRoute("SupplierTripPayment", "SupplierTripPayment", "~/Transport/SupplierRentPayment.aspx")
        routes.MapPageRoute("SupplierTripPaymentList", "SupplierTripPaymentList", "~/Transport/SupplierRentPaymentList.aspx")

        routes.MapPageRoute("OwnContactTripWiseExpReport", "OwnContactTripWiseExpReport", "~/Transport/OwnContactTripWiseExpReport.aspx")
        routes.MapPageRoute("OwnTripWiseExpReport", "OwnTripWiseExpReport", "~/Transport/TripWsieExpenseReportOwn.aspx")
        routes.MapPageRoute("ContactTripWiseExpReport", "ContactTripWiseExpReport", "~/Transport/TripWiseExpenseReportContact.aspx")

        routes.MapPageRoute("VehicleWiseProfitLossReport", "VehicleWiseProfitLossReport", "~/Transport/VehicleWiseProfitLossReport.aspx")
        routes.MapPageRoute("VehicleWiseProfitLossContractReport", "VehicleWiseProfitLossContractReport", "~/Transport/VehicleWiseProfitLossContractReport.aspx")
    End Sub
</script>
