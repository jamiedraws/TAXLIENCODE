using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.ClientSites.Web.Controllers;
using Dtm.Framework.Models.Ecommerce;
using System;
using System.Linq;
using System.Web.Mvc;

namespace TAXLIENCODE.Controllers
{
    public class IframePageController : ClientSiteController<ClientSiteViewData>
    {
        public ActionResult RenderPage(string pc)
        {
            SetOfferVersion();
            SetContextByPageCode(pc);

            return View("IframePage", Model);
        }

        /// <summary>
        /// Sets the offer version context on the DtmContext object
        /// </summary>
        private void SetOfferVersion()
        {
            Guid covid = Guid.TryParse(Request["covid"], out covid) ? covid : Guid.Empty;
            if (covid != Guid.Empty && DtmContext.CampaignOfferVersions.Any(cov => cov.OfferVersionId == covid))
            {
                var offerVersion = DtmContext.CampaignOfferVersions.First(cov => cov.OfferVersionId == covid);
                DtmContext.OfferCode = offerVersion.OfferCode;
                DtmContext.Version = offerVersion.VersionNumber;
            }
        }

        /// <summary>
        /// Assigns the campaign page based on the <c>pageCode</c> parameter.
        /// </summary>
        /// <param name="pageCode"></param>
        private void SetContextByPageCode(string pageCode)
        {
            PageDefinition campaignPage = DtmContext.CampaignPages.FirstOrDefault(cp => cp.PageCode == pageCode);

            if (campaignPage != null)
            {
                DtmContext.Page = campaignPage;
                DtmContext.PageCode = campaignPage.PageCode;
            }

            MapModelPageInformation();
        }
    }
}