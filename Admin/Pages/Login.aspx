<%@ Page Title="" Language="C#" MasterPageFile="~/Pages/MP.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Admin.Pages.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Iniciando
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">
    <div class="container box">
        <h1 class="title">Iniciar sesión</h1>

        <div class="field">
            <label class="label">Usuario</label>
            <div class="control">
                <asp:Textbox runat="server" id="usuario" class="input" type="text" placeholder="ej. Joe_Doe12"></asp:Textbox>
            </div>
        </div>

        <div class="field">
            <label class="label">Clave</label>
            <div class="control">
                <asp:Textbox runat="server" id="clave" class="input" type="password" placeholder="ej. Joe_Doe12"></asp:Textbox>
            </div>
        </div>

        <asp:Button runat="server" id="ingresar" class="button is-primary" text="Ingresar" OnClick="ingresar_Click"/>
    </div>
</asp:Content>
