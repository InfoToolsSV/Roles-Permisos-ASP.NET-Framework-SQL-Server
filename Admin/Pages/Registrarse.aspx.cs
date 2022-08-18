using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin.Pages
{
    public partial class Registrarse : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.AppendHeader("Cache-Control", "no-store");
        }

        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conexion"].ToString());
        string Patron = "InfoToolsSV";

        void Limpiar()
        {
            nombre.Text = string.Empty;
            edad.Text = string.Empty;
            usuario.Text = string.Empty;
            clave.Text = string.Empty;
        }

        protected void Registrar_Click(object sender, EventArgs e)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("sp_registrar", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add("@Nombre", System.Data.SqlDbType.VarChar).Value = nombre.Text;
                cmd.Parameters.Add("@Edad", System.Data.SqlDbType.Int).Value = edad.Text;
                cmd.Parameters.Add("@Usuario", System.Data.SqlDbType.VarChar).Value = usuario.Text;
                cmd.Parameters.Add("@Clave", System.Data.SqlDbType.VarChar).Value = clave.Text;
                cmd.Parameters.Add("@Patron", System.Data.SqlDbType.VarChar).Value = Patron;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                Limpiar();
                Response.Redirect("Login.aspx");
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}