Imports System.Data.SqlClient

Public Class CompanyDetails
    Inherits System.Web.UI.Page
    Public Shared connection As [String] = ConfigurationManager.ConnectionStrings("AccConn").ToString()

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If IsPostBack = False Then
            If Request.QueryString("com_id") <> "" Then
                lblTitle.Text = "Update Customer"
                btnsave.Text = "Update"
                Dim con As New SqlConnection(connection)
                Dim cmd As New SqlCommand("", con)
                con.Open()
                cmd.CommandType = CommandType.Text
                cmd.CommandText = "SELECT 
                    c.com_name,
                    c.com_address,
                    c.com_contact,
                    c.com_mail,
                    c.create_date,
                    c.com_type,
                    c.com_headqt,
                    c.item_id,
                    ci.item_name
                FROM 
                    dbo.Company AS c
                JOIN 
                    dbo.CompanyItem AS ci
                ON 
                    c.item_id = ci.item_id"
                cmd.Parameters.AddWithValue("com_id", Request.QueryString("com_id"))
                Dim reader As SqlDataReader = cmd.ExecuteReader()
                cmd.Dispose()
                If reader.HasRows = True Then
                    reader.Read()

                End If
        End If
    End Sub

End Class