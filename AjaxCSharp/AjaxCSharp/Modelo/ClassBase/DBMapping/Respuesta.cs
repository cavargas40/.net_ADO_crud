using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace AjaxCSharp.Modelo.ClassBase.DBMapping
{
    /// <summary>
    /// Clase de Respuesta de base de datos ADO!
    /// </summary>
    public class Respuesta<T>
    {
        public string Message { get; set;  }
        public string Operacion { get; set; }
        public DataTable dTable { get; set; }
        public DataSet dSet { get; set; }
        public List<T> lista { get; set; }
        public T objeto { get; set; }

    }    
}