<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="TAXLIENCODE.Utils" %>

<%
    bool isStartPage = DtmContext.Page.IsStartPageType;

    string footerClassList = "footer";
    
    if (!isStartPage)
    {
        footerClassList = string.Format("{0} footer--is-end-page", footerClassList);
    }
%>
<footer aria-label="Copyright and Policies" class="view <%= footerClassList %> section @print-only-hide">
	<div id="footer" class="view__anchor"></div>
	<div class="view__in section__in">
        <div class="section__block">
            <div class="footer__group">
                <div class="footer__logo-copyright">
                    <img src="/images/Site1/logo-icon.svg" loading="lazy" alt="" width="38" height="30"/>
                    <address class="footer__copyright">&copy; Copyright <%= DateTime.Now.ToString("yyyy") %>, All rights reserved.</address>
                </div>
                <div class="footer__nav">
                    <% 
                        Html.RenderPartial("SitemapList");
                    %>
                </div>
                <div class="footer__offer-details">
                    <div class="offer-details">
                        <small>As with all investments, there is an element of risk associated with this investment strategy. Interest rates are state-mandated, each tax lien certificate is backed by real estate, and tax liens are regulated by state and county governments, but there is still a chance that you could lose part or all of your investment. No matter which investment vehicle you choose, it&rsquo;s crucial to become educated and invest prudently. Each attendee will not receive the Personal Apple AirPods Pro. A drawing will be held on the last day of the events to determine the winner.</small>

                        <small>This site is not a part of the Facebook and/or Google Inc. Additionally, this site is NOT endorsed by Facebook and/or Google in any way. FACEBOOK is a trademark of FACEBOOK, Inc.</small>
                    </div>
                </div>
            </div>
        </div>
	</div>
    <div hidden>
        <svg>
            <symbol id="icon-chevron" x="0px" y="0px" viewBox="0 0 25.228 14.029">
                <g transform="translate(1.414 1.414)">
                    <path d="M0,11.2,11.2,0m0,22.4L0,11.2" transform="translate(0 11.2) rotate(-90)" stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/>
                </g>
            </symbol>
            <symbol id="location" x="0px" y="0px" viewBox="0 0 32 40">
                <path d="M10.5,21.5V12.25l5.5-3.65,5.5,3.65v9.25h-3v-6h-5v6h-3Zm5.5,14.55c4.43-4.03,7.71-7.69,9.83-10.97,2.12-3.28,3.17-6.18,3.17-8.68,0-3.93-1.26-7.15-3.78-9.65-2.52-2.5-5.59-3.75-9.22-3.75s-6.71,1.25-9.23,3.75c-2.52,2.5-3.77,5.72-3.77,9.65,0,2.5,1.08,5.39,3.25,8.68,2.17,3.28,5.42,6.94,9.75,10.97Zm0,3.95c-5.37-4.57-9.38-8.81-12.02-12.73-2.65-3.92-3.98-7.54-3.98-10.88C0,11.4,1.61,7.42,4.82,4.45,8.04,1.48,11.77,0,16,0s7.96,1.48,11.17,4.45c3.22,2.97,4.83,6.95,4.83,11.95,0,3.33-1.33,6.96-3.97,10.88-2.65,3.92-6.66,8.16-12.03,12.73Z"/>
            </symbol>
            <symbol id="icon-facebook" viewBox="0 0 32 32">
                <path d="M19 6h5v-6h-5c-3.86 0-7 3.14-7 7v3h-4v6h4v16h6v-16h5l1-6h-6v-3c0-0.542 0.458-1 1-1z"></path>
            </symbol>
            <symbol id="icon-linkedin" viewBox="0 0 32 32">
                <path d="M12 12h5.535v2.837h0.079c0.77-1.381 2.655-2.837 5.464-2.837 5.842 0 6.922 3.637 6.922 8.367v9.633h-5.769v-8.54c0-2.037-0.042-4.657-3.001-4.657-3.005 0-3.463 2.218-3.463 4.509v8.688h-5.767v-18z"></path>
                <path d="M2 12h6v18h-6v-18z"></path>
                <path d="M8 7c0 1.657-1.343 3-3 3s-3-1.343-3-3c0-1.657 1.343-3 3-3s3 1.343 3 3z"></path>
            </symbol>
            <symbol id="icon-twitter" width="34" height="32" viewBox="0 0 69.14 53.78">
                <path d="M69.14,6.4c-2.56,1.02-5.38,1.79-8.19,2.05,2.82-1.79,5.12-4.35,6.15-7.43-2.82,1.54-5.89,2.56-8.96,3.33-2.56-2.56-6.4-4.35-10.24-4.35-7.94,0-14.08,6.15-14.08,13.57,0,1.02,0,2.05,.26,3.07-11.78-.51-22.28-5.89-29.19-14.08-1.28,2.05-2.05,4.35-2.05,6.66,0,4.61,2.56,8.96,6.4,11.27-2.3,0-4.61-.51-6.4-1.54v.26c0,6.66,4.87,12.04,11.27,13.32-1.28,.26-2.56,.51-3.84,.51-1.02,0-1.79,0-2.56-.26,1.79,5.38,7.17,9.22,13.32,9.47-4.87,3.59-11.01,5.89-17.67,5.89-1.02,0-2.3,0-3.33-.26,6.4,3.59,13.83,5.89,21.77,5.89,26.12,0,40.46-20.74,40.46-38.67v-1.79c2.56-1.79,5.12-4.35,6.91-6.91Z"/>
            </symbol>
        </svg>
    </div>
</footer>

<% 
    Html.RenderPartial("Scripts");


    Func<string, string, string> writeJavaScriptVerifyVariable = ((string settingCode, string javaScriptVariableName) =>
    {
        bool isEnabled = SettingsManager.ContextSettings[settingCode, true];

        return !isEnabled ? string.Format(@"var {0} = false;", javaScriptVariableName) : string.Empty;
    });

    %>
    <script>
        var overrideValidationMessage = {
            phoneInvalidUK: "Phone is invalid."
        };

        errorMessages = SetFormLanguage('English', overrideValidationMessage);
        <%= writeJavaScriptVerifyVariable("DTM.ClientSites.ValidateBillingStreet", "verifyBStreet") %>
        <%= writeJavaScriptVerifyVariable("DTM.ClientSites.ValidateBillingCity", "verifyBCity") %>
        <%= writeJavaScriptVerifyVariable("DTM.ClientSites.ValidateBillingCity", "verifyBState") %>
        <%= writeJavaScriptVerifyVariable("DTM.ClientSites.ValidateBillingState", "verifyBState") %>
        <%= writeJavaScriptVerifyVariable("DTM.ClientSites.ValidateBillingZipEmpty", "verifyBZip") %>
        <%= writeJavaScriptVerifyVariable("DTM.ClientSites.ValidateBillingCountry", "verifyBCountry") %>
    </script>
    <%

    SocialMediaAutofillChecker socialMediaAutofillChecker = ViewData["SocialMediaAutofillChecker"] as SocialMediaAutofillChecker ?? new SocialMediaAutofillChecker();

    if (DtmContext.Page.IsStartPageType && socialMediaAutofillChecker.HasSocialAutofill)
    {
        %>
        <style>.fb-share-button { display: none; }</style>
        <%
        Html.RenderPartial("SocialPlugins");
    }
%>

<div hidden>
	<%= Model.FrameworkVersion %>
	<% 
        if (DtmContext.Page.IsStartPageType)
        {
		    Html.RenderSiteControls(SiteControlLocation.ContentTop);
        }

		Html.RenderSiteControls(SiteControlLocation.ContentBottom);
		Html.RenderSiteControls(SiteControlLocation.PageBottom);
	%>
</div>