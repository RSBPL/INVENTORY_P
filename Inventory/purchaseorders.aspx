<%@ Page Title="" Language="C#" MasterPageFile="~/InventoryMas.Master" AutoEventWireup="True" CodeBehind="purchaseorders.aspx.cs" Inherits="Inventory.purchaseorders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="Content/assets/js/jquery-3.7.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Content/assets/js/script.js"></script>
    <script src="Content/assets/plugins/toastr/toastr.min.js" type="text/javascript"></script>
    <script src="Content/assets/plugins/toastr/toastr.js" type="text/javascript"></script>
    <link rel="stylesheet" href="Content/assets/css/style.css" />
    <link rel="stylesheet" href="../Content/assets/css/bootstrap.min.css">

    <style type="text/css">
        .pagination-ys {
            /*gokul*/
            /*display: inline-block;*/
            padding-left: 0;
            margin: 20px 0;
            border-radius: 4px;
        }

            .pagination-ys table > tbody > tr > td {
                display: inline;
            }

                .pagination-ys table > tbody > tr > td > a,
                .pagination-ys table > tbody > tr > td > span {
                    position: relative;
                    float: left;
                    padding: 8px 12px;
                    line-height: 1.42857143;
                    text-decoration: none;
                    color: #dd4814;
                    background-color: #ffffff;
                    border: 1px solid #dddddd;
                    margin-left: -1px;
                }

                .pagination-ys table > tbody > tr > td > span {
                    position: relative;
                    float: left;
                    padding: 8px 12px;
                    line-height: 1.42857143;
                    text-decoration: none;
                    margin-left: -1px;
                    z-index: 2;
                    color: #ffffff;
                    background-color: #7539FF;
                    border-color: #dddddd;
                    cursor: default;
                }

                .pagination-ys table > tbody > tr > td:first-child > a,
                .pagination-ys table > tbody > tr > td:first-child > span {
                    margin-left: 0;
                    border-bottom-left-radius: 4px;
                    border-top-left-radius: 4px;
                }

                .pagination-ys table > tbody > tr > td:last-child > a,
                .pagination-ys table > tbody > tr > td:last-child > span {
                    border-bottom-right-radius: 4px;
                    border-top-right-radius: 4px;
                }

                .pagination-ys table > tbody > tr > td > a:hover,
                .pagination-ys table > tbody > tr > td > span:hover,
                .pagination-ys table > tbody > tr > td > a:focus,
                .pagination-ys table > tbody > tr > td > span:focus {
                    color: #ffffff;
                    background-color: #7539FF;
                    border-color: #dddddd;
                }

        /*.custom-tab {
            background-color: #7539FF !important;*/ /* Change to any color */
        /*color: white !important;*/ /* Text color */
        /*border-radius: 8px;
        }*/


        /*.Pageing td table tbody tr td a {
     margin: 5px 5px;
     padding: 5px 10px;
     background-color: none;
     border: 1px solid #d3d3d3;
 }*/
    </style>

    <style>
        .nav-pills .nav-link.active, .nav-pills .show > .nav-link {
            color: var(--bs-nav-pills-link-active-color);
            background-color: #7539ff !important;
        }
    </style>

    <%--  <script type="text/javascript">
        $(document).ready(function () {
            $("#btn_edit").click(function () {
                $("#examplemodal").modal("show");
            });
        });
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-wrapper">
        <div class="content container-fluid pb-0">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">

                        <ul class=" row d-flex nav nav-pills mb-3 pt-4 ps-4 mb-0" id="pills-tab" role="tablist">

                            <li class="col-md-6 nav-item" role="presentation">
                                <%-- <button class=" col-6 nav-link custom-tab active w-100" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#Purchases-orders" type="button" role="tab" aria-controls="pills-home" aria-selected="true">Purchases orders</button>--%>
                                <%--<asp:Button class="col-6 nav-link custom-tab active w-100" runat="server" ID="pillshometab" data-bs-toggle="pill" data-bs-target="#Purchases_orders" role="tab" aria-controls="pills-home" aria-selected="true" Text="Purchases orders" />--%>
                                <asp:LinkButton CssClass="col-6 nav-link w-100" Enabled="false" runat="server" ID="Purchasesorders_tab" OnClick="Purchasesorders_tab_Click" Style="color: #ffffff; background: #7539FF;">Purchases Orders </asp:LinkButton>
                            </li>
                            <li class="col-md-6 nav-item" role="presentation">
                                <%--<button class=" col-md-6 nav-link w-100" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#Purchases-list" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">Purchases list</button>--%>
                                <%-- <asp:Button CssClass="col-md-6 nav-link w-100" ID="pillsprofiletab" data-bs-toggle="pill" role="tab" aria-controls="pills-profile" aria-selected="false" data-bs-target="#Purchases_list" Text="Purchases list" runat="server" />--%>
                                <asp:LinkButton CssClass="col-md-6 nav-link w-100" runat="server" ID="Purchaseslist_tab" OnClick="Purchaseslist_tab_Click">
                                    Purchases List
                                </asp:LinkButton>
                                <%--<asp:Label Enabled="false" Text="" ID="purchaselist" runat="server"></asp:Label>--%>
                            </li>
                        </ul>

                        <%--tab button 2 --%>

                        <%--  <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                <ContentTemplate>--%>
                        <div class="row d-flex justify-content-end ">
                            <div class="col-4 me-5">
                                <asp:TextBox ID="txtsearch" Visible="false" CssClass="form-control" runat="server" OnTextChanged="txtsearch_TextChanged" AutoPostBack="true" placeholder="Search..."></asp:TextBox>
                            </div>
                        </div>
                        <%--      </ContentTemplate>
                         </asp:UpdatePanel>--%>

                        <div class="row">
                            <div class="col-md-12 px-md-4 pt-3">
                                <div class=" table-responsive no-pagination">
                                    <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                          <ContentTemplate>--%>
                                    <asp:GridView ID="gridviewpurchaseslist"
                                        AutoGenerateColumns="false"
                                        CssClass=" col-md-12 p-md-5 table table-hover" HeaderStyle-BackColor="#7539FF"
                                        AllowSorting="true" AllowPaging="true" PageSize="7" OnPageIndexChanging="gridviewpurchaseslist_PageIndexChanging"
                                        OnRowEditing="gridviewpurchaseslist_RowEditing" OnRowDeleting="gridviewpurchaseslist_RowDeleting"
                                        runat="server">
                                        <Columns>

                                            <asp:TemplateField HeaderText="Action" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <div class="d-flex align-items-center">
                                                        <div class="btn btn_edit">
                                                            <asp:LinkButton ID="btn_edit" runat="server" CommandName="Edit">
                                                             <i class="fe fe-edit text-success fa-lg"></i>
                                                            </asp:LinkButton>
                                                        </div>
                                                        <div class="btn btn_delete">
                                                            <asp:LinkButton ID="btn_delete" runat="server" CommandName="Delete" OnClientClick=" return confirm('Are you sure you want to delete?')">
                                                           <i class="fe fe-trash-2 text-danger ms-md-3 fa-lg"></i>
                                                            </asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Purchases orders NO" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPono" CssClass="p-2" runat="server" Text='<%#Bind("po_no") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Purchases orders Date" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPodate" CssClass="p-2" runat="server" Text='<%#Bind("po_date") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Invoice No" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblinvoiceno" CssClass="p-2" runat="server" Text='<%#Bind("invoice_no") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Invoice Date" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblinvoicedate" CssClass="p-2" runat="server" Text='<%#Bind("invoice_date") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Supplier Code" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsuppliercode" CssClass="p-2" runat="server" Text='<%#Bind("supplier_code") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Contact No" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcontactno" CssClass="p-2" runat="server" Text='<%#Bind("contactno") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Address" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbladdress" CssClass="p-2" runat="server" Text='<%#Bind("Address") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Email" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblemail" CssClass="p-2" runat="server" Text='<%#Bind("Email") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>


                                        <PagerSettings
                                            Mode="NumericFirstLast"
                                            PageButtonCount="3"
                                            FirstPageText="First"
                                            LastPageText="Last" />
                                        <PagerStyle HorizontalAlign="Left" CssClass="pagination-ys" />
                                    </asp:GridView>
                                    <%--    </ContentTemplate>
                      </asp:UpdatePanel>--%>
                                </div>
                            </div>
                        </div>


                        <%--Tab button 1 --%>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-body">
                                        <%--<h4 class="card-title fw-bold mb-5">Purchases orders</h4>--%>
                                        <%-- <form action="#">--%>
                                        <div class="row">
                                            <div class="col-md-3">
                                                <div class="input-block mb-3">
                                                    <asp:Label ID="lblpono" runat="server" Text="PO No:"></asp:Label>
                                                    <asp:TextBox ID="txtpono" ReadOnly="true" runat="server" CssClass="form-control" placeholder="Po No"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-block mb-3">
                                                    <asp:Label ID="lblpodate" runat="server" Text="PO Date:"></asp:Label>
                                                    <asp:TextBox ID="txtpodate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-block mb-3">
                                                    <%--<label>Invoice No</label>--%>
                                                    <asp:Label ID="lblinvoiceno" runat="server" Text="Invoice No"></asp:Label>
                                                    <asp:TextBox ID="txtivno" runat="server" CssClass="form-control" placeholder="Invoice"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-block mb-3 ">
                                                    <%--<label>Invoice Date</label>--%>
                                                    <asp:Label ID="lblinvoicedate" runat="server" Text="Invoice Date"></asp:Label>
                                                    <asp:TextBox ID="txtivdate" runat="server" CssClass="form-control" TextMode="Date" placeholder="Select Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <%--   <div class="col-md-3">
                                    <div class="input-block mb-3 ">
                                        <label>Invoice Date</label>
                                        <div class="cal-icon cal-icon-info">
                                            <asp:TextBox ID="txtivdate" runat="server" CssClass="datetimepicker form-control" placeholder="Select Date"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>--%>
                                            <div class="col-md-3">
                                                <div class="input-block mb-3">
                                                    <%-- <label>Supplier Code</label>--%>
                                                    <asp:Label ID="lblsuppliercode" runat="server" Text="Supplier Code"></asp:Label>
                                                    <asp:DropDownList CssClass="form-select" runat="server" ID="ddspcode" AutoPostBack="true" OnSelectedIndexChanged="ddspcode_SelectedIndexChanged">
                                                        <asp:ListItem Value="0"> ---Select--- </asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-block mb-3">
                                                    <%--<label>Contact No</label>--%>
                                                    <asp:Label ID="lblcontactno" runat="server" Text="Contact No"></asp:Label>
                                                    <asp:TextBox ID="txtcontactno" runat="server" CssClass="form-control" placeholder="Contact No"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-block mb-3">
                                                    <%--  <label>Address</label>--%>
                                                    <asp:Label ID="lbladdress" runat="server" Text="Address"></asp:Label>
                                                    <asp:TextBox ID="txtaddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <div class="input-block mb-3">
                                                    <%--  <label>Email</label>--%>
                                                    <asp:Label ID="lblemail" runat="server" Text="Email"></asp:Label>
                                                    <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                                                    <asp:RegularExpressionValidator ID="rg" runat="server" ControlToValidate="txtemail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="Invalid Email format" ForeColor="red">
                                                    </asp:RegularExpressionValidator>
                                                </div>
                                            </div>
                                        </div>
                                        <%--  </form>--%>

                                        <!-- Button trigger modal -->
                                        <div class="text-end">
                                            <asp:LinkButton ID="btn_AddProduct" CssClass="btn btn-primary" runat="server" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                                      <i class="fa fa-plus-circle me-2" aria-hidden="true"></i>Add products
                                            </asp:LinkButton>
                                        </div>


                                        <!-- Modal -->
                                        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-lg">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Add Products </h1>

                                                        <asp:Button runat="server" class="btn-close" data-bs-dismiss="modal" aria-label="Close" OnClick="btn_clear_Click" />
                                                    </div>
                                                    <div class="modal-body">
                                                        <%-- <form runat="server">--%>
                                                        <div class="row pt-3">
                                                            <div class="col-lg-6 col-sm-12">
                                                                <div class="input-block mb-3">
                                                                    <label>Product Code <span class="text-danger">*</span></label>
                                                                    <asp:TextBox ID="txtproductcode" ReadOnly="true" CssClass="form-control" runat="server" placeholder="Product Code"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6 col-sm-12">
                                                                <div class="input-block mb-3">
                                                                    <label>Product Name <span class="text-danger">*</span></label>
                                                                    <asp:TextBox ID="txtproductname" CssClass="form-control" placeholder="Enter Product Name" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                                                            <asp:UpdatePanel ID="updPanel1" runat="server" UpdateMode="Conditional">
                                                                <ContentTemplate>
                                                                    <div class="row d-flex">
                                                                        <div class="col-lg-6 col-sm-12">
                                                                            <div class="input-block mb-3">
                                                                                <label>Item Name <span class="text-danger">*</span></label>
                                                                                <asp:DropDownList CssClass="form-select" ID="dditemname" runat="server"
                                                                                    AutoPostBack="true" OnSelectedIndexChanged="dditemname_SelectedIndexChanged">
                                                                                    <asp:ListItem Value="0"> ---Select--- </asp:ListItem>
                                                                                </asp:DropDownList>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-lg-6 col-sm-12">
                                                                            <div class="input-block mb-3">
                                                                                <label>Quantity <span class="text-danger">*</span></label>
                                                                                <asp:TextBox ID="txtquantity" TextMode="Number" CssClass="form-control" runat="server"></asp:TextBox>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </ContentTemplate>
                                                                <Triggers>
                                                                    <asp:AsyncPostBackTrigger ControlID="dditemname" />
                                                                </Triggers>
                                                            </asp:UpdatePanel>
                                                            <div class="col-lg-6 col-sm-12">
                                                                <div class="input-block mb-3">
                                                                    <label>Units <span class="text-danger">*</span></label>
                                                                    <asp:DropDownList ID="ddunits" CssClass="form-select" runat="server">
                                                                        <asp:ListItem Value="0">--- Select Units ---</asp:ListItem>
                                                                        <asp:ListItem Value="1"> Kilogram </asp:ListItem>
                                                                        <asp:ListItem Value="2"> Gram </asp:ListItem>
                                                                        <asp:ListItem Value="3"> Liter </asp:ListItem>
                                                                        <asp:ListItem Value="4"> Millimetre </asp:ListItem>
                                                                        <asp:ListItem Value="5"> Pack </asp:ListItem>
                                                                        <asp:ListItem Value="6"> Piece </asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6 col-sm-12">
                                                                <div class="input-block mb-3">
                                                                    <label>Price <span class="text-danger">*</span></label>
                                                                    <asp:TextBox ID="txtprice" TextMode="Number" CssClass="form-control" placeholder="Enter Price" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6 col-sm-12">
                                                                <div class="input-block mb-3">
                                                                    <label>Discount <span class="text-danger">*</span></label>
                                                                    <asp:TextBox ID="txtdiscount" TextMode="Number" CssClass="form-control" placeholder="Enter Discount" runat="server"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-lg-6 col-sm-12">
                                                                <div class="input-block mb-3">
                                                                    <label>Tax <span class="text-danger">*</span></label>
                                                                    <asp:TextBox ID="txttax" CssClass="form-control" runat="server" placeholder="Enter Tax"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--  </form>--%>
                                                    </div>
                                                    <div class="modal-footer">
                                                        <%--<button  type="button" class="btn btn-secondary me-3" data-bs-dismiss="modal" >Close</button>--%>
                                                        <asp:Button ID="btn_clear" runat="server" CssClass="btn btn-secondary me-3" data-bs-dismiss="modal" Text="Close" OnClick="btn_clear_Click" />
                                                        <asp:Button ID="btn_AddProducts" CssClass="btn btn-primary" runat="server" Text="Save" OnCommand="btn_AddProducts_Command" />
                                                        <asp:Button ID="btn_UpdateProducts" CssClass="btn btn-primary" runat="server" Text="Update" OnCommand="btn_UpdateProducts_Command" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- Modal end -->

                                        <div class=" table table-responsive mt-3">
                                            <%-- <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>--%>
                                            <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                                <ContentTemplate>--%>
                                            <asp:GridView ID="gridaddproducts" runat="server"
                                                OnRowDeleting="gridaddproducts_RowDeleting"
                                                ShowHeaderWhenEmpty="true" AutoGenerateColumns="false"
                                                CssClass="col-md-12 p-md-5 table table-hover"
                                                HeaderStyle-BackColor="#7539FF"
                                                OnRowEditing="gridaddproducts_RowEditing" AllowPaging="true"
                                                AllowSorting="true" PageSize="4"
                                                OnPageIndexChanging="gridaddproducts_PageIndexChanging">
                                                <Columns>

                                                    <asp:TemplateField HeaderText="vehicle id" HeaderStyle-ForeColor="White" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblid" CssClass="p-2" runat="server" Text='<%#Bind("AutoID") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Product / Service" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblproduct" runat="server" CssClass="p-2" Text='<%#Bind("Product") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Items Name" HeaderStyle-ForeColor="White" Visible="false">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblitecode" runat="server" CssClass="p-2" Text='<%#Bind("itemcode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Items Name" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblitemName" runat="server" CssClass="p-2" Text='<%#Bind("ItemName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Quantity" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblquantity" runat="server" CssClass="p-2" Text='<%#Bind("quantity") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Unit" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblunit" runat="server" CssClass="p-2" Text='<%#Bind("unit") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Price" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblprice" runat="server" CssClass="p-2" Text='<%#Bind("price") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Discount" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbldiscount" runat="server" CssClass="p-2" Text='<%#Bind("discount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Tax" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbltax" runat="server" CssClass="p-2" Text='<%#Bind("tax") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Action" HeaderStyle-ForeColor="White">
                                                        <ItemTemplate>
                                                            <div class=" d-flex align-items-center ">
                                                                <div>
                                                                    <asp:LinkButton ID="editproduct" runat="server" CssClass="me-2" CommandName="edit">
                                                                                            <i class="fe fe-edit pe-2"></i>
                                                                    </asp:LinkButton>
                                                                </div>

                                                                <div>
                                                                    <asp:LinkButton ID="btn_deleteproducts" runat="server" CommandName="delete">
                                                                                          <i class="fe fe-trash-2 text-danger ms-md-3 fa-lg"></i>
                                                                    </asp:LinkButton>
                                                                </div>
                                                            </div>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                </Columns>

                                                <PagerStyle HorizontalAlign="Left" CssClass="pagination-ys" />
                                            </asp:GridView>
                                            <%--     </contenttemplate>
                                            </asp:updatepanel>--%>
                                        </div>

                                        <div class="btn mt-5">
                                            <asp:Button ID="btn_Save" CssClass="btn btn-primary" Text="Save" runat="server" OnClick="btn_Save_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
