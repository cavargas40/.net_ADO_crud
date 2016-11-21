using AjaxCSharp.ADO;
using AjaxCSharp.Modelo.ClassBase.DBMapping;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AjaxCSharp.Modelo.Portal.Class
{
    public class cPersonas
    {
        BDConnection connection = new BDConnection();

        /// <summary>
        /// Metodo encargado de ingresar y actualizar una persona
        /// </summary>
        /// <param name="per"></param>
        /// <returns></returns>
        public Respuesta<Personas> addPersona(Personas per) 
        {
            Respuesta<Personas> respon = new Respuesta<Personas>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connection.getConnectionString()))
                {
                    ////| OP | 0 - insercion / actualizacion |  1 - borrado | 2 - seleccion |
                    SqlParameter _Op = new SqlParameter("@Op", SqlDbType.Int);
                    _Op.Value = "0";
                    SqlParameter _id_persona = new SqlParameter("@id_persona", SqlDbType.Int);
                    _id_persona.Value = per.id_persona;
                    SqlParameter _Nombres = new SqlParameter("Nombres", SqlDbType.NVarChar);
                    _Nombres.Value = per.Nombres;
                    SqlParameter _Apellidos = new SqlParameter("Apellidos", SqlDbType.NVarChar);
                    _Apellidos.Value = per.Apellidos;
                    SqlParameter _Documento = new SqlParameter("Documento", SqlDbType.NVarChar);
                    _Documento.Value = per.Documento;
                    SqlParameter _email = new SqlParameter("email", SqlDbType.NVarChar);
                    _email.Value = per.email;
                    
                    SqlParameter[] parametros = { _Op, _id_persona, _Nombres, _Apellidos, _Documento, _email };

                    DataTable dtTable = connection.correrProcAlmac(parametros, conn, "CV_CrudPersonas");
                    respon.Operacion = "Saved";
                    respon.objeto = dtTable.AsEnumerable().Select(row => new Personas()
                    {
                        id_persona = row["id_persona"].ToString(),
                        Nombres= row["Nombres"].ToString(),
                        Apellidos = row["Apellidos"].ToString(),
                        Documento = row["Documento"].ToString(),
                        email = row["email"].ToString()
                    }).FirstOrDefault();

                    return respon;
                   } 
            }
            catch (Exception ex)
            {                
                respon.Message = ex.Message;
                return respon;
            }
        }

        /// <summary>
        /// Metodo encargado de eliminar una persona
        /// </summary>
        /// <param name="per"></param>
        /// <returns></returns>
        public Respuesta<Personas> deletePersona(Personas per)
        {
            Respuesta<Personas> respon = new Respuesta<Personas>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connection.getConnectionString()))
                {
                    ////| OP | 0 - insercion / actualizacion |  1 - borrado | 2 - seleccion |
                    SqlParameter _Op = new SqlParameter("@Op", SqlDbType.Int);
                    _Op.Value = "1";
                    SqlParameter _id_persona = new SqlParameter("@id_persona", SqlDbType.Int);
                    _id_persona.Value = per.id_persona;

                    SqlParameter[] parametros = { _Op, _id_persona };

                    DataTable dtTable = connection.correrProcAlmac(parametros, conn, "CV_CrudPersonas");

                    respon.Operacion = "Deleted";
                    respon.objeto = dtTable.AsEnumerable().Select(row => new Personas()
                    {
                        id_persona = row["id_persona"].ToString(),
                        Nombres = row["Nombres"].ToString(),
                        Apellidos = row["Apellidos"].ToString(),
                        Documento = row["Documento"].ToString(),
                        email = row["email"].ToString()
                    }).FirstOrDefault();

                    return respon;
                }
            }
            catch (Exception ex)
            {
                respon.Message = ex.Message;
                return respon;
            }
        }

        /// <summary>
        /// Metodo encargado de obtener todos los usuarios
        /// </summary>
        /// <param name="per"></param>
        /// <returns></returns>
        public Respuesta<Personas> getPersonas(Personas per)
        {
            Respuesta<Personas> respon = new Respuesta<Personas>();
            try
            {
                using (SqlConnection conn = new SqlConnection(connection.getConnectionString()))
                {
                    ////| OP | 0 - insercion / actualizacion |  1 - borrado | 2 - seleccion |
                    SqlParameter _Op = new SqlParameter("@Op", SqlDbType.Int);
                    _Op.Value = "2";

                    SqlParameter[] parametros = { _Op };

                    DataTable dtTable = connection.correrProcAlmac(parametros, conn, "CV_CrudPersonas");

                    respon.lista = dtTable.AsEnumerable().Select(row => new Personas()
                    {
                        id_persona = row["id_persona"].ToString(),
                        Nombres = row["Nombres"].ToString(),
                        Apellidos = row["Apellidos"].ToString(),
                        Documento = row["Documento"].ToString(),
                        email = row["email"].ToString()
                    }).ToList();

                    return respon;
                }
            }
            catch (Exception ex)
            {
                respon.Message = ex.Message;
                return respon;
            }
        }
    }
}