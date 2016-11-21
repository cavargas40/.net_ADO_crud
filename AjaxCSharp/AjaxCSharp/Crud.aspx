<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Crud.aspx.cs" Inherits="AjaxCSharp.Crud" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {

            //Manejador de insercion y actualizacion de una nueva Persona.
            $("input[id*='txtNombre'], input[id*='txtApellido'], input[id*='txtDocumento'], input[id*='txtEmail']").on("blur", function () {
                var row = $(this).closest("tr");
                $.Crud(row, "Guardar");
            });

            //Manejador del borrado de una persona
            $("input[id*='ChckEliminar']").on("click", function () {
                if (!confirm("Esta seguro que desea eliminar el usuario?")) {
                    $(this).attr("checked", false);
                    return;
                }
                var row = $(this).closest("tr");
                $.Crud(row, "Borrar");
            });
        });

        $.Crud = function (row, method) {

            var myObject = {};

            myObject.id_persona = row.find("#HdnidPersona").val();
            myObject.Nombres = row.find("#txtNombre").val();
            myObject.Apellidos = row.find("#txtApellido").val();
            myObject.Documento = row.find("#txtDocumento").val();
            myObject.email = row.find("#txtEmail").val();

            //Validacion de todos los campos llenos
            if ($.trim(myObject.id_persona) == "" ||
                $.trim(myObject.Nombres) == "" ||
                $.trim(myObject.Apellidos) == "" ||
                $.trim(myObject.Documento) == "" ||
                $.trim(myObject.email) == "") {
                return false;
            }

            var arrayParams = {};

            arrayParams.myObject = myObject;

            //return false;

            $.ajax({
                type: "POST",
                url: "Crud.aspx/" + method,
                data: JSON.stringify(arrayParams),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    if (response.d.Message != null) {
                        alert(response.d.Message);
                        return false;
                    }
                    if (response.d.Operacion == "Saved") {
                        //INSERT
                        if(myObject.id_persona < 0)
                        {
                            var rowclone = row.clone();
                            rowclone.find("#HdnidPersona").val(response.d.objeto.id_persona);
                            rowclone.find("#ChckEliminar").show();
                            $("#TableRepeater").append(rowclone);                            
                            row.find("#txtNombre").val("");
                            row.find("#txtApellido").val("");
                            row.find("#txtDocumento").val("");
                            row.find("#txtEmail").val("");
                        }
                        //UPDATE
                        else {

                        }
                    }
                    if (response.d.Operacion == "Deleted") {
                        row.remove();
                    }

                    //console.log(response.d);
                },
                failure: function (response) {
                    if (response.d.Message != null) {
                        alert(response.d.Message);
                        return false;
                    }
                }
            });

        }
    </script>
    <style>
        input {
            width: 90px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>CRUD de una sola pagina</h1>
            <!-- Begin Encabezado -->
            <table>
                <tr>
                    <td>
                        <div style="width: 100px;">
                            Nombre
                        </div>
                    </td>
                    <td>
                        <div style="width: 100px;">
                            Apellido
                        </div>
                    </td>
                    <td>
                        <div style="width: 100px;">
                            Documento
                        </div>
                    </td>
                    <td>
                        <div style="width: 100px;">
                            Email
                        </div>
                    </td>
                    <td>
                        <div style="width: 30px;">
                            [x]
                        </div>
                    </td>
                </tr>
            </table>
            <!-- End Encabezado -->
            <!-- Begin Repeater -->
            <div style="max-height: 400px; width: 700px;">
                <table id="TableRepeater">
                    <tr>
                        <td>
                            <div style="width: 100px;">
                            </div>
                        </td>
                        <td>
                            <div style="width: 100px;">
                            </div>
                        </td>
                        <td>
                            <div style="width: 100px;">
                            </div>
                        </td>
                        <td>
                            <div style="width: 100px;">
                            </div>
                        </td>
                        <td>
                            <div style="width: 30px;">
                            </div>
                        </td>

                    </tr>
                    <asp:Repeater runat="server" ID="RptPersonas">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <input type="hidden" id="HdnidPersona" value="<%# Eval("id_persona") %>" />
                                    <input type="text" id="txtNombre" value="<%# Eval("Nombres") %>" />
                                </td>
                                <td>
                                    <input type="text" id="txtApellido" value="<%# Eval("Apellidos") %>" />
                                </td>
                                <td>
                                    <input type="text" id="txtDocumento" value="<%# Eval("Documento") %>" />
                                </td>
                                <td>
                                    <input type="text" id="txtEmail" value="<%# Eval("email") %>" />
                                </td>
                                <td>
                                    <div style="width: 30px; text-align: center">
                                        <input type="checkbox" id="ChckEliminar" />
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
            <!-- End Repeater -->

            <table id="TableNew">
                <tr>
                    <td>
                        <div style="width: 100px;">
                        </div>
                    </td>
                    <td>
                        <div style="width: 100px;">
                        </div>
                    </td>
                    <td>
                        <div style="width: 100px;">
                        </div>
                    </td>
                    <td>
                        <div style="width: 100px;">
                        </div>
                    </td>
                    <td>
                        <div style="width: 30px;">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="hidden" id="HdnidPersona" value="-1" />
                        <input type="text" id="txtNombre" value="" />
                    </td>
                    <td>
                        <input type="text" id="txtApellido" value="" />
                    </td>
                    <td>
                        <input type="text" id="txtDocumento" value="" />
                    </td>
                    <td>
                        <input type="text" id="txtEmail" value="" />
                    </td>
                    <td style="text-align: center">
                        <input type="checkbox" id="ChckEliminar" style="display: none" />
                    </td>
                </tr>

            </table>

        </div>

        <h1>Cargar Dropdown List con Personas.
        </h1>
        <asp:DropDownList runat="server" ID="DdlPersonas" AppendDataBoundItems="true">
            <asp:ListItem Text="Seleccione" />
        </asp:DropDownList>
    </form>
</body>
</html>
