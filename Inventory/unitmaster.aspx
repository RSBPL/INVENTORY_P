<%@ Page Title="" Language="C#" MasterPageFile="~/InventoryMas.Master" AutoEventWireup="true" CodeBehind="unitmaster.aspx.cs" Inherits="Inventory.unitmaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="Content/assets/js/jquery-3.7.1.min.js"></script>
    <script src="Content/assets/plugins/toastr/toastr.min.js" type="text/javascript"></script>
    <script src="Content/assets/plugins/toastr/toastr.js" type="text/javascript"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Page Wrapper -->
    <div class="page-wrapper">
        <div class="content container-fluid">
            <div class="card mb-0">
                <div class="card-body">
                    <div class="content-page-header">
                        <h5>Unit Entry</h5>
                        <%-- <asp:Button runat="server" CssClass ="btn btn-outline-info me-1 mb-1" ID="savesuccess" Text="Save" OnClick="savesuccess_Click" />--%>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="delivery-card">
                                <div class="form-group-item border-0 mb-0">
                                    <div class="row align-item-center">
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="input-block mb-3">
                                                <label>Unit Code</label>
                                                <asp:TextBox runat="server" ID="lblunitcode" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="input-block mb-3">
                                                <label>Unit Name</label>
                                                <asp:TextBox runat="server" ID="lblunitname" Type="Text" CssClass="form-control" placeholder="Enter Unit Name"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="input-block mb-3">
                                                <label>Email</label>
                                                <asp:TextBox runat="server" ID="lblemail" Type="text" CssClass="form-control" placeholder="Enter Email"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="input-block mb-3">
                                                <label>Mobile Number</label>
                                                <asp:TextBox ID="lblmobileno" runat="server" Type="text" CssClass="form-control" placeholder="Enter Mobile Number."></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-4 col-md-6 col-sm-12">
                                            <div class="input-block mb-3">
                                                <label>GST Number</label>
                                                <asp:TextBox runat="server" ID="lblgstno" Type="text" CssClass="form-control" placeholder="Enter GST Number"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="input-block mb-3">
                                                <label>Address 1</label>
                                                <asp:TextBox runat="server" ID="lbladd1" Type="text" CssClass="form-control" placeholder="Enter Address 1"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="input-block mb-3">
                                                <label>Address 2</label>
                                                <asp:TextBox runat="server" ID="lbladd2" Type="text" CssClass="form-control" placeholder="Enter Address 2"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="text-end mt-4">
                                            <asp:Button CssClass="btn btn-primary me-1" Text="Clear" runat="server" OnClick="clear_Click" />
                                            <asp:Button CssClass="btn btn-outline-info me-1 mb-1" Style="color: #fff; background-color: #198754; border-color: #198754;" Text="Save" runat="server" ID="savebtn" OnClick="savebtn_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div classs="input-block mb-3">
                                    <asp:TextBox ID="searchBox" Width="450px" CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:Button CssClass="btn btn-outline-info me-1 mb-1" Font-Bold="false" Style="--bs-btn-color: #0dcaf0; --bs-btn-border-color: #0dcaf0; --bs-btn-hover-color: #000; --bs-btn-hover-bg: #0dcaf0; --bs-btn-hover-border-color: #0dcaf0; --bs-btn-focus-shadow-rgb: 13,202,240; --bs-btn-active-color: #000; --bs-btn-active-bg: #0dcaf0; --bs-btn-active-border-color: #0dcaf0; --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125); --bs-btn-disabled-color: #0dcaf0; --bs-btn-disabled-bg: transparent; --bs-btn-disabled-border-color: #0dcaf0; --bs-gradient: none; }"
                                        ID="searchButton" runat="server" Text="Search" OnClick="searchButton_Click" />
                                    <asp:Button CssClass="btn bbtn-primary me-1 mb-1" ID="reset" Style="--bs-btn-color: #dc3545; --bs-btn-border-color: #dc3545; --bs-btn-hover-color: #fff; --bs-btn-hover-bg: #dc3545; --bs-btn-hover-border-color: #dc3545; --bs-btn-focus-shadow-rgb: 220,53,69; --bs-btn-active-color: #fff; --bs-btn-active-bg: #dc3545; --bs-btn-active-border-color: #dc3545; --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125); --bs-btn-disabled-color: #dc3545; --bs-btn-disabled-bg: transparent; --bs-btn-disabled-border-color: #dc3545; --bs-gradient: none; }"
                                        runat="server" Text="Reset" OnClick="reset_Click" />
                                </div>
                            </div>
                            <br />
                            <br />
                            <%--<div class="form-group-item">
                                    <div class="card-table">
                                        <div class="card-body">
                                            <div class="table-responsive no-pagination">
                                                <table class="table table-center table-hover datatable">
                                                    <thead class="thead-light">
                                                        <tr>
                                                            <th>Product / Service</th>
                                                            <th>Quantity</th>
                                                            <th>Unit</th>
                                                            <th>Rate</th>
                                                            <th>Discount</th>
                                                            <th>Tax</th>
                                                            <th>Amount</th>
                                                            <th class="no-sort">Action</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>Lorem ipsum dolor sit amet</td>
                                                            <td>
                                                                <input type="number" class="form-control" placeholder="0"></td>
                                                            <td>Pcs</td>
                                                            <td>
                                                                <input type="number" class="form-control" placeholder="120"></td>
                                                            <td>0</td>
                                                            <td>0</td>
                                                            <td>$120.00</td>
                                                            <td class="d-flex align-items-center">
                                                                <a href="#" class="btn-action-icon me-2" data-bs-toggle="modal" data-bs-target="#add_discount"><span><i class="fe fe-edit"></i></span></a>
                                                                <a href="#" class="btn-action-icon" data-bs-toggle="modal" data-bs-target="#delete_discount"><span><i class="fe fe-trash-2"></i></span></a>
                                                            </td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>--%>
                            <div class="card-table">
                                <div class="card-body">
                                    <asp:Label ID="lablemssg" Font-Bold="true" runat="server"></asp:Label>
                                    <div class="table-responsive">
                                        <%--OnRowEditing="GridView_RowEditing" OnRowCommand="CustomCommand" CommandName="CustomDelete" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" CommandName="Edit"--%>
                                        <div class="table table-center table-hover datatable table-sm">
                                            <asp:GridView ID="GridView" CssClass="gridviewpager" runat="server" OnRowCommand="CustomCommand" OnPageIndexChanging="gridview_PageIndexChanging" OnRowEditing="GridView_RowEditing" PageSize="5" AllowPaging="True" AutoGenerateColumns="false">
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
                                                        <%--<EditItemTemplate>
                    <asp:Button ID="btn_Cancel" runat="server" Text="Cancel" CommandName="Cancel" />
                </EditItemTemplate>--%>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Unit Code">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridunitCode" Text='<%#Bind("Unitcode") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Unit Name">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridunitName" Text='<%#Bind("Unitname") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Address 1">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridadd1" Text='<%#Bind("Address_1") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Address 2">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridadd2" Text='<%#Bind("Address_2") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="GST NO">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridgstno" Text='<%#Bind("GSTIN") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="MOBILE">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridmobileno" Text='<%#Bind("MOBILE") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="EMAIL">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridemail" Text='<%#Bind("EMAIL") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Created Date">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridmcreatedate" Text='<%#Bind("Createddate") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Created By">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridcreatedby" Text='<%#Bind("Createdby") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="UPDATED BY">
                                                        <ItemTemplate>
                                                            <asp:Label runat="server" ID="gridupdateby" Text='<%#Bind("Updatedby") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="UPDATED DATE">
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
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- /Page Wrapper -->
</asp:Content>
