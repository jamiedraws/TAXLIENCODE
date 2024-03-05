using System;
using System.Web;
using System.Web.Mvc;
using Dtm.Framework.ClientSites.Web;
using Dtm.Framework.Extensions;
using System.Text.RegularExpressions;
using Dtm.Framework.Models.Ecommerce;
using Dtm.Framework.ClientSites;
using TAXLIENCODE.Models;
using TAXLIENCODE.Models.Interfaces;
using System.Collections.Generic;
using TAXLIENCODE.Utils;
using TAXLIENCODE.UIComponents;
using TAXLIENCODE.Navigation;
using Dtm.Framework.Services.DtmApi;

namespace TAXLIENCODE.PageHandlers
{
    public class GlobalPageHandler : PageHandler
    {
        private string FormType { get; set; }
        private ILocationEngine LocationEngine { get; set; }

        public GlobalPageHandler()
        {
            Dictionary<string, ILocationEngine> engineMap = new Dictionary<string, ILocationEngine>()
            {
                { "UK", new UnitedKingdomEngine() },
                { "CA", new CanadaEngine() },
                { "US-Short", new UnitedStatesEngine() },
                { "CA-Short", new CanadaEngine() },
                { "CA-Long", new CanadaEngine() }
            };

            FormType = SettingsManager.ContextSettings["Seminar.Template.Form.FormType--Form--", "US-Short"];

            if (engineMap.ContainsKey(FormType))
                LocationEngine = engineMap[FormType];
            else
                LocationEngine = engineMap["US-Short"];
        }

        #region " Overrides... "
        public override void BeginRequest(HttpRequestBase request, HttpResponseBase response, ref string pageCode)
        {
            ViewData["OrderButton"] = new OrderButton("Sign Up Now!");
            ViewData["Sitemap"] = new Sitemap();
            ViewData["SocialMediaAutofillChecker"] = new SocialMediaAutofillChecker();

            base.BeginRequest(request, response, ref pageCode);
        }

        public override void PostValidate(ModelStateDictionary modelState)
        {
            if (DtmContext.Page.IsStartPageType)
            {
                modelState = LocationEngine.GetModelErrors(modelState, Form, PostData);
            }

            if (ActionItems.Count == 0)
            {
                AddModelStateError("Form", "Event does not contain a valid event ID");
            }

            if (string.IsNullOrWhiteSpace(SettingsManager.ContextSettings["LeadConnector.EventWebhookId"]))
            {
                AddModelStateError("Form", "Event does not contain a valid event webhook ID");
            }
        }

        public override void PostProcessPageActions()
        {
            if (DtmContext.Page.IsStartPageType)
            {
                if (Order.OrderID != 0 && !Order.IsTestOrder)
                {
                    var webhookId = SettingsManager.ContextSettings["LeadConnector.WebhookId", "uDfaRfv2Sc2vjRc4PWYN"];
                    var eventWebhookId = SettingsManager.ContextSettings["LeadConnector.EventWebhookId"];
                    var eventId = (Order.ContextOrderItems.Count > 0) ? Order.ContextOrderItems.ToArray()[0].ProductSku : null;
                    var clientCode = Order.VisitorSession.Media.InsertionOrder.ClientCode;
                    var guestFirstName = Form["GuestFirstName"] ?? string.Empty;
                    var guestLastName = Form["GuestLastName"] ?? string.Empty;
                    var street2 = (string.IsNullOrWhiteSpace(Order.BillingStreet2)) ? Order.BillingStreet2 : " " + Order.BillingStreet2;
                    var street = Order.BillingStreet + street2;
                    var address = string.Format("{0}, {1} {2}, {3}", street, Order.BillingState, Order.BillingZip, Order.BillingCountry);
                    var campaignName = Order.CampaignOfferVersion.CampaignOffer.Campaign.CampaignName;

                    if (eventId == null || string.IsNullOrWhiteSpace(eventWebhookId))
                    {
                        return;
                    }

                    try
                    {
                        DtmApiResult result;
                        var apiUrl = SettingsManager.ContextSettings["Dtm.Api.Url"];

                        using (var apiClient = new DtmApiClient())
                        {
                            result = apiClient.PostJson(apiUrl + "workers.dtm/?worker=LeadConnector&action=RegisterEvent", new
                            {
                                EventParam = eventWebhookId,
                                CustomUrlParam = webhookId,
                                OrderId = Order.OrderID,
                                Request = new
                                {
                                    FirstName = Order.BillingFirstName,
                                    LastName = Order.BillingLastName,
                                    Email = Order.Email,
                                    EventId = eventId,
                                    Phone = Order.Phone,
                                    Address = address,
                                    GuestFirst = guestFirstName,
                                    GuestLast = guestLastName,
                                    DtmId = Order.OrderID.ToString(),
                                    UtmSource = "DTM-" + clientCode,
                                    UtmCampaign = campaignName
                                }
                            });
                        }
                    }
                    catch (Exception ex)
                    {
                        SiteExceptionHandler.HandleException(ex);
                    }
                }
            }
        }
        #endregion
    }
}
