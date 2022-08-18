using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Admin.Pages
{
    public partial class Index : System.Web.UI.Page
    {
        int id_rol = 0;
        SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conexion"].ToString());

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.AppendHeader("Cache-Control", "no-store");

            if (!IsPostBack && Session["usuario"] != null)
            {
                id_rol = Convert.ToInt32(Session["id_rol"].ToString());
                Datos();
                Permisos(id_rol);
            }
        }


        void Datos()
        {
            try
            {
                SqlCommand cmd = new SqlCommand("sp_datos", con);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                con.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                datos.DataSource = dt;
                datos.DataBind();
                con.Close();

            }
            catch (Exception)
            {

                throw;
            }
        }


        void Permisos(int id_rol)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("sp_permisos", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add("@Id_rol", SqlDbType.Int).Value = id_rol;
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                bool Create, Read, Update, Delete;
                while (reader.Read())
                {
                    foreach (GridViewRow fila in datos.Rows)
                    {

                        switch (reader[0].ToString())
                        {
                            case "Create":
                                Create = Convert.ToBoolean(reader[1].ToString());

                                if (Create)
                                    btncreate.Visible = true;
                                else
                                    btncreate.Visible = false;

                                break;
                            case "Read":
                                Read = Convert.ToBoolean(reader[1].ToString());
                                Button btn1 = fila.FindControl("btnread") as Button;
                                if (Read)
                                {
                                    btn1.Visible = true;
                                    datos.Visible = true;
                                }
                                else
                                {
                                    btn1.Visible = false;
                                    datos.Visible = false;
                                }

                                break;
                            case "Update":
                                Update = Convert.ToBoolean(reader[1].ToString());
                                Button btn2 = fila.FindControl("btnupdate") as Button;

                                if (Update)
                                    btn2.Visible = true;
                                else
                                    btn2.Visible = false;

                                break;
                            case "Delete":
                                Delete = Convert.ToBoolean(reader[1].ToString());
                                Button btn3 = fila.FindControl("btndelete") as Button;

                                if (Delete)
                                    btn3.Visible = true;
                                else
                                    btn3.Visible = false;

                                break;
                        }
                    }
                }


                con.Close();
                reader.Close();
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}