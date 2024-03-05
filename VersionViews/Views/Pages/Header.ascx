<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="TAXLIENCODE.Navigation" %>

<%
	var isStartPage = DtmContext.Page.IsStartPageType;

	var productAttributeName = SettingsManager.ContextSettings["Label.ProductName"];
	var productName = productAttributeName;

	var sitemap = new Sitemap();
	var sitemapList = sitemap.SitemapList;
	var homeLink = sitemapList.GetItemById("home");

	var logo = string.Format(@"<img src=""/images/Site1/logo.svg"" alt=""{0}"" width=""250"" height=""70"">", productAttributeName);

	if (isStartPage)
	{
		logo = string.Format(@"
			<a 
				href=""{0}"" 
				id=""navbar-logo"" 
				class=""nav__logo"" 
				aria-label=""{1}"">
				{2}
			</a>
		", homeLink.Page, productAttributeName, logo);
	}
	else
	{
		logo = string.Format(@"
			<div class=""nav__logo"">{0}</div>
		", logo);
	}

	var navClassList = "nav";
	
	if (!DtmContext.Page.IsStartPageType)
	{
		navClassList = string.Format("{0} nav--is-end-page", navClassList);
	}

	bool showBanner = isStartPage;
	var bannerText = "Limited spaces available. Hurry up and reserve your seat now!";
%>

<header id="nav" class="view <%= navClassList %> section section--nav @print-only-hide">
	<span class="skip-link delay-render">
		<a href="#main" class="skip-link__button" id="skip-link"><span>Skip To Main Content?</span></a>
	</span>
	<% if (showBanner) { %>
		<section aria-label="Promotion" class="banner banner--promo"><%= bannerText %></section>
	<% } %>
	<div class="view__in nav__group nav__in section__in">
		<div class="nav__logo logo-text">
			<%= logo %>
		</div>
		<% if (isStartPage) { %>
		<button type="button" class="nav__label" aria-label="Toggle Menu">
			<span></span>
		</button>
		<div class="nav__underlay nav__underlay--for-drawer" role="presentation"></div>
		<nav aria-label="Website page links" class="nav__pane">
			<div class="nav__group">
				<div class="nav__list nav__tier-first">
					<div class="logo-text logo-text--stack">
						<%= logo.Replace("navbar-logo", "navbar-header-logo") %>
					</div>
					<%
						List<NavigationItem> entries = sitemapList.GetItemsByIdRange(new List<string> { 
							"home", 
							"learn",
							"about",
							"testimonials",
							"faq",
							"order-now"
						});

						bool enableOrderForm = SettingsManager.ContextSettings["Order.enableOrderForm", true];

						if (!enableOrderForm)
						{
							entries = entries.Where(e => e.Id != "order-now").ToList();
						}

						foreach (var entry in entries)
						{
							%>
							<a class="nav__link" href="<%= entry.Page %>" id="nav-<%= entry.Id %>">
								<span><%= entry.Name %></span>
							</a>
							<%
						}
					%>
				</div>
			</div>
		</nav>
		<% } %>
	</div>

</header>
