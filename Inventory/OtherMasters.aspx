<%@ Page Title="" Language="C#" MasterPageFile="~/InventoryMas.Master" AutoEventWireup="True" Inherits="Inventory.WebForm3" Codebehind="OtherMasters.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Content/assets/js/jquery-3.7.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="Content/assets/js/script.js"></script>
<link rel="stylesheet" href="Content/assets/plugins/alertify/alertify.min.css" />
<script src="Content/assets/plugins/toastr/toastr.min.js" type="text/javascript"></script>
<script src="Content/assets/plugins/toastr/toastr.js" type="text/javascript"></script>
<link rel="stylesheet" href="Content/assets/css/style.css" />
<link rel="stylesheet" href="../Content/assets/css/bootstrap.min.css">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-wrapper">
        <%--#878A99--%>
        <div class="content container-fluid pb-0">
            <!-- Page Header -->
            <div class="page-header">
                <div class="content-page-header">
                    <h5>Other Masters</h5>
                </div>
            </div>
            <asp:Button ID="itemcategbtn" CssClass="btn btn-filters w-auto popup-toggle" Style="font-size: 14px; font-weight: 600; border-radius: 8px; color: #878A99; min-width: 39px; height: 39px; background: #fff; border: 1px solid #fff; box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.02); -webkit-transition: all 0.4s ease; -ms-transition: all 0.4s ease; transition: all 0.4s ease;"
                Enabled="false" runat="server" Text="Category" OnClick="itemcategbtn_Click1" Font-Underline="true" />
            <asp:Button ID="modelbtn" CssClass="btn btn-filters w-auto popup-toggle" Style="font-size: 14px; font-weight: 600; border-radius: 8px; color: #878A99; min-width: 39px; height: 39px; background: #fff; border: 1px solid #fff; box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.02); -webkit-transition: all 0.4s ease; -ms-transition: all 0.4s ease; transition: all 0.4s ease;"
                runat="server" Text="Model" OnClick="modelbtn_Click" />
            <asp:Button ID="colorbtn" CssClass="btn btn-filters w-auto popup-toggle" Style="font-size: 14px; font-weight: 600; border-radius: 8px; color: #878A99; min-width: 39px; height: 39px; background: #fff; border: 1px solid #fff; box-shadow: 0px 4px 4px 0px rgba(0, 0, 0, 0.02); -webkit-transition: all 0.4s ease; -ms-transition: all 0.4s ease; transition: all 0.4s ease;"
                runat="server" Text="Color" OnClick="colorbtn_Click" />
            <br />
            <br />
            <!-- /Page Header -->
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <asp:DropDownList CssClass="btn btn-white-outline dropdown-toggle fas fa-angle-down" AutoPostBack="true" ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged1"></asp:DropDownList>
                            <asp:Label ID="label1" Text="" runat="server"></asp:Label>
                            <%--<asp:DropDownList CssClass="btn btn-white-outline dropdown-toggle fas fa-angle-down" ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged1"></asp:DropDownList>
                            <asp:Label ID="label1" Text="" runat="server"></asp:Label>--%>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9 col-md-8">
                    <div class="card bg-white">
                        <div class="card-body">
                            <div class="email-header">
                                <div class="row">
                                    <div class="col top-action-left">
                                        <div class="float-start">
                                            <%--<button type="button" class="btn btn-white-outline dropdown-toggle" data-bs-toggle="dropdown">Actions <i class="fas fa-angle-down"></i></button>--%>
                                            <asp:LinkButton ID="addbtn" CssClass="btn mb-0 btn-primary" runat="server" OnClick="addbtn_Click">
                                            <i class="fas fa-plus me-1"></i>Add
                                            </asp:LinkButton>
                                        </div>

                                        <div class="btn-group dropdown-action mail-search">
                                            <input type="text" placeholder="Search Messages" class="form-control search-message">
                                        </div>
                                    </div>
                                </div>
                                <div class="col-auto top-action-right">
                                    <div class="text-end">
                                        <button type="button" title="Refresh" data-bs-toggle="tooltip" class="btn btn-white-outline d-none d-md-inline-block"><i class="fas fa-sync-alt"></i></button>
                                        <div class="btn-group">
                                            <a class="btn btn-white-outline"><i class="fas fa-angle-left"></i></a>
                                            <a class="btn btn-white-outline"><i class="fas fa-angle-right"></i></a>
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <span class="text-muted d-none d-md-inline-block">Showing 10 of 112 </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%--OnRowCommand="CustomCommand" OnRowEditing="GridView_RowEditing" OnPageIndexChanging="gridview_PageIndexChanging" PageSize="5" AllowPaging="True"--%>
                    </div>
                </div>
            </div>
            <div class="content-page-header">
                <asp:Label runat="server" ID="heading1" Text="Item Category" Font-Bold="true" Font-Size="Medium"></asp:Label>
            </div>
            <div class="card-table">
                <div class="card-body">
                    <asp:Label ID="lablemssg" Font-Bold="true" runat="server"></asp:Label>
                    <div class="table-responsive">
                        <%-- CommandName="CustomDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Edit"--%>
                        <div class="table table-center table-hover datatable table-sm">
                            <asp:GridView ID="GridView2" CssClass="gridviewpager" runat="server" OnPageIndexChanging="gridview_PageIndexChanging" AutoGenerateColumns="false" OnRowEditing="GridView_RowEditing" OnRowCommand="CustomCommand" PageSize="5" AllowPaging="True">
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <div class="d-flex align-items-center">
                                                <div class="btn-action-icon me-2">
                                                    <asp:LinkButton ID="button2" runat="server" BackColor="Transparent" BorderWidth="0" CommandName="Edit">
                            <i class="fe fe-edit"></i>
                                                    </asp:LinkButton>
                                                </div>
                                                <div class="btn-action-icon">
                                                    <asp:LinkButton ID="button" runat="server" BackColor="Transparent" BorderWidth="0" OnClientClick="return confirm('Are you sure you want to delete?');" CommandName="CustomDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>">
                            <i class="fe fe-trash-2"></i>
                                                    </asp:LinkButton>
                                                </div>
                                            </div>

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Item ID">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="gridunitCode" Text='<%#Bind("Id") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Item Category">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="griditemcategory" Text='<%#Bind("Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Createdby">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="gridcreateby" Text='<%#Bind("Createdby") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Createddate">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="gridcreatedate" Text='<%#Bind("Createddate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Updatedby">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="gridupdateby" Text='<%#Bind("Updatedby") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Updateddate">
                                        <ItemTemplate>
                                            <asp:Label runat="server" ID="gridupdatedate" Text='<%#Bind("Updateddate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="modal custom-modal modal-lg fade" id="mymodal" role="dialog">
                    <div class="modal-dialog modal-dialog-centered modal-md">
                        <div class="modal-content">
                            <div class="modal-header border-0 pb-0">
                                <div class="form-header modal-header-title text-start mb-0">
                                    <h4 class="mb-0">Add</h4>
                                </div>
                                <asp:Button runat="server" type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" OnClick="Unnamed_Click"></asp:Button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-lg-4 col-md-12">
                                        <div class="input-block mb-3">
                                            <asp:Label ID="categ" runat="server" Text="Item Category"></asp:Label>
                                            <asp:TextBox CssClass="form-control" placeholder="Enter Category" runat="server" ID="name"></asp:TextBox>
                                            <br>
                                            <asp:Label runat="server" Visible="false" ID="entryid"></asp:Label>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="modal-footer">
                                <asp:Button runat="server" type="button" Text="Cancel" data-bs-dismiss="modal" class="btn btn-back cancel-btn me-2" OnClick="Unnamed_Click"></asp:Button>
                                <asp:Button runat="server" ID="save" type="submit" CssClass="btn btn-primary paid-continue-btn" Text="Save" OnClick="save_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
