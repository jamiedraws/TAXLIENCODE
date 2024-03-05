using Dtm.Framework.ClientSites.Web;

namespace TAXLIENCODE.Navigation
{
    public class Sitemap
    {
        /// <summary>
        /// Represents a complete, collection of destinations for a single website 
        /// </summary>
        public NavigationList SitemapList;
        /// <summary>
        /// A dictionary of all destinations and landmarks for a single website
        /// </summary>
        public Sitemap()
        {
            SitemapList = new NavigationList();

            // Home
            SitemapList.AddItem(new NavigationItem
            {
                Id = "home",
                Name = "Home",
                Page = "Index",
                Hash = "#main"
            });

            // FAQ
            SitemapList.AddItem(new NavigationItem
            {
                Id = "faq",
                Name = "FAQs",
                Page = "Index",
                Hash = "#faq",
                ApplyHash = true
            });

            // Earnings & Income Disclosure
            SitemapList.AddItem(new NavigationItem
            {
                Id = "earnings",
                Name = "Earnings & Income Disclosure",
                Page = "EarningsIncomeDisclosure",
                Hash = "#main"
            });



            // Privacy Policy
            SitemapList.AddItem(new NavigationItem
            {
                Id = "privacy",
                Name = "Privacy Policy",
                Page = "Privacy-Policy",
                Hash = "#main",
                Route = string.Format("/GetPrivacy?cver={0}", DtmContext.VersionId),
                IsModalDialog = true
            });

            // About
            SitemapList.AddItem(new NavigationItem
            {
                Id = "about",
                Name = "About Brian Petersen",
                Page = "Index",
                Hash = "#about",
                ApplyHash = true
            });

            // What you will learn
            SitemapList.AddItem(new NavigationItem
            {
                Id = "learn",
                Name = "What You Will Learn",
                Page = "Index",
                Hash = "#learn",
                ApplyHash = true
            });

            // Testimonials
            SitemapList.AddItem(new NavigationItem
            {
                Id = "testimonials",
                Name = "Testimonials",
                Page = "Index",
                Hash = "#testimonials",
                ApplyHash = true
            });

            // Terms
            SitemapList.AddItem(new NavigationItem
            {
                Id = "terms",
                Name = "Terms & Conditions",
                Page = "Terms",
                Route = string.Format("/GetTerms?cver={0}", DtmContext.VersionId),
                IsModalDialog = true,
                Hash = "#main"
            });

            // Cookie Use Policy
            SitemapList.AddItem(new NavigationItem
            {
                Id = "cookie",
                Name = "Cookie Use Policy",
                Page = "CookieUsePolicy",
                Hash = "#main"
            });

            // Order Now
            SitemapList.AddItem(new NavigationItem
            {
                Id = "order-now",
                Name = "Register Now!",
                Page = "Index",
                Hash = "#register",
                ApplyHash = true
            });
        }
    }
}