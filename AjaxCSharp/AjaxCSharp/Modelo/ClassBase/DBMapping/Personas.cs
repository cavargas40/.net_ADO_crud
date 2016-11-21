using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AjaxCSharp.Modelo.ClassBase.DBMapping
{
    public class Personas
    {
        public string id_persona { get; set; }
        public string Nombres { get; set; }
        public string Apellidos { get; set; }
        public string Documento { get; set; }
        public string email { get; set; }
    }
}