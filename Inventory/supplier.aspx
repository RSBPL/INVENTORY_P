<%@ Page Title="" Language="C#" MasterPageFile="~/InventoryMas.Master" AutoEventWireup="true" CodeBehind="supplier.aspx.cs" Inherits="Inventory.supplier" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Content/assets/js/jquery-3.7.1.min.js"></script>
    <script src="Content/assets/plugins/toastr/toastr.min.js" type="text/javascript"></script>
    <script src="Content/assets/plugins/toastr/toastr.js" type="text/javascript"></script>




    <style type="text/css">
        .pagination-ys {
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

        /*.Pageing td table tbody tr td a {
            margin: 5px 5px;
            padding: 5px 10px;
            background-color: none;
            border: 1px solid #d3d3d3;
        }*/
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="page-wrapper">
        <div class="content container-fluid pb-0">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title fw-bold mb-5">Supplier</h4>
                            <%-- <form action="#">--%>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="input-block mb-3">
                                        <label>Supplier Code:</label>
                                        <asp:TextBox ID="txtsuppliercode" CssClass="form-control" runat="server" placeholder="Supplier Code"></asp:TextBox>
                                    </div>
                                    <div class="input-block mb-3">
                                        <label>Address:</label>
                                        <asp:TextBox ID="txtaddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-block mb-3">
                                                <label>Name:</label>
                                                <asp:TextBox ID="txtname" runat="server" CssClass="form-control" placeholder="Name"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="input-block mb-3">
                                                <label>Mobile:</label>
                                                <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" placeholder="Mobile"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="input-block mb-3">
                                                <label>Email</label>
                                                <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="rg" runat="server" ControlToValidate="txtemail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="* invalid email format" ForeColor="Red">
                                                </asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="input-block mb-3">
                                                <label>GST Number:</label>
                                                <asp:TextBox ID="txtgstno" CssClass="form-control" runat="server" placeholder="GST Number"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="d-flex justify-content-between">
                                <div class="text-start mt-3 mb-4">
                                    <asp:Button ID="btn_save" runat="server" CssClass="btn btn-primary px-4  me-4" Text="Save" OnClick="txt_save_Click" />
                                    <asp:Button ID="btn_clear" runat="server" CssClass="btn btn-primary px-4 " Text="Clear" OnClick="txt_clear_Click" />
                                </div>

                                <div class="d-flex mt-3 mb-4">
                                    <asp:TextBox runat="server" ID="txtsearch" CssClass="form-control mt-3 mb-2 me-md-4" placeholder="Search......."></asp:TextBox>
                                    <asp:Button ID="btnFilter" CssClass="btn btn-primary mt-3 mb-2" runat="server" Text="Filter" OnClick="btnFilter_Click" />
                                </div>
                            </div>

                            <%--  </form>--%>

                            <div class=" table-responsive no-pagination pb-3 ">
                                <asp:GridView runat="server" AutoGenerateColumns="false" ID="gridviewdata" CssClass="col-md-12 p-md-5 table table-hover" HeaderStyle-BackColor="#7539FF" OnRowEditing="gridviewdata_RowEditing" OnRowDeleting="gridviewdata_RowDeleting" PageSize="5" AllowSorting="true" AllowPaging="true" OnPageIndexChanging="gridviewdata_PageIndexChanging">
                                    <Columns>

                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <div class=" d-flex align-items-center ">
                                                    <div class="btn-action-items me-2">
                                                        <asp:LinkButton ID="btn_edit" runat="server" CommandName="Edit">
                                                             <i class="fe fe-edit text-success fa-lg"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div class="btn-action-items">
                                                        <asp:LinkButton ID="btn_delete" runat="server" CommandName="Delete" OnClientClick="return confirm('Are you sure you want to delete?');">
                                                            <i class="fe fe-trash-2 text-danger ms-md-3 fa-lg"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="ID" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblid" runat="server" CssClass="p-2" Text='<%#Bind("supplierid")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Supplier Code" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblsuppliercode" runat="server" CssClass="p-2" Text='<%#Bind("supplier_code")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Name" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblname" runat="server" CssClass="p-2" Text='<%#Bind("Name")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Email" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblemail" runat="server" CssClass="p-2" Text='<%#Bind("Email")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Mobile" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmobile" runat="server" CssClass="p-2" Text='<%#Bind("mobile")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Address" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lbladdress" CssClass="p-2" runat="server" Text='<%#Bind("Address")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="GST NO" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblgst" CssClass="p-2" runat="server" Text='<%#Bind("GST")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Created By" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreateby" CssClass="p-2" runat="server" Text='<%#Bind("createdby")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Created Date" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreateddate" CssClass="p-2" runat="server" Text='<%#Bind("createddate")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Updated by" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblupdatedby" CssClass="p-2" runat="server" Text='<%#Bind("updatedby")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Updated Date" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblupdateddate" CssClass="p-2" runat="server" Text='<%#Bind("updateddate")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                    </Columns>
                                    <PagerStyle HorizontalAlign="left" CssClass="pagination-ys" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
