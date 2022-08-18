using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin.Pages
{
    public partial class MP : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.AppendHeader("Cache-Control", "no-store");

            if (Session["usuario"]!=null)
            {
                divuser.Visible = true;
                divbuttons.Visible = false;
                lblusuario.Text = Session["usuario"].ToString();
            }
            else
            {
                divuser.Visible = false;
                divbuttons.Visible = true;
                lblusuario.Text = string.Empty;
            }
        }

        protected void Unnamed_Click(object sender, EventArgs e)
        {
            Response.Redirect("Registrarse.aspx");
        }

        protected void Unnamed_Click1(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void Unnamed_Click2(object sender, EventArgs e)
        {
            Session["usuario"] = null;
            Session["Id_rol"] = null;
            Response.Redirect("Login.aspx");
            HttpContext.Current.Session.Abandon();
        }
    }
}