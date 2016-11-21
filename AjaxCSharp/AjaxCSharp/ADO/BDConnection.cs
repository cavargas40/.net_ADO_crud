using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace AjaxCSharp.ADO
{
    public class BDConnection
    {
        /// <summary>
        /// Obtiene la cadena de conexion a la bd
        /// </summary>        
        /// <returns>string:Cadena Conexion</returns>
        public string getConnectionString()
        {
            return System.Configuration.ConfigurationManager.ConnectionStrings["Conexion"].ConnectionString;
            //return System.Configuration.ConfigurationSettings.AppSettings["DataBase"].ToString();
            //return System.Configuration.con
        }

        /// <summary>
        /// Abre la conexcion a la Base de Datos
        /// </summary>
        /// <param name="conn"></param>
        public void AbrirConexion(SqlConnection conn)
        {
            try
            {
                conn = new SqlConnection(getConnectionString());
                conn.Open();
            }
            catch (Exception ex)
            {
                string sError = ex.Message;
            }
        }

        /// <summary>
        /// Cierra la Conexion actual
        /// </summary>
        /// <param name="conn"></param>
        public void CerrarConexion(SqlConnection conn)
        {
            try
            {
                conn.Close();
            }
            catch (Exception ex)
            {
                string sError = ex.Message;
            }
        }

        /// <summary>
        /// Ejecuta un Procedimiento Almacenado
        /// </summary>
        /// <param name="parametroSql"></param>
        /// <param name="conn"></param>
        /// <param name="NomProc"></param>
        /// <returns></returns>
        public DataTable correrProcAlmac(SqlParameter[] parametroSql, SqlConnection conn, string NomProc)
        {
            DataTable datatable = new DataTable("EcoId");
            SqlDataAdapter adaptadorSql = new SqlDataAdapter();
            try
            {
                SqlCommand cmd = new SqlCommand(NomProc, conn);
                cmd.CommandType = CommandType.StoredProcedure;
                if (parametroSql.Length > 0)
                {
                    cmd.Parameters.Clear();
                    cmd.Parameters.AddRange(parametroSql);
                }
                adaptadorSql.SelectCommand = cmd;                
                adaptadorSql.Fill(datatable);
            }
            catch (Exception ex)
            {
                string sError = ex.Message;
            }
            finally
            {
                CerrarConexion(conn);
            }
            return datatable;
        }


        ///// <summary>
        ///// Ejecuta un Procedimiento Almacenado
        ///// </summary>
        ///// <param name="parametroSql"></param>
        ///// <param name="conn"></param>
        ///// <param name="NomProc"></param>
        ///// <returns></returns>
        //public DataSet correrProcAlmac(SqlParameter[] parametroSql, SqlConnection conn, string NomProc)
        //{
        //    //.net      |       sql
        //    //DataRow   |      fila
        //    //DataTable |      tabla
        //    //DataSet   |      base datos
        //    DataSet dataset = new DataSet("EcoId");
        //    SqlDataAdapter adaptadorSql = new SqlDataAdapter();
        //    try
        //    {
        //        SqlCommand cmd = new SqlCommand(NomProc, conn);
        //        cmd.CommandType = CommandType.StoredProcedure;
        //        if (parametroSql.Length > 0)
        //        {
        //            cmd.Parameters.Clear();
        //            cmd.Parameters.AddRange(parametroSql);
        //        }
        //        adaptadorSql.SelectCommand = cmd;
        //        adaptadorSql.Fill(dataset);
        //    }
        //    catch (Exception ex)
        //    {
        //        string sError = ex.Message;
        //    }
        //    finally
        //    {
        //        CerrarConexion(conn);
        //    }
        //    return dataset;
        //}

    }
}