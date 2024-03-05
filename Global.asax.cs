using Dtm.Framework.ClientSites.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace TAXLIENCODE
{
    public class MvcApplication : ClientSiteApplication
    {
        protected override void ConfigureAdditionalRoutes(RouteCollection routes)
        {
            routes.MapRoute("Privacy", "GetPrivacy",
                new { controller = "IframePage", action = "RenderPage", pageCode = "none", pc = "PrivacyPolicy" }
            );

            routes.MapRoute("Terms", "GetTerms",
                new { controller = "IframePage", action = "RenderPage", pageCode = "none", pc = "Terms" }
            );

            base.ConfigureAdditionalRoutes(routes);
        }
    }
}