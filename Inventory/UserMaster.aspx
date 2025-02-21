<%@ Page Title="" Language="C#" MasterPageFile="~/InventoryMas.Master" AutoEventWireup="true" CodeBehind="UserMaster.aspx.cs" Inherits="Inventory.UserMaster" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


    <script src="Content/assets/js/jquery-3.7.1.min.js"></script>
    <script src="Content/assets/plugins/toastr/toastr.min.js" type="text/javascript"></script>
    <script src="Content/assets/plugins/toastr/toastr.js" type="text/javascript"></script>
    <script src="Content/jquery.validate.min.js" type="text/javascript"></script>



    <style type="text/css">
        .Pageing td table tbody tr td a {
            padding: 3px 10px;
            background-color: none;
            border: 1px solid #d3d3d3;
        }

        /*   label.error {
            color: red;
            display: inline-flex;
        }*/
    </style>

    <%-- <script type="text/javascript">
        $(document).ready(function () {
            $('#btn_save').on('click', function () {
                rules: {
                  <%=txtusername.UniqueID %>: {
                          required: true
                      }
                  }
                  messages: {
                    <%=txtusername.UniqueID %>: {
                          required: "Name is required."
                      }
                  }
              });
          });
    </script>--%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <div class="page-wrapper">
        <div class="content container-fluid pb-0">
            <div class="row">
                <div class="col-md-12 pb-md-5">
                    <div class="card">
                        <div class="card-body card-buttons pb-0">
                            <h4 class="card-title fw-bold mb-4">User Master</h4>
                            <%-- <form id="form1" runat="server">--%>
                            <div class="row">
                                <div class="col-xl-6">
                                    <div class="input-block mb-3 row">
                                        <asp:Label CssClass="col-lg-3 col-form-label" runat="server" Text="User Name"></asp:Label>
                                        <div class="col-lg-9">
                                            <asp:TextBox CssClass="form-control" ID="txtusername" placeholder="username" runat="server" ValidateRequestMode="Enabled"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="input-block mb-3 row">
                                        <asp:Label runat="server" Text="Full Name" CssClass="col-lg-3 col-form-label"></asp:Label>
                                        <div class="col-lg-9">
                                            <asp:TextBox CssClass="form-control" ID="txtfullname" runat="server" placeholder="Full Name"></asp:TextBox>
                                        </div>

                                    </div>
                                    <div class="input-block mb-3 row">
                                        <asp:Label CssClass="col-lg-3 col-form-label" Text="User Password" runat="server"></asp:Label>
                                        <div class="col-lg-9">
                                            <asp:TextBox CssClass="form-control" ID="txtuserpass" runat="server" TextMode="Password" placeholder="User Password"></asp:TextBox>
                                        </div>
                                    </div>

                                </div>
                                <div class="col-xl-6">
                                    <div class="input-block mb-3 row">
                                        <asp:Label CssClass="col-lg-3 col-form-label" runat="server" Text="Mobile"></asp:Label>
                                        <div class="col-lg-9">
                                            <asp:TextBox CssClass="form-control" ID="txtmobile" runat="server" placeholder="Mobile"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="input-block mb-3 row">
                                        <label class="col-lg-3 col-form-label">Email</label>
                                        <div class="col-lg-9">
                                            <asp:TextBox CssClass="form-control" ID="txtemail" runat="server" placeholder="Email"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="input-block mb-3 row">
                                        <div class="col-lg-9">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" name="rdactive" type="radio" id="rbtnISActive" runat="server" value="Y" checked>
                                                <label class="form-check-label">
                                                    Is Active
                                                </label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" runat="server" name="rdactive" type="radio" id="rbtnnotactive" value="N">
                                                <label class="form-check-label">
                                                    Not Active
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class=" d-flex justify-content-between">
                                <div>
                                    <asp:Button ID="btn_save" CssClass="btn btn-primary  mt-3 mb-2 me-md-4" Text="Save" runat="server" OnClick="txtsave_Click" />
                                    <asp:Button ID="btn_clear" CssClass="btn btn-primary mt-3 mb-2" Text="clear" runat="server" OnClick="btn_clear_Click1" />
                                </div>
                                <div class="d-flex">
                                    <asp:TextBox runat="server" ID="txtsearch"  CssClass="form-control mt-3 mb-2 me-md-4" placeholder="Search......."></asp:TextBox>
                                    <asp:Button ID="btnFilter" CssClass="btn btn-primary mt-3 mb-2" runat="server" Text="Filter" OnClick="btnFilter_Click" />
                                </div>
                            </div>
                            <asp:Label ID="lblmassage" runat="server"></asp:Label>
                            <%-- </form>--%>
                        </div>

                        <%--<button type="button" class="btn btn-outline-primary me-1 mb-1" id="basic-alert">Basic</button>--%>

                        <div class="table-responsive no-pagination">
                            <div class="col-md-12 p-4 pb-0">
                                <asp:GridView CssClass="col-md-12 p-md-5 table table-hover" runat="server" ID="GridViewdata" Width="800px" HeaderStyle-BackColor="#7539FF" AutoGenerateColumns="false" HeaderStyle-ForeColor="White" OnRowEditing="GridViewdata_RowEditing" OnRowDeleting="GridViewdata_RowDeleting" PageSize="5" AllowSorting="true" AllowPaging="true" OnPageIndexChanging="GridViewdata_PageIndexChanging">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <div class="d-flex align-items-center ">
                                                    <div cssclass="btn-action-items me-4">
                                                        <asp:LinkButton ID="btn_edit" runat="server" CommandName="Edit" Text="Edit">
                                                            <i class="fe fe-edit text-success fa-lg"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                    <div cssclass="btn-action-items ms-5">
                                                        <asp:LinkButton ID="btn_delete" runat="server" CommandName="Delete" Text="Delete" OnClientClick="return confirm('Are you sure you want delete');">
                                                    <i class="fe fe-trash-2 text-danger ms-md-3 fa-lg"></i>
                                                        </asp:LinkButton>
                                                    </div>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Id" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblid" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("USERID")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="USER NAME" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblusername" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("USERNAME")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="FULL NAME" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblfullname" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("FULLNAME")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="USER PASSWORD" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lbluserpass" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("USERPASSWORD")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="EMAIL" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblemail" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("EMAIL")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="MOBILE" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblmobile" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("MOBILE")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="REMARK" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblremark" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("REMARK")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="CREATED DATE" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreatedate" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("CREATEDDATE")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="CREATED BY" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreatedby" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("CREATEDBY")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="UPDATE BY" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblupdateby" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("UPDATEBY")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="UPDATE DATE" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblupdateddate" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("UPDATEDATE")%>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>


                                        <asp:TemplateField HeaderText="ACTIVE" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblactive" CssClass="p-2" runat="server"
                                                    Text='<%#Bind("Flag")%>'></asp:Label>
                                            </ItemTemplate>

                                            <HeaderStyle ForeColor="White"></HeaderStyle>
                                        </asp:TemplateField>

                                    </Columns>

                                    <HeaderStyle BackColor="#7539FF" ForeColor="White"></HeaderStyle>
                                    <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NextPreviousFirstLast" NextPageText="Next" PreviousPageText="Previous"/>
                                    <PagerStyle HorizontalAlign="left" CssClass="Pageing" />
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
