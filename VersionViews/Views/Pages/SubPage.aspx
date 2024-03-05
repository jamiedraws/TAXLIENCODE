<%@ Page Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<Dtm.Framework.Base.Models.BaseClientViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main aria-labelledby="main-title" class="view content content--sub-page section">
    <div id="main" class="view__anchor"></div>
    <article class="view__in content__in section__in">
        <div class="section__block content__text">
        <% 
            // represents the page title from the upsell page editor
            string title = Model.UpsellTitle ?? string.Empty;

            // represents the page text from the upsell page editor
            string text = Model.UpsellText ?? string.Empty;

            // determines if therre is a title
            bool hasTitle = !String.IsNullOrEmpty(title);

            // detertmines if there is text
            bool hasText = !String.IsNullOrEmpty(text);

            if (hasTitle)
            {
                %>
                <h1 id="main-title" class="content__title"><%= title %></h1>
                <%
            } else
            {
                Html.RenderSnippet("SUBPAGE-TITLE-" + DtmContext.PageCode);
            }

            if (hasText)
            {
                string customerServiceEmail = SettingsManager.ContextSettings["CustomerService.EmailAddress"];
                string customerServicePhone = SettingsManager.ContextSettings["CustomerService.PhoneNumber"];

                text = text
                    .Replace("[#optout#]", DtmContext.OptOutLink)
                    .Replace("[#support#]", DtmContext.SupportEmail)
                    .Replace("[#ext#]", DtmContext.ApplicationExtension)
                    .Replace("{{CustomerServiceEmail}}", string.Format(@"<a href=""mailto:{0}"">{0}</a>", customerServiceEmail))
                    .Replace("{{CustomerServicePhone}}", string.Format(@"<a href=""tel:{0}"">{0}</a>", customerServicePhone));

                Response.Write(text);
            } else
            {
                Html.RenderSubPageContent(DtmContext.PageCode);
            }
        %>
        </div>
    </article>
</main>

</asp:Content>