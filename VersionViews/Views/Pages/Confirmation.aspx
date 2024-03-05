<%@ Page Title="Dotza" Language="C#" MasterPageFile="~/VersionViews/Views/Layouts/ConfirmationLayout.master" Inherits="System.Web.Mvc.ViewPage<Dtm.Framework.Base.Models.BaseClientViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Models.Ecommerce"%>
<%@ Import Namespace="TAXLIENCODE.Extensions" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    string productCode = String.Empty;
    SeminarDateViewData location;
    SeminarTimeViewData time;
    string displayText = String.Empty;
    bool isWebinar = false;

    if (Model.Order == null || Model.Order.OrderItems == null || Model.Order.OrderItems.Count == 0)
    {
        Response.Redirect("/", false);
        time = new SeminarTimeViewData();
        location = new SeminarDateViewData();
    }
    else
    {
        CampaignProduct product = Model.Order.OrderItems[0].CampaignProduct;
        productCode = product.ProductCode;
        location = Model.GetLocation(productCode);
        time = Model.GetTime(productCode);
        displayText = product.DisplayText;
        isWebinar = String.IsNullOrEmpty(location.SeminarLocation) && String.IsNullOrEmpty(location.Street) && String.IsNullOrEmpty(location.State) && String.IsNullOrEmpty(location.Zip);
    }

    string billingFirstName = Model.Order.BillingFirstName;

    string rsvpDate = string.Format("{0}-{1} {2}", 
        location.SeminarDate.Day.AddEnglishOrdinal(), 
        location.SeminarDate.AddDays(2).Day.AddEnglishOrdinal(), 
        location.SeminarDate.ToString("MMMM"));

    string seminarDate = location.SeminarDate.ToString("dddd MMM dd @ hh:mm tt");
%>

<main aria-labelledby="main-title" class="view content content--confirmation content--confirmation-article section">
    <div id="main" class="view__anchor"></div>
    <div class="view__in content__in section__in">
        <div class="content__text">
            <h1 id="main-title" class="content__title">Thank you for registering</h1>

            <div class="content__info">
                <b>When:</b>
                <%= seminarDate %>
            </div>

            <div class="content__info">
                <b>Where:</b>
                <%= location.SeminarLocation %> <%= location.Street %> <%= location.Street2 %> <%= location.City %> <%= location.State %> <%= location.Zip %>
            </div>

            <h2 class="content__title">Here's what to do next</h2>
        </div>

        <div class="section__block content__text">
            <h3 class="content__headline">Add The Event To Your Calendar</h3>
            <p>Include your friend or spouse as a guest on the calendar. Also watch for an email with your event details and forward them to your guest.</p>
        </div>

        <div class="section__block content__text">
            <h3 class="content__headline">Did you add a guest?</h3>
            <p>If not, simply reply to your confirmation email and let us know the name of your guest so we can save a seat.</p>
        </div>

        <div class="section__block content__text">
            <h3 class="content__headline">Get Ready to Grow!</h3>
            <p>This 2-hour class will show you how to go beyond the limits of Single-Family or Multifamily Deals and get started in Tax Liens regardless of your prior experience. Come ready to discover the path to generational wealth!</p>
        </div>

        <div class="section__block">
            <%
                using (Html.BeginForm()) { 
                    %>
                    <button type="submit" id="AcceptOfferButton" name="createOrder">
                        <span id="AcceptOfferCard" class="button">
                            <span>Done!</span>
                        </span>
                    </button>
                    <%    
                }
            %>
        </div>
    </div>
</main>

</asp:Content>
