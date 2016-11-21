using AjaxCSharp.Modelo.ClassBase.DBMapping;
using AjaxCSharp.Modelo.Portal.Class;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AjaxCSharp
{
    public partial class Crud : System.Web.UI.Page
    {
        #region Pageload & Constants
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                try 
	            {
                    List<Personas> perList = new cPersonas().getPersonas(new Personas()).lista;

                    DdlPersonas.DataSource = perList;
                    DdlPersonas.DataTextField = "Nombres";
                    DdlPersonas.DataValueField = "id_persona";
                    DdlPersonas.DataBind();

                    RptPersonas.DataSource = perList;
                    RptPersonas.DataBind();              
	            }
	            catch (Exception)
	            {
		
		            throw;
	            }

            }
        }        
        #endregion

        #region Events
        
        #endregion

        #region WebMethod y Methods
        [System.Web.Services.WebMethod]
        public static object Guardar(Personas myObject)
        {
            return new cPersonas().addPersona(myObject);
        }

        [System.Web.Services.WebMethod]
        public static object Borrar(Personas myObject)
        {
            return new cPersonas().deletePersona(myObject);
        }
        #endregion

    }

}