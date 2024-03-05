<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<!DOCTYPE html>
<html class="dtm" lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        string metaTitle = DtmContext.Page.PageTitle ?? string.Empty;    
    %>
    <title><%= metaTitle %></title>
    <%= Html.Partial("GetVersionStyles") %>
</head>
<body class="dtm__in">
    <% 
        string title = DtmContext.Page.Upsell.Title ?? string.Empty;
        string text = DtmContext.Page.Upsell.Text ?? string.Empty;
    %>
    <main aria-labelledby="main-title" class="view content content--sub-page section">
        <div id="main" class="view__anchor"></div>
        <article class="view__in content__in section__in">
            <div class="section__block content__text">
                <h1 id="main-title" class="content__title"><%= title %></h1>
                <%
                    string customerServiceEmail = SettingsManager.ContextSettings["CustomerService.EmailAddress"];
                    string customerServicePhone = SettingsManager.ContextSettings["CustomerService.PhoneNumber"];

                    text = text
                        .Replace("{{CustomerServiceEmail}}", string.Format(@"<a href=""mailto:{0}"">{0}</a>", customerServiceEmail))
                        .Replace("{{CustomerServicePhone}}", string.Format(@"<a href=""tel:{0}"">{0}</a>", customerServicePhone)); 
                %>
                <%= text %>
            </div>
        </article>
    </main>
</body>
</html>