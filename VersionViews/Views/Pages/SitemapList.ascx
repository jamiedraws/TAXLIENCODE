<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="TAXLIENCODE.Navigation" %>
  
<%
    // determines if the render is intended for the footer
    bool renderFooter = false;
    string renderFooterValue = ViewData["renderSitemap"] as string ?? "True";
    Boolean.TryParse(renderFooterValue, out renderFooter);    
    
    // represents all landing pages
    bool isFrontPage = DtmContext.Page.IsStartPageType;
%>

<% if (isFrontPage) { %>
    <%
        // discern between the site map navigation list from the footer navigation list
        string labelCategory = ViewData["labelCategory"] as string ?? "Footer";

        // use the label as a code identifier to discern between the site map links from the footer links
        string labelId = labelCategory.Replace(" ", "-").ToLower();
           
        // render using the CSS `list` component class name. Pancake-stack the list on the site map page
        string navClassList = "list";

        if (!renderFooter)
        {
            navClassList = string.Format("{0} list--stack", navClassList);
        }

        // discern between the site map navigation label from the footer navigation label
        string navLabel = string.Format("{0} Offer information", labelCategory);

        // define attributes for the link
        string navAttributeList = string.Format(@"aria-label=""{0}"" class=""{1}""", navLabel, navClassList); 
    %>
    <nav <%= navAttributeList %>>
    <%
        NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;

        // Manage the link list that will render in both the footer and on the site map page
        List<NavigationItem> entries = sitemap.GetItemsByIdRange(new List<string> { 
            "home",
            "learn",
            "about",
            "testimonials",
            "faq",
            "order-now",
            "privacy",
            "terms",
            "earnings",
            "cookie"
        });

        // if the site map is being rendered, exclude the `sitemap` and `order-now` links from the list
        if (!renderFooter)
        {
            entries = entries.Where(e => e.Id != "sitemap" && e.Id != "order-now").ToList();
        }

        bool enableOrderForm = SettingsManager.ContextSettings["Order.enableOrderForm", true];

        // if the order form is disabled, exclude the `order-now` link from the list
        if (!enableOrderForm)
        {
            entries = entries.Where(e => e.Id != "order-now").ToList();
        }

        foreach (NavigationItem entry in entries)
        {
            // represents the name of the link
            string name = entry.Name;

            // discern each link using a combination of identifiers
            string id = string.Format(@"{0}-{1}", labelId, entry.Id);

            // define attributes for the link
            string attributeList = string.Format(@"id=""{0}-link"" href=""{1}""", id, entry.Page);

            // add attributes to operate a modal-dialog link
            if (entry.IsModalDialog)
            {
                attributeList = string.Format(@"{0} data-modal-dialog-id=""{1}"" data-modal-dialog-actor=""open"" data-modal-dialog-iframe=""{3}"" data-modal-dialog-template-modifier=""{4}"" data-modal-dialog-title=""{2}""", 
                    attributeList, id, entry.Name, entry.Route, entry.Id
                );
            }

            // add attributes to operate an external link
            if (entry.IsExternal)
            {
                attributeList = String.Format(@"{0} target=""_blank"" class=""link""", attributeList);
                name = String.Format(@"{0} <span class=""link__advisal""><span class=""link__container"">Opens in a new window</span></span>", name);
            }
            %>
            <span>
                <a <%= attributeList %>><%= name %></a>
            </span>
            <%
        }
    %>
    </nav>
<% } %>