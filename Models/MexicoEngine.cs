using System;
using System.Text.RegularExpressions;
using Dtm.Framework.ClientSites.Web;
using System.Web.Mvc;
using TAXLIENCODE.Models.Interfaces;
using System.Collections.Specialized;
using Dtm.Framework.Services.DtmApi;

namespace TAXLIENCODE.Models
{
    public class MexicoEngine : PageHandler, ILocationEngine
    {
        public ModelStateDictionary GetModelErrors(ModelStateDictionary modelState, NameValueCollection form, SafeDictionary postData)
        {
            return modelState;
        }
    }
}