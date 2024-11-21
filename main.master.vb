Imports System.Data
Imports System.Data.SqlClient
Partial Class Site
    Inherits System.Web.UI.MasterPage
    Protected connection As [String] = ConfigurationManager.ConnectionStrings("AccConn").ToString()
    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        If Request.Cookies("CompID") Is Nothing Then
            Response.Redirect("/Default")
        End If

        If Request.Cookies("SLocationID") Is Nothing Then
            Response.Redirect("/Default")
        End If



        If Request.Cookies("BID") Is Nothing Then
            Response.Redirect("/Default")
        Else

            ddlBranch.SelectedValue = New Encription().DecryptTripleDES(Request.Cookies("Bid").Value, "*n3x@")
            ' ddlBranch.SelectedValue = Request.Cookies("Bid").Value
        End If
        Dim URL = Request.RawUrl
        'Response.Write(URL)
        If URL.Contains("?type=report") = False Then
            If URL.Contains("?") = True Then
                'Response.Write("ok")
                ddlBranch.Enabled = False
            End If
        End If
        If URL.Contains("SalePrice") = True Then

            'Response.Write("ok")
            ddlBranch.Enabled = True

        End If
        SetMenu()
        If Session("domainname") IsNot Nothing Then
            Session("domainname") = ConfigurationManager.AppSettings("RedirectUrl").ToString
        End If
        'Response.Write(Session("domainname"))
    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Response.Write(New Encription().DecryptTripleDES(Request.Cookies("Package").Value, "*n3x@"))



        If IsPostBack = False Then
            'If CDate(Date.Now.ToString) > CDate(New Encription().DecryptTripleDES(Request.Cookies("ContractEndDate").Value, "*n3x@")) Then

            '    Response.Redirect("doyourpayment.aspx")

            'End If
            CheckFiscalYear()
            LoadBranch()

            If New Encription().DecryptTripleDES(Request.Cookies("CompID").Value, "*n3x@") Is Nothing Then
                Response.Redirect("/Default")
            End If


            'If New Encription().DecryptTripleDES(Request.Cookies("Package").Value, "*n3x@") = "Accounting" Then
            '    sales.Visible = False
            '    purchase.Visible = False
            '    pnlinventory.Visible = False

            '    accounts.Visible = False
            '    report.Visible = False
            '    setting.Visible = False
            'Else
            '    acctranns.Visible = False
            '    accreports.Visible = False
            '    accsystem.Visible = False
            '    accconfig.Visible = False

            'End If

            'If New Encription().DecryptTripleDES(Request.Cookies("BusinessType").Value, "*n3x@") = "Service" Then
            '    stockledger.Visible = False
            '    stocksummary.Visible = False
            '    pnlinventory.Visible = False

            'End If




            Dim con As New SqlConnection(connection)
            Dim cmd As New SqlCommand("", con)
            con.Open()

            cmd.CommandText = "select MediumLogo from [Company] where CompID=@CompID"
            cmd.Parameters.AddWithValue("@CompID", New Encription().DecryptTripleDES(Request.Cookies("CompID").Value, "*n3x@"))

            Dim readerlogo As SqlDataReader = cmd.ExecuteReader()
            If readerlogo.Read() Then
                If IsDBNull(readerlogo("MediumLogo")) = False Then
                    eventImage.Visible = True
                    eventImage.ImageUrl = readerlogo("MediumLogo").ToString()

                End If

            End If
            readerlogo.Close()


            If (Not New Encription().DecryptTripleDES(Request.Cookies("UserName").Value, "*n3x@") Is Nothing) Then
                lblUser.Text = New Encription().DecryptTripleDES(Request.Cookies("UserName").Value, "*n3x@")
                lblCompanyName.Text = New Encription().DecryptTripleDES(Request.Cookies("Name").Value, "*n3x@")
                Page.Title = New Encription().DecryptTripleDES(Request.Cookies("Name").Value, "*n3x@")
                If Request.Cookies("StartYear") IsNot Nothing Then
                    If New Encription().DecryptTripleDES(Request.Cookies("StartYear").Value, "*n3x@") = New Encription().DecryptTripleDES(Request.Cookies("EndYear").Value, "*n3x@") Then
                        lblYear.Text = New Encription().DecryptTripleDES(Request.Cookies("StartYear").Value, "*n3x@")

                    Else
                        lblYear.Text = New Encription().DecryptTripleDES(Request.Cookies("StartYear").Value, "*n3x@") & "-" & Mid(New Encription().DecryptTripleDES(Request.Cookies("EndYear").Value, "*n3x@"), 3, 2)
                    End If
                End If

            End If




            cmd.CommandText = "select name from company"
            Page.Title = cmd.ExecuteScalar
            con.Close()
        End If


        Dim con1 As New SqlConnection(connection)
        Dim cmd1 As New SqlCommand("", con1)
        con1.Open()


        cmd1.CommandText = "select BranchName from [BranchInfo] where BranchID=@BranchID"
        cmd1.Parameters.AddWithValue("@BranchID", New Encription().DecryptTripleDES(Request.Cookies("Bid").Value, "*n3x@"))

        Dim rdr As SqlDataReader = cmd1.ExecuteReader()
        If rdr.Read() Then

            lblCompanyName.Text = rdr("BranchName").ToString()

        End If
        rdr.Close()

        con1.Close()

        Dim URL = Request.ServerVariables("PATH_INFO").Split("/")


        Dim str = GlobalClass.getallmenuinfo(URL(1), New Encription().DecryptTripleDES(Request.Cookies("URole").Value, "*n3x@")).Split(",")

        '  Response.Write(URL(1))

        If Val(str(0)) = 0 Then
            ' Response.Redirect("/Accessdenied")
        End If

        hdnedit.Value = Val(str(2))
        hdndelete.Value = Val(str(3))

        ' Response.Write(hdndelete.Value)

        hdnchksave.Value = Val(str(1))


        ' Response.Write(hdnedit.Value)

    End Sub
    Protected Function GetStartDateEndDateFiscalYear(ByVal compId As String) As ArrayList '//get current  startdate from FiscalYear table --start

        Dim dates As New ArrayList

        Dim con As New SqlConnection(connection)
        Dim cmd As New SqlCommand("", con)
        con.Open()

        cmd.CommandType = CommandType.Text
        cmd.CommandText = "SELECT StartDate, EndDate, YearCode FROM FiscalYear WHERE CompID=@CompID2 and YearCode=(Select Max(YearCode) from FiscalYear where CompID=@CompID2)"
        cmd.Parameters.Add("CompID2", Data.SqlDbType.Int).Value = New Encription().DecryptTripleDES(Request.Cookies("CompID").Value, "*n3x@")
        Dim reader1 As SqlDataReader = cmd.ExecuteReader()
        cmd.Dispose()
        If reader1.Read() = True Then
            dates.Add(reader1("StartDate").ToString())
            dates.Add(reader1("EndDate").ToString())
            dates.Add(reader1("YearCode").ToString())
        Else
            If reader1.Read() = True Then
                reader1.Close()
            End If
        End If
        reader1.Close()
        con.Close()

        Return dates
    End Function

    Protected Sub btnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogout.Click
        Response.Cookies.Clear()

        Response.Cookies("CompID").Value = ""
        Response.Cookies("UserName").Value = ""
        Response.Cookies("Email").Value = ""
        Response.Cookies("UserID").Value = ""
        Response.Cookies("VoucherVerify").Value = ""
        Response.Cookies("Name").Value = ""
        Response.Cookies("NoOfEntries").Value = ""
        Response.Cookies("ComPackage").Value = ""
        Response.Cookies("URole").Value = ""
        Response.Cookies("ContractEndDate").Value = ""
        Response.Cookies("AccountType").Value = ""

        Response.Cookies("CompID").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("UserName").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("Email").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("UserID").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("VoucherVerify").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("Name").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("NoOfEntries").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("ComPackage").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("URole").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("ContractEndDate").Expires = DateTime.Now.AddDays(-1)
        Response.Cookies("AccountType").Expires = DateTime.Now.AddDays(-1)

        If Not Request.Cookies("StartYear") Is Nothing Then
            Response.Cookies("StartYear").Value = ""
            Response.Cookies("StartYear").Expires = DateTime.Now.AddDays(-1)

            Response.Cookies("StartDate").Value = ""
            Response.Cookies("StartDate").Expires = DateTime.Now.AddDays(-1)

        End If
        If Not Request.Cookies("EndYear") Is Nothing Then
            Response.Cookies("EndYear").Value = ""
            Response.Cookies("EndYear").Expires = DateTime.Now.AddDays(-1)

            Response.Cookies("EndDate").Value = ""
            Response.Cookies("EndDate").Expires = DateTime.Now.AddDays(-1)
        End If
        If Not Request.Cookies("CurrYearCode") Is Nothing Then
            Response.Cookies("CurrYearCode").Value = ""
            Response.Cookies("CurrYearCode").Expires = DateTime.Now.AddDays(-1)
        End If

        Dim con As New SqlConnection(connection)
        Dim cmd As New SqlCommand("", con)

        con.Open()
        cmd.CommandType = CommandType.Text
        cmd.CommandText = "Update UserLoginInfo set LogoutDateTime=@LogoutDateTime where LoginInfoID=(select MAX(LoginInfoID) from UserLoginInfo where UserID=@UserID)"
        cmd.Parameters.Add("LogoutDateTime", Data.SqlDbType.DateTime).Value = Format(CDate(Date.Now.ToString()), "MMM-dd-yyyy")
        cmd.Parameters.Add("UserID", Data.SqlDbType.Int).Value = New Encription().DecryptTripleDES(Request.Cookies("UserID").Value, "*n3x@")
        cmd.ExecuteNonQuery()

        con.Close()


        Response.Redirect("/Default")
    End Sub
    Sub LoadBranch()
        Dim con As New SqlConnection(connection)
        Dim cmd As New SqlCommand("", con)

        con.Open()
        cmd.CommandType = CommandType.Text
        cmd.CommandText = "select BranchID,BranchName from BranchInfo where BranchID in (1,21,22)"

        Dim reader As SqlDataReader = cmd.ExecuteReader()

        ddlBranch.Items.Clear()
        While reader.Read()
            ddlBranch.Items.Add(New ListItem(reader("BranchName").ToString(), reader("BranchID").ToString()))
        End While

        If New Encription().DecryptTripleDES(Request.Cookies("SLocationID").Value, "*n3x@") > 0 Then
            ddlBranch.SelectedValue = New Encription().DecryptTripleDES(Request.Cookies("SLocationID").Value, "*n3x@")
            ddlBranch.Enabled = False
        Else
            ddlBranch.SelectedValue = New Encription().DecryptTripleDES(Request.Cookies("Bid").Value, "*n3x@")

        End If

        reader.Close()
        con.Close()

    End Sub

    Protected Sub ddlBranch_SelectedIndexChanged(sender As Object, e As System.EventArgs) Handles ddlBranch.SelectedIndexChanged


        Response.Cookies.Add(New HttpCookie("BID", New Encription().EncryptTripleDES(ddlBranch.SelectedValue, "*n3x@")))

        Response.Cookies("BID").Expires = DateTime.Now.AddDays(7)

        SetMenu()

        Dim con As New SqlConnection(connection)
        Dim cmd As New SqlCommand("", con)

        con.Open()
        cmd.CommandType = CommandType.Text
        cmd.CommandText = "select BranchID,BranchName,ShortForm from BranchInfo where BranchID=@BranchID"

        cmd.Parameters.Add("BranchID", SqlDbType.Int).Value = ddlBranch.SelectedValue

        Dim reader As SqlDataReader = cmd.ExecuteReader()

        While reader.Read()
            Response.Cookies.Add(New HttpCookie("DOPrefix", reader("ShortForm").ToString()))
            Response.Cookies("DOPrefix").Expires = DateTime.Now.AddDays(7)
        End While

        reader.Close()
        con.Close()
        Response.Redirect("/Dashboard")


        ' Response.Redirect(HttpContext.Current.Request.Url.AbsoluteUri)
    End Sub
    Sub ChangeBranch()

    End Sub

    Sub CheckFiscalYear()


        If CDate(New Encription().DecryptTripleDES(Request.Cookies("EndDate").Value, "*n3x@")) <= Today.Date Then

            Dim con As New SqlConnection(connection)
            Dim cmd As New SqlCommand("", con)
            con.Open()


            cmd.Parameters.Clear()
            cmd.CommandText = "select EndDate from FiscalYear WHERE CompID=@CompID and YearCode=(Select Max(YearCode) from FiscalYear where CompID=@CompID2)"
            cmd.Parameters.Add("CompID", Data.SqlDbType.Int).Value = New Encription().DecryptTripleDES(Request.Cookies("CompID").Value, "*n3x@")
            cmd.Parameters.Add("CompID2", Data.SqlDbType.Int).Value = New Encription().DecryptTripleDES(Request.Cookies("CompID").Value, "*n3x@")
            Dim endDate As Date = CDate(cmd.ExecuteScalar)

            If endDate <= Today.Date Then
                cmd.CommandText = "update FiscalYear set EndDate = dateadd(year,1,EndDate) WHERE CompID=@CompID and YearCode=(Select Max(YearCode) from FiscalYear where CompID=@CompID2)"
                cmd.ExecuteNonQuery()
                Response.Cookies("EndDate").Value = New Encription().EncryptTripleDES(Format(CDate(DateAdd(DateInterval.Year, 1, endDate)), "dd-MM-yyyy"), "*n3x@")
            Else

                Response.Cookies("EndDate").Value = New Encription().EncryptTripleDES(Format(CDate(endDate), "dd-MM-yyyy"), "*n3x@")
            End If

            con.Close()
        End If

    End Sub


    Sub SetMenu()
        Dim uid As String = New Encription().DecryptTripleDES(Request.Cookies("UserID").Value, "*n3x@")
        Dim Bid As String = New Encription().DecryptTripleDES(Request.Cookies("Bid").Value, "*n3x@")

        If Session("Menu_" & Bid & "_" & uid) IsNot Nothing Then
            ltrmenu.Text = Session("Menu_" & Bid & "_" & uid)

        Else

            '  ltrmenu.Text = GlobalClass.setmenu(Val(New Encription().DecryptTripleDES(Request.Cookies("URole").Value, "*n3x@")))
            Session("Menu_" & Bid & "_" & uid) = GlobalClass.setmenu(Val(New Encription().DecryptTripleDES(Request.Cookies("URole").Value, "*n3x@")), Val(Bid))
            ltrmenu.Text = Session("Menu_" & Bid & "_" & uid)
        End If
    End Sub
End Class

