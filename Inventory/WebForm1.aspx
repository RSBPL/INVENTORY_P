<%@ Page Title="" Language="C#" MasterPageFile="~/InventoryMas.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="Inventory.WebForm1" %>

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
        <div class="content container-fluid pb-0">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <h1>Test</h1>
                        <div class=" table table-responsive no-pagination ">
                            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true"></asp:ScriptManager>
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                <ContentTemplate>
                                    <asp:GridView ID="gridviewT" ShowFooter="true" 
                                        OnRowCommand="gridviewT_RowCommand"
                                        OnRowDeleting="gridviewT_RowDeleting" 
                                        OnPreRender="gridviewT_PreRender" 
                                        AutoGenerateColumns="false" runat="server"
                                        ShowHeaderWhenEmpty="true" HeaderStyle-BackColor="#7539FF"
                                        CssClass="col-md-12 p-md-5 table table-hover ">

                                        <EmptyDataTemplate>
                                            <div class="text-center">No vehicles added yet .</div>
                                        </EmptyDataTemplate>

                                        <Columns>
                                            <asp:TemplateField HeaderText="Vehicel Type" HeaderStyle-ForeColor="White">
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

                                            <asp:TemplateField HeaderText="Vehicel No" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblvehicelnos" CssClass="p-2" runat="server" Text='<%#Bind("vehicel_no") %>'></asp:Label>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    <asp:TextBox ID="txtvehicelnos" CssClass=" form-control" runat="server"></asp:TextBox>
                                                </FooterTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Action" HeaderStyle-ForeColor="White">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btn_vehiceldelete" runat="server" CommandName="Delete">
                                                           <i class="fe fe-trash-2 text-danger ms-md-3 fa-lg"></i>
                                                    </asp:LinkButton>
                                                </ItemTemplate>
                                                <FooterTemplate>
                                                    
                                                    <asp:Button ID="btn_addbutton" runat="server" Text="Add" CausesValidation="false" CommandName="Save" />
                                                </FooterTemplate>
                                            </asp:TemplateField>
                                        </Columns>

                                    </asp:GridView>
                                </ContentTemplate>
                            </asp:UpdatePanel>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
