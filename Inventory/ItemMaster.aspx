<%@ Page Title="" Language="C#" MasterPageFile="~/InventoryMas.Master" AutoEventWireup="true" Inherits="Inventory.WebForm4" CodeBehind="ItemMaster.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ScriptManager ID="scriptmanager1" runat="server">
    </asp:ScriptManager>
    <div class="page-wrapper">
        <div class="content container-fluid">
            <div class="card mb-0">
                <div class="card-body">
                    <div class="page-header">
                        <div class="content-page-header">
                            <h5>Add Items</h5>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group-item">
                                <h5 class="form-title">Basic Details</h5>
                                <asp:Label runat="server" Style="display: none;" ID="iddetail" Text=""></asp:Label>
                                <div class="row">
                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <div class="input-block mb-3">
                                            <label>Unit Code<span class="text-danger">  *</span></label>
                                            <div class="row">
                                                <asp:UpdatePanel ID="updatepnl" runat="server">
                                                    <contenttemplate>

                                                        <asp:DropDownList CssClass="btn btn-white-outline dropdown-toggle fas fa-angle-down w-auto me-3" AutoPostBack="true" ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged1" Style="font-family: 'Arial', sans-serif;"></asp:DropDownList>
                                                        <asp:Label ID="label1" Text="" runat="server"></asp:Label>
                                                    </contenttemplate>
                                                    <triggers>
                                                        <asp:PostBackTrigger ControlID="DropDownList1" />
                                                    </triggers>
                                                </asp:UpdatePanel>

                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <div class="input-block mb-3">
                                            <label>Item Name <span class="text-danger">*</span></label>
                                            <asp:TextBox CssClass="form-control w-auto" placeholder="Enter Item Name" runat="server" ID="txtitemname"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-12">

                                        <div class="input-block mb-3 add-products">
                                            <label>Item Category</label>
                                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                <contenttemplate>
                                                    <asp:DropDownList CssClass="btn btn-white-outline dropdown-toggle fas fa-angle-down w-auto me-3" AutoPostBack="true" ID="DropDownList2" runat="server" OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged" Style="font-family: 'Arial', sans-serif;"></asp:DropDownList>
                                                    <asp:Label ID="label2" Text="" runat="server"></asp:Label>
                                                </contenttemplate>
                                                <triggers>
                                                    <asp:AsyncPostBackTrigger ControlID="DropDownList2" />

                                                </triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <div class="input-block mb-3">
                                            <label>Model</label>
                                            <div class="row">
                                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                    <contenttemplate>
                                                        <asp:DropDownList CssClass="btn btn-white-outline dropdown-toggle fas fa-angle-down w-auto me-3" AutoPostBack="true" ID="DropDownList3" runat="server" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" Style="font-family: 'Arial', sans-serif;"></asp:DropDownList>
                                                        <asp:Label ID="label3" Text="" runat="server"></asp:Label>
                                            </div>
                                            </ContentTemplate>
                                                    <triggers>
                                                        <asp:AsyncPostBackTrigger ControlID="DropDownList2" />
                                                    </triggers>
                                            </asp:UpdatePanel>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <div class="input-block mb-3">
                                            <label>Qty</label>
                                            <asp:TextBox runat="server" ID="txtqty" type="number" CssClass="form-control w-auto" placeholder="Enter Quantity" onkeypress="return onlyNumbers(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <div class="input-block mb-3">
                                            <label>U/M</label>
                                            <div class="row">
                                                <asp:DropDownList ID="dropdownum" CssClass="btn btn-white-outline dropdown-toggle w-auto fas fa-angle-down me-3" runat="server" Style="font-family: 'Arial', sans-serif;">

                                                    <asp:ListItem Value="">Select U/M</asp:ListItem>

                                                    <asp:ListItem>Kg</asp:ListItem>

                                                    <asp:ListItem>gm</asp:ListItem>

                                                    <asp:ListItem>pkt</asp:ListItem>

                                                    <asp:ListItem>l</asp:ListItem>

                                                    <asp:ListItem>boxes</asp:ListItem>

                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="col-12">
                                        <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                            <contenttemplate>
                                                <div class="input-block mb-3">
                                                    <label>Color</label>
                                                    <div class="row">
                                                        <asp:DropDownList CssClass="btn btn-white-outline dropdown-toggle fas fa-angle-down w-auto me-3" AutoPostBack="true" ID="DropDowncolor" runat="server" OnSelectedIndexChanged="DropDowncolor_SelectedIndexChanged" Style="font-family: 'Arial', sans-serif;"></asp:DropDownList>
                                                        <asp:Label ID="label4" Text="" runat="server"></asp:Label>
                                                    </div>

                                                </div>
                                            </contenttemplate>
                                            <triggers>
                                                <asp:AsyncPostBackTrigger ControlID="DropDowncolor" />
                                            </triggers>
                                        </asp:UpdatePanel>

                                        <div class="input-block mb-3">
                                            <label>Measurement Unit</label>
                                            <div class="row">
                                                <asp:DropDownList ID="DropDownmeasure" CssClass="btn btn-white-outline dropdown-toggle w-auto fas fa-angle-down me-3" runat="server" Style="font-family: 'Arial', sans-serif;">

                                                    <asp:ListItem Value="">Select Unit</asp:ListItem>

                                                    <asp:ListItem>m</asp:ListItem>

                                                    <asp:ListItem>cm</asp:ListItem>

                                                    <asp:ListItem>inch</asp:ListItem>

                                                    <asp:ListItem>mm</asp:ListItem>

                                                </asp:DropDownList>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <div class="input-block mb-3">
                                            <label>Length</label>
                                            <asp:TextBox type="number" CssClass="form-control w-auto" placeholder="Enter Length" ID="txtlegnth" runat="server" onkeypress="return onlyNumbers(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <div class="input-block mb-3">
                                            <label>Breadth</label>
                                            <asp:TextBox type="number" CssClass="form-control w-auto" placeholder="Enter Breadth" ID="txtbreadth" runat="server" onkeypress="return onlyNumbers(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <div class="input-block mb-3">
                                            <label>Height</label>
                                            <asp:TextBox type="number" CssClass="form-control w-auto" placeholder="Enter Height" ID="txtheight" runat="server" onkeypress="return onlyNumbers(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-lg-4 col-md-6 col-sm-12">
                                        <div class="input-block mb-3 add-products">
                                            <label>Box Quantity</label>
                                            <asp:TextBox type="number" CssClass="form-control w-auto" placeholder="Enter Box Quantity" ID="txtboxqty" runat="server" onkeypress="return onlyNumbers(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group-item">
                                    <div class="row">
                                        <div class="col-xl-6 col-lg-6 col-md-6 col-12 description-box">
                                            <div class="input-block mb-3" id="summernote_container">
                                                <label class="form-control-label">Item Descriptions</label>
                                                <asp:TextBox class="summernote form-control" placeholder="Type your message" TextMode="MultiLine" MaxLength="250" runat="server" ID="txtboxmssg"></asp:TextBox>
                                            </div>
                                        </div>
                                        <%--<div class="col-xl-6 col-lg-6 col-md-6 col-12">
                                                <div class="input-block mb-3">
                                                    <label>Product Image</label>
                                                    <div class="input-block mb-3 service-upload mb-0">
                                                        <span>
                                                            <img src="assets/img/icons/drop-icon.svg" alt="upload"></span>
                                                        <h6 class="drop-browse align-center">Drop your files here or<span class="text-primary ms-1">browse</span>
                                                        </h6>
                                                        <p class="text-muted">Maximum size: 50MB</p>
                                                        <input type="file" multiple="" id="image_sign">
                                                        <div id="frames"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-table">
                            <asp:Button ID="clearbtn" CssClass="btn btn-primary me-1" runat="server" Style="position: relative; float: right;" Text="Clear" OnClick="clear_Click" />
                            <asp:Button ID="submitbtn" CssClass="btn btn-primary" Style="position: relative; float: right; margin-right: 63px;" runat="server" Text="Save" OnClick="submitbtn_Click" />
                            <br />
                            <br />
                            <div class="btn-group dropdown-action mail-search">
                                <asp:TextBox placholder="Search Messages" CssClass="form-control" runat="server" ID="searchid" OnTextChanged="search_TextChanged"></asp:TextBox>
                            </div>

                            <div class="card-body">
                                <asp:Label ID="lablemssg" Font-Bold="true" runat="server"></asp:Label>
                                <div class="table-responsive">
                                    <div class="table table-center table-hover datatable table-sm">
                                        <asp:GridView ID="GridView" CssClass="gridviewpager" runat="server" OnPageIndexChanging="gridview_PageIndexChanging" AutoGenerateColumns="false" OnRowEditing="GridView_RowEditing" OnRowCommand="CustomCommand" PageSize="5" AllowPaging="True">
                                            <columns>
                                                <asp:TemplateField>
                                                    <itemtemplate>
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

                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Itemcode">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="griditemCode" Text='<%#Bind("Itemid") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Unitcode">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridunitCode" Text='<%#Bind("Unitcode") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ItemCategCode">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="griditemcategory" Text='<%#Bind("itemcategcode") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="ItemCategName">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridcategoryname" Text='<%#Bind("CategoryName") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="ItemName">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="griditemname" Text='<%#Bind("itemname") %>'></asp:Label>
                                                    </itemtemplate>

                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="ModelCode">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridmodelcode" Text='<%#Bind("modelcode") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Model">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridmodel" Text='<%#Bind("ModelName") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Length">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridlength" Text='<%#Bind("length") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Breadth">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridbreadth" Text='<%#Bind("breadth") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Height">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridheight" Text='<%#Bind("height") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Measureunit">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridmeasureunit" Text='<%#Bind("measureunit") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Colorcode">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridcolorcode" Text='<%#Bind("colorcode") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Color">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridcolorname" Text='<%#Bind("Colorname") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Unitqty">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridunitqty" Text='<%#Bind("unitqty") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="UnitMeasure">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridunitmeasure" Text='<%#Bind("unitmeasure") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="BoxQty">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridboxqty" Text='<%#Bind("boxqty") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Item Description">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="griditemdescription" Text='<%#Bind("itemdescription") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Createdby">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridcreateby" Text='<%#Bind("Createdby") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Createddate">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridcreatedate" Text='<%#Bind("Createddate") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Updatedby">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridupdateby" Text='<%#Bind("Updatedby") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Updateddate">
                                                    <itemtemplate>
                                                        <asp:Label runat="server" ID="gridupdatedate" Text='<%#Bind("Updateddate") %>'></asp:Label>
                                                    </itemtemplate>
                                                </asp:TemplateField>
                                            </columns>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- <!-- Page Wrapper -->
                            <div class="page-wrapper">
                                <div class="content container-fluid">

                                    <!-- Page Header -->
                                    <div class="page-header">
                                        <div class="content-page-header">
                                            <h5>Default Datatable</h5>
                                        </div>
                                    </div>
                                    <!-- /Page Header -->

                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="card">
                                                <div class="card-header card-buttons">
                                                    <h4 class="card-title">Default Datatable</h4>
                                                    <p class="card-text">
                                                        This is the most basic example of the datatables with zero configuration. Use the <code>.datatable</code> class to initialize datatables.
                                                    </p>
                                                </div>
                                                <div class="card-body">

                                                    <div class="table-responsive">
                                                            <table id="ProductsTable" class="display">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Itemid</th>
                                                                        <th>Unitcode</th>
                                                                        <th>itemcategcode</th>                                                                        
                                                                        <th>CategoryName</th>                                                                        
                                                                        <th>itemname</th>                                                                        
                                                                        <th>modelcode</th>                                                                        
                                                                        <th>ModelName</th>                                                                  
                                                                        <th>length</th>
                                                                        <th>breadth</th>
                                                                        <th>height</th>
                                                                        <th>measureunit</th>
                                                                        <th>colorcode</th>
                                                                        <th>Colorname</th>
                                                                        <th>unitqty</th>
                                                                        <th>unitmeasure</th>
                                                                        <th>boxqty</th>
                                                                        <th>itemdescription</th>
                                                                        <th>unitmeasure</th>
                                                                        <th>Createdby</th>
                                                                        <th>Createddate</th>
                                                                        <th>Updatedby</th>
                                                                        <th>Updateddate</th>


                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                </tbody>
                                                            </table>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>--%>
                    </div>
                </div>
            </div>
        </div>
    </div>
    </div>
    <script type="text/javascript">
        function onlyNumbers(evt) {
            var charCode = evt.which ? evt.which : evt.keyCode;
            if (charCode < 48 || charCode > 57) {
                evt.preventDefault();
                return false;
            }
            return true;
        }
        //$(document).ready(function () {
        //    $('#ProductsTable').DataTable({
        //        "ajax": {
        //            "url": "ItemMaster.aspx/GetData", // The WebMethod URL
        //            "type": "POST",
        //            "dataType": "json",
        //            "dataSrc": function (json) {
        //                return json.d; // "d" contains the JSON data returned from the server-side method
        //            }
        //        },
        //        "columns": [
        //            { "data": "Itemid" },
        //            { "data": "Unitcode" },
        //            { "data": "itemcategcode" },
        //            { "data": "CategoryName" },
        //            { "data": "itemname" },
        //            { "data": "modelcode" },
        //            { "data": "ModelName" },
        //            { "data": "length" },
        //            { "data": "breadth" },
        //            { "data": "height" },
        //            { "data": "colorcode" },
        //            { "data": "Colorname" },
        //            { "data": "unitqty" },
        //            { "data": "unitmeasure" },
        //            { "data": "Createdby" },
        //            { "data": "Createddate" },
        //            { "data": "Updatedby" },
        //            { "data": "Updateddate" }
        //        ]
        //    });
        //});
    </script>
    <!-- /Page Wrapper -->
</asp:Content>
