<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="TAXLIENCODE.Utils" %>

<link rel="preconnect" href="https://use.typekit.net/" crossorigin>
<link rel="dns-prefetch" href="https://use.typekit.net/">
<link rel="stylesheet" href="https://use.typekit.net/lze7ilf.css">

<%
    ResourceWriter resourceWriter = new ResourceWriter();

    Response.Write(resourceWriter.WriteStylePreload("css/Site1/style.css"));
    Response.Write(resourceWriter.WriteLink("css/Site1/style.css"));
    Response.Write(resourceWriter.WriteScript("js/Site1/app.es5.js"));
%>

<style>
    .view__anchor {
        top: calc(calc(var(--section-offset) + -4em) * -1);
    }
</style>

<noscript>
    <style>
        .accordion__section[hidden] {
            display: block;
        }

        .content-reveal {
            opacity: 1;
            transform: none;
        }
    </style>
</noscript>