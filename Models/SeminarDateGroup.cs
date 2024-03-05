using Dtm.Framework.ClientSites.Web.Models;
using System;
using System.Collections.Generic;

namespace TAXLIENCODE.Models
{
    public class SeminarDateGroup
    {
        public DateTime CommonDate { get; set; }
        public List<SeminarDateViewData> SeminarGroup { get; set; }
    }
}