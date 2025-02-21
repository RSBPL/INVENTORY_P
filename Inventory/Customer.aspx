<%@ Page Title="" Language="C#" MasterPageFile="~/InventoryMas.Master" AutoEventWireup="true" CodeBehind="Customer.aspx.cs" Inherits="Inventory.Customer" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="Content/assets/js/jquery-3.7.1.min.js"></script>
    <script src="Content/assets/plugins/toastr/toastr.min.js" type="text/javascript"></script>
    <script src="Content/assets/plugins/toastr/toastr.js" type="text/javascript"></script>
    <script src="Content/jquery.validate.min.js" type="text/javascript"></script>
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
        $("#<%= txtcontactno.ClientID %>").on("input", function () {
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
                            <h4 class="card-title fw-bold mb-5">Customers</h4>
                            <%-- <form action="#">--%>
                            <div class="row">
                             
                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>Unit code:</label>
                                        <asp:DropDownList CssClass="form-select" runat="server" ID="ddunit" AutoPostBack="true">
                                            <asp:ListItem Value="0"> ---Select--- </asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>Customer Code: <span style="color: red">*</span></label>
                                        <asp:TextBox ID="txtcustomercode" runat="server" CssClass="form-control" placeholder="Customer Code" ReadOnly="true"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>Customer Name: <span style="color: red">*</span></label>
                                        <asp:TextBox ID="txtcustomername" runat="server" CssClass="form-control" placeholder="Customer Name"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>Country:</label>
                                        <asp:DropDownList CssClass="form-select" runat="server" ID="ddcountry" AutoPostBack="true">
                                            <asp:ListItem Value="0"> ---Select--- </asp:ListItem>
                                            <asp:ListItem Value="1"> India </asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>State:</label>
                                        <asp:DropDownList CssClass="form-select" runat="server" ID="ddstate" AutoPostBack="true">
                                            <asp:ListItem Value="0"> ---Select--- </asp:ListItem>
                                            <asp:ListItem Value="1"> Bihar </asp:ListItem>
                                            <asp:ListItem Value="2"> Tripura </asp:ListItem>
                                            <asp:ListItem Value="3"> Chhattisgarh </asp:ListItem>
                                            <asp:ListItem Value="4"> Kerala </asp:ListItem>
                                            <asp:ListItem Value="5"> Karnataka </asp:ListItem>
                                            <asp:ListItem Value="6"> Uttarakhand </asp:ListItem>
                                            <asp:ListItem Value="7"> Goa </asp:ListItem>
                                            <asp:ListItem Value="8"> Madhya Pradesh </asp:ListItem>
                                            <asp:ListItem Value="9"> Tamil Nadu </asp:ListItem>
                                            <asp:ListItem Value="10"> Punjab </asp:ListItem>
                                            <asp:ListItem Value="11"> Uttar Pradesh </asp:ListItem>
                                            <asp:ListItem Value="12"> Gujarat </asp:ListItem>
                                            <asp:ListItem Value="13"> Maharashtra </asp:ListItem>
                                            <asp:ListItem Value="14"> Rajasthan </asp:ListItem>
                                            <asp:ListItem Value="15"> West Bengal </asp:ListItem>
                                            <asp:ListItem Value="16"> Delhi </asp:ListItem>
                                            <asp:ListItem Value="17"> Andhra Pradesh </asp:ListItem>
                                            <asp:ListItem Value="18"> Haryana </asp:ListItem>
                                            <asp:ListItem Value="19"> Manipur </asp:ListItem>
                                            <asp:ListItem Value="20"> Sikkim </asp:ListItem>
                                            <asp:ListItem Value="21"> Arunachal Pradesh </asp:ListItem>
                                            <asp:ListItem Value="22"> Himachal Pradesh </asp:ListItem>
                                            <asp:ListItem Value="23"> Meghalaya </asp:ListItem>
                                            <asp:ListItem Value="24"> Assam </asp:ListItem>
                                            <asp:ListItem Value="25"> Jharkhand </asp:ListItem>
                                            <asp:ListItem Value="26"> Mizoram </asp:ListItem>
                                            <asp:ListItem Value="27"> Telangana </asp:ListItem>
                                            <asp:ListItem Value="28"> Nagaland </asp:ListItem>
                                            <asp:ListItem Value="29"> Odisha </asp:ListItem>


                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>City:<span style="color: red">*</span></label>
                                        <asp:TextBox ID="txtcity" runat="server" CssClass="form-control" placeholder="City"></asp:TextBox>
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
                                        <label>PAN NO:</label>
                                        <asp:TextBox ID="txtpanno" runat="server" CssClass="form-control" placeholder="PAN NO"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>Contact No:</label>
                                        <asp:TextBox ID="txtcontactno" runat="server" CssClass="form-control" TextMode="Phone" MaxLength="10" placeholder="Contact No"></asp:TextBox>
                                       <%-- <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                            ErrorMessage=" Not a Valid Number "
                                            ValidationExpression="[0-9]{10}"
                                            ControlToValidate="txtcontactno" ForeColor="Red" />--%>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>Bank Account No:</label>
                                        <asp:TextBox ID="txtbankAccountNo" runat="server" CssClass="form-control" placeholder="Bank Account No"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>IFSC Code:</label>
                                        <asp:TextBox ID="txtIFSC" runat="server" CssClass="form-control" placeholder="IFSC Code"></asp:TextBox>
                                    </div>
                                </div>

                                <div class="col-md-3">
                                    <div class="input-block mb-3">
                                        <label>Address<span style="color: red"> *</span></label>
                                        <asp:TextBox ID="txtaddress" runat="server" CssClass="form-control" placeholder="Address"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="d-flex justify-content-between">
                                    <div class="d-flex">
                                        <div class="me-5">
                                            <asp:Button CssClass="btn btn-primary px-4 px-3" Text="Save" ID="btn_save" runat="server" OnClick="btn_save_Click" />
                                        </div>
                                        <div>
                                            <asp:Button CssClass="btn btn-primary px-4 px-3" Text="Clear" ID="btn_clear" runat="server" OnClick="btn_clear_Click" />
                                        </div>
                                    </div>
                                    <div class="d-flex">
                                        <div class="me-3">
                                            <asp:TextBox ID="txtsearch" CssClass=" form-control " runat="server" placeholder="Search..."></asp:TextBox>
                                        </div>
                                        <div>
                                            <asp:Button ID="btn_search" CssClass="btn btn-primary" Text="Filter" runat="server" OnClick="btn_search_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <asp:Label ID="lblmassage" runat="server"></asp:Label>

                            <%--gridview--%>
                            <div class=" table table-responsive no-pagination">
                                <asp:GridView AutoGenerateColumns="false" HeaderStyle-BackColor="#7539FF" CssClass="col-md-12 p-md-5 mt-5 table table-hover" ID="gridviewtable" runat="server" OnRowEditing="gridviewtable_RowEditing" OnRowDeleting="gridviewtable_RowDeleting" PageSize="6" AllowSorting="true" AllowPaging="true" OnPageIndexChanging="gridviewtable_PageIndexChanging">
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
                                                <asp:Label ID="lblid" CssClass="p-2" runat="server" Text='<%#Bind("id")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Unit code" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblunitcode" CssClass="p-2" runat="server" Text='<%#Bind("unitcode")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Customer Code" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcustomercode" CssClass="p-2" runat="server" Text='<%#Bind("custcode")%>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Customer Name" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcustomername" CssClass="p-2" runat="server" Text='<%#Bind("custname") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Country" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcountry" CssClass="p-2" runat="server" Text='<%#Bind("country") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="State" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblstate" CssClass="p-2" runat="server" Text='<%#Bind("state") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="City" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcity" CssClass="p-2" runat="server" Text='<%#Bind("city") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="GST NO" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblgst" CssClass="p-2" runat="server" Text='<%#Bind("gstno") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="PAN NO " HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblpanno" CssClass="p-2" runat="server" Text='<%#Bind("pan") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Contact NO" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcontactno" CssClass="p-2" runat="server" Text='<%#Bind("contactno") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Bank Account No" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblBankAccountno" CssClass="p-2" runat="server" Text='<%#Bind("bankno") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="IFSC Code" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIFSC" CssClass="p-2" runat="server" Text='<%#Bind("ifsccode") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Address" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lbladdress" CssClass="p-2" runat="server" Text='<%#Bind("Address") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Created By" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreatedby" CssClass="p-2" runat="server" Text='<%#Bind("createdby") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Created Date" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblcreateddate" CssClass="p-2" runat="server" Text='<%#Bind("createddate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Updated By" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblupdateby" CssClass="p-2" runat="server" Text='<%#Bind("updatedby") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="updated Date" HeaderStyle-ForeColor="White">
                                            <ItemTemplate>
                                                <asp:Label ID="lblupdateddate" CssClass="p-2" runat="server" Text='<%#Bind("updateddate") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>



                                    </Columns>
                                    <PagerStyle HorizontalAlign="left" CssClass="pagination-ys" />
                                </asp:GridView>
                            </div>
                            <%--gridview--%>

                            <%--  </form>--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


</asp:Content>
