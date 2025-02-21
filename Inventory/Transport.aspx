<%@ Page Title="" Language="C#" MasterPageFile="~/InventoryMas.Master" AutoEventWireup="true" CodeBehind="Transport.aspx.cs" Inherits="Inventory.Transport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Content/assets/js/jquery-3.7.1.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="Content/assets/js/script.js"></script>
    <link rel="stylesheet" href="Content/assets/plugins/alertify/alertify.min.css" />
    <script src="Content/assets/plugins/toastr/toastr.min.js" type="text/javascript"></script>
    <script src="Content/assets/plugins/toastr/toastr.js" type="text/javascript"></script>
    <link rel="stylesheet" href="Content/assets/css/style.css" />
    <link rel="stylesheet" href="../Content/assets/css/bootstrap.min.css">

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

    <script type="text/javascript">
        $(document).ready(function () {
            $("#<%= txtmobile.ClientID %>").on("input", function () {
                this.value = this.value.replace(/[^0-9]/g, ''); // Remove non-numeric characters
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-wrapper">
        <div class="content container-fluid pb-0">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-body">
                            <h4 class="card-title fw-bold mb-5">Transport</h4>
                            <%-- <form action="#">--%>

                            <!-- Button trigger modal -->
                            <div>
                                <asp:LinkButton runat="server" CssClass="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    <i class="fa fa-plus-circle me-2" aria-hidden="true"></i>Add Transport
                                </asp:LinkButton>
                            </div>

                            <!-- Modal -->
                            <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fw-bolder fs-5" id="exampleModalLabel">Add Transport</h1>
                                            <%-- <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>--%>
                                            <asp:Button CssClass="btn-close" runat="server" data-bs-dismiss="modal" aria-label="Close" OnClick="btn_clear_Click" />
                                        </div>
                                        <div class="modal-body">
                                            <div class="row">
                                                <div class="col-md-3">
                                                    <div class="input-block mb-3">

                                                        <label>Unit code: <span style="color: red">*</span></label>
                                                        <%--<asp:DropDownList CssClass="form-select" runat="server" ID="ddunit" AutoPostBack="true">
                                                            <asp:ListItem Value="0"> ---Select--- </asp:ListItem>
                                                        </asp:DropDownList>--%>
                                                        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                                            <ContentTemplate>
                                                                <asp:DropDownList CssClass="form-select" runat="server" ID="ddunit" AutoPostBack="true">
                                                                    <asp:ListItem Value="0"> ---Select--- </asp:ListItem>
                                                                </asp:DropDownList>

                                                            </ContentTemplate>
                                                            <Triggers>
                                                                <asp:AsyncPostBackTrigger ControlID="ddunit" EventName="SelectedIndexChanged" />
                                                            </Triggers>
                                                        </asp:UpdatePanel>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="input-block mb-3">
                                                        <label>Transportor Name: <span style="color: red">*</span></label>
                                                        <asp:TextBox ID="txttransportname" runat="server" CssClass="form-control" placeholder="Transport Name"></asp:TextBox>
                                                        <%--  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Name cannot be blank" ControlToValidate="txttransportname" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="input-block mb-3">
                                                        <label>Transportor Phone Number: <span style="color: red">*</span></label>
                                                        <asp:TextBox ID="txttransportPhonenumber" runat="server" CssClass="form-control" placeholder="Phone Number"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="input-block mb-3">
                                                        <label>Contact Person: <span style="color: red">*</span></label>
                                                        <asp:TextBox ID="txtcontactperson" runat="server" CssClass="form-control" placeholder="Contact Person"></asp:TextBox>
                                                    </div>
                                                </div>

                                                <div class="col-md-3">
                                                    <div class="input-block mb-3">
                                                        <label>Mobile:<span style="color: red">*</span></label>
                                                        <asp:TextBox ID="txtmobile" runat="server" CssClass="form-control" TextMode="Phone" MaxLength="10" placeholder="Mobile"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="input-block mb-3">
                                                        <label>GST NO:</label>
                                                        <asp:TextBox ID="txtgstno" runat="server" CssClass="form-control" placeholder="GST NO"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-3">
                                                    <div class="input-block mb-3 ">
                                                        <label>Email:</label>
                                                        <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" placeholder="Email"></asp:TextBox>
                                                        <asp:RegularExpressionValidator ID="rg" runat="server" ControlToValidate="txtemail" ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ErrorMessage="* invalid email format" ForeColor="Red">
                                                        </asp:RegularExpressionValidator>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="input-block mb-3">
                                                        <label>Address<span style="color: red"> *</span></label>
                                                        <asp:TextBox ID="txtaddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>
                                                    </div>
                                                </div>


                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <h6 class="card-title fw-bold my-3">Vehicle Adding</h6>
                                                    </div>

                                                    <div class=" table table-responsive no-pagination ">

                                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                                            <ContentTemplate>
                                                                <asp:GridView ID="gridviewtable2" ShowFooter="true"
                                                                    OnRowDeleting="gridviewtable2_RowDeleting" OnRowDataBound="gridviewtable2_RowDataBound"
                                                                    OnRowCommand="gridviewtable2_RowCommand"
                                                                    AutoGenerateColumns="false" runat="server"
                                                                    ShowHeaderWhenEmpty="true" HeaderStyle-BackColor="#7539FF"
                                                                    CssClass="col-md-12 p-md-5 table table-hover ">

                                                                    <EmptyDataTemplate>
                                                                        <div class="text-center">No vehicles added yet .</div>
                                                                    </EmptyDataTemplate>

                                                                    <Columns>

                                                                        <asp:TemplateField>
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblidii" runat="server" Text='<%#Bind("AutoId") %>' ></asp:Label>
                                                                            </ItemTemplate>
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField HeaderText="Vehicle Type" HeaderStyle-ForeColor="White">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblvehiceltypes" runat="server" Text='<%#Bind("Vehicel_types") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                                                                    <ContentTemplate>
                                                                                        <asp:DropDownList CssClass="form-select" runat="server" ID="ddvehicletypes" AutoPostBack="true">
                                                                                            <asp:ListItem Value="0"> ---Select--- </asp:ListItem>
                                                                                            <asp:ListItem Value="1"> 2 wheeler </asp:ListItem>
                                                                                            <asp:ListItem Value="2"> 4 Wheeler </asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </ContentTemplate>
                                                                                    <Triggers>
                                                                                        <asp:AsyncPostBackTrigger ControlID="ddvehicletypes" EventName="SelectedIndexChanged" />
                                                                                    </Triggers>
                                                                                </asp:UpdatePanel>
                                                                            </FooterTemplate>
                                                                        </asp:TemplateField>


                                                                        <asp:TemplateField HeaderText="Vehicle No" HeaderStyle-ForeColor="White">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblvehicelnos" CssClass="p-2" runat="server" Text='<%#Bind("vehicel_no") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                <asp:TextBox ID="txtvehicelnos" CssClass=" form-control" runat="server"></asp:TextBox>
                                                                            </FooterTemplate>
                                                                        </asp:TemplateField>

                                                                        <asp:TemplateField HeaderText="Action" HeaderStyle-ForeColor="White">
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="btn_vehiceldelete" runat="server" CommandName="Delete"
                                                                                    CommandArgument="<%#Container.DataItemIndex%>">
                                                                            <i class="fe fe-trash-2 text-danger ms-md-3 fa-lg"></i>
                                                                                </asp:LinkButton>
                                                                            </ItemTemplate>
                                                                            <FooterTemplate>
                                                                                <asp:Button ID="btntest" runat="server" Text="Add" CausesValidation="False" CommandName="Save" />
                                                                            </FooterTemplate>
                                                                        </asp:TemplateField>
                                                                    </Columns>

                                                                </asp:GridView>
                                                            </ContentTemplate>
                                                        </asp:UpdatePanel>

                                                    </div>

                                                </div>

                                                <%-- Button--%>
                                                <div class="modal-footer mt-3">
                                                    <div class="me-4">
                                                        <asp:Button CssClass="btn btn-primary px-4 px-3" Text="Clear" ID="btn_clear" runat="server" OnClick="btn_clear_Click" />
                                                    </div>
                                                    <div>
                                                        <asp:Button CssClass="btn btn-primary px-4 px-3" Text="Save" ID="btn_save" runat="server" OnClick="btn_save_Click" />
                                                    </div>
                                                </div>
                                                <%--Button--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%--<asp:Label ID="lblmassage" runat="server"></asp:Label>--%>

                            <div class="d-flex justify-content-end">
                                <div class="me-3">
                                    <asp:TextBox ID="txtsearch" CssClass="form-control" OnTextChanged="txtsearch_TextChanged" AutoPostBack="true" runat="server" placeholder="Search..."></asp:TextBox>
                                </div>
                                <%-- <div>
                                    <asp:Button ID="btn_search" CssClass="btn btn-primary" Text="Filter" runat="server" OnClick="btn_search_Click" />
                                </div>--%>
                            </div>

                            <%--  </form>--%>

                            <div class=" table-responsive no-pagination">
                                <asp:GridView AutoGenerateColumns="false" runat="server" ID="gridviewtable" CssClass="col-md-12 p-md-5 mt-5 table table-hover" HeaderStyle-BackColor="#7539FF" OnRowEditing="gridviewtable_RowEditing" OnRowDeleting="gridviewtable_RowDeleting" PageSize="5" AllowSorting="true" AllowPaging="true" OnPageIndexChanging="gridviewtable_PageIndexChanging">
                                    <Columns>

                                        <asp:TemplateField>
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

                                        <asp:TemplateField HeaderText="ID" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblid" runat="server" CssClass="p-2" Text='<%#Bind("id") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="Unitcode" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblunitcode" runat="server" CssClass="p-2" Text='<%#Bind("unicode") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Transport Code" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lbltransportcode" runat="server" CssClass="p-2" Text='<%#Bind("transportorcode") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Transportor Name" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lbltranpname" runat="server" CssClass="p-2" Text='<%#Bind("transportor_name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Transportor Phone No" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lbltranpphoneno" runat="server" CssClass="p-2" Text='<%#Bind("transportor_number") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Contact Person" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcontactperson" runat="server" CssClass="p-2" Text='<%#Bind("contact_person") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Mobile" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmobile" runat="server" CssClass="p-2" Text='<%#Bind("moblie") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="GST NO" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblgstno" runat="server" CssClass="p-2" Text='<%#Bind("gstno") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Email" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblemail" runat="server" CssClass="p-2" Text='<%#Bind("email") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Address" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lbladdress" runat="server" CssClass="p-2" Text='<%#Bind("address") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Created By" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreatedby" runat="server" CssClass="p-2" Text='<%#Bind("createdby") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Created Date" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreateddate" runat="server" CssClass="p-2" Text='<%#Bind("createddate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Updated By" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblupdatedby" runat="server" CssClass="p-2" Text='<%#Bind("updatedby") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Updated date" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblupdatedate" runat="server" CssClass="p-2" Text='<%#Bind("updateddate") %>'></asp:Label>
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
