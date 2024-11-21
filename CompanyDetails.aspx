<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="CompanyDetails.aspx.vb" Inherits="RetailStore.CompanyDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.css" rel="stylesheet" />
     <link href="~/ui/js/plugins/diynamictable/jquery.appendGrid-1.4.1.css" rel="stylesheet"type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container main">
        <div class="col-12 divEntry">
            <h2 style="color: darkslateblue; text-align: center; background-color: gainsboro;">
                <asp:Literal ID="lblTitle" runat="server" Text="New Company Entry"></asp:Literal>
            </h2>
        </div>

        <!-- Form Row -->
        <div class="row">
            <!-- Left Column -->
            <div class="col-6">
                <div class="form-group">
                    <label for="com_name" style="font-weight: 500;">Company Name:</label>
                    <asp:TextBox ID="com_name" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="form" Display="Dynamic" ID="RequiredFieldValidator1"
                        runat="server" ControlToValidate="com_name" ForeColor="Red" SetFocusOnError="true"
                        Text="* Required" ErrorMessage="Enter the company name"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label for="com_address" style="font-weight: 500;">Company Address:</label>
                    <asp:TextBox ID="com_address" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="form" Display="Dynamic" ID="RequiredFieldValidator2"
                        runat="server" ControlToValidate="com_address" ForeColor="Red" SetFocusOnError="true"
                        Text="* Required" ErrorMessage="Enter the company address"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label for="com_contact" style="font-weight: 500;">Contact No.:</label>
                    <asp:TextBox ID="com_contact" runat="server"  onKeyPress="return isDecimalNumber(event)" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="form" Display="Dynamic" ID="RequiredFieldValidator3"
                        runat="server" ControlToValidate="com_contact" ForeColor="Red" SetFocusOnError="true"
                        Text="* Required" ErrorMessage="Enter the contact number"></asp:RequiredFieldValidator>
                </div>

                <div class="form-group">
                    <label for="com_mail" style="font-weight: 500;">Email:</label>
                    <asp:TextBox ID="com_mail" runat="server" CssClass="form-control"></asp:TextBox>
                    <asp:RequiredFieldValidator ValidationGroup="form" Display="Dynamic" ID="RequiredFieldValidator4"
                        runat="server" ControlToValidate="com_mail" ForeColor="Red" SetFocusOnError="true"
                        Text="* Required" ErrorMessage="Enter a valid email address"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegexValidatorEmail" runat="server"
                        ControlToValidate="com_mail" ValidationExpression="^\w+@[a-zA-Z_]+?\.[a-zA-Z]{2,3}$"
                        ForeColor="Red" ErrorMessage="Invalid email format"></asp:RegularExpressionValidator>
                </div>
            </div>

            <!-- Right Column -->
            <div class="col-6">
                <div class="form-group">
                    <label for="create_date" style="font-weight: 500; display: block;">Create Date:</label>
                    <asp:TextBox ID="create_date" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                </div>

                <div class="form-group mt-2">
                    <label for="com_type" style="font-weight: 500; display: block;">Type:</label>
                    <asp:DropDownList ID="com_type" runat="server" CssClass="form-control select2" ClientIDMode="Static">
                        <asp:ListItem Selected Value="">Select Type</asp:ListItem>
                        <asp:ListItem Value="Wholesale">Wholesale</asp:ListItem>
                        <asp:ListItem Value="Retail">Retail</asp:ListItem>
                        <asp:ListItem Value="Corporate">Corporate</asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="form-group mt-2">
                    <label for="com_headqt" style="font-weight: 500; display: block;">Headquarter:</label>
                    <asp:DropDownList ID="com_headqt" runat="server" CssClass="form-control select2" ClientIDMode="Static">
                        <asp:ListItem Selected Value="">Select Branch</asp:ListItem>
                        <asp:ListItem Value="Dhaka">Dhaka</asp:ListItem>
                        <asp:ListItem Value="Chittagong">Chittagong</asp:ListItem>
                        <asp:ListItem Value="Sylhet">Sylhet</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="form-group">
                <table id="tblInvoice" class="table table-hover table-responsive table-striped"></table>
            </div>
        </div>
    </div>
    <div class="col-xs-12 col-sm-1 col-lg-1 divLeft form-group">
    <asp:Button ID="btnsave" ClientIDMode="Static" runat="server" class="btn btn-primary form-control Save"
        Text="Save" ValidationGroup="form" />
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="jsContainer" runat="server">
    <!-- Include required JS libraries -->
            <script type="text/javascript" src="<%=Session("domainname") %>ui/js/jquery-1.11.0.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script type="text/javascript" src="<%= session("domainname") %>ui/js/plugins/diynamictable/jquery.appendGrid-1.4.1.js"></script>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    
    <script type="text/javascript">
        $(document).ready(function () {
            // Initialize Select2
            $('.select2').select2({
                placeholder: "Select an option",
                allowClear: true
            });

            // Initialize Datepicker
            $('#create_date').datepicker({
                dateFormat: "dd-M-yy"
            });

           
        });
        $(function () {
            // Initialize AppendGrid
            $('#tblInvoice').appendGrid({
                caption: 'Item Details',
                initRows: 1,
                columns: [
                    {
                        name: 'item_id',
                        display: 'Item ID',
                        hidden: true, 
                        type: 'text',
                        ctrlCss: { width: '40%' }
                    },
                    {
                        name: 'item_name',
                        display: 'Item Name',
                        type: 'text',
                        ctrlCss: { width: '100%' }
                    },
                    {
                        name: 'item_qty',
                        display: 'Quantity',
                        type: 'text',
                        ctrlCss: { width: '70px' }
                    },
                    {
                        name: 'item_branch',
                        display: 'Branch',
                        type: 'select',
                        ctrlCss: { width: '100%' },
                        ctrlOptions: { 'Dhaka': 'Dhaka', 'Chittagong': 'Chittagong', 'Sylhet': 'Sylhet' }
                    }
                ],
                hideButtons: {
                    append: false,
                    insert: true,
                    removeLast: false,
                    remove: false,
                    moveUp: false,
                    moveDown: false,
                    rowDrag: false
                }
            });
        });
        function isDecimalNumber(event) {
            // Get the event object and the pressed key code
            event = event || window.event;
            const charCode = event.which || event.keyCode;

            // Convert the key code to a character
            const charStr = String.fromCharCode(charCode);

            // Regular expression to match decimal numbers (including negative and decimal point)
            const pattern = /^[-]?\d*(?:[.]?\d{0,2})?$/;

            // Check if the entered character is valid according to the pattern
            if (pattern.test(charStr)) {
                return true; // Allow the input
            } else {
                return false; // Prevent the input
            }
        }
    </script>
</asp:Content>
