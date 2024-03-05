using System;
using System.Text.RegularExpressions;
using Dtm.Framework.ClientSites.Web;
using System.Web.Mvc;
using TAXLIENCODE.Models.Interfaces;
using System.Linq;
using System.Collections.Specialized;
using Dtm.Framework.Services.DtmApi;
using Dtm.Framework.ClientSites;

namespace TAXLIENCODE.Models
{
    public class UnitedKingdomEngine : PageHandler, ILocationEngine
    {
        public ModelStateDictionary GetModelErrors(ModelStateDictionary modelState, NameValueCollection form, SafeDictionary postData)
        {
            var seminarTimes = postData.Select(j => j.Value).Sum();
            var billingFirstName = form["BillingFirstName"] ?? string.Empty;
            var billingLastName = form["BillingLastName"] ?? string.Empty;
            var billingStreet = form["BillingStreet"] ?? string.Empty;
            var phone = form["Phone"] ?? string.Empty;
            var email = form["Email"] ?? string.Empty;
            var emailRegex = "^(?:[A-z0-9%&+-]+[.])*[A-z0-9%&+-]+@[A-z0-9.-]+\\.[A-z]{2,6}$";
            var numbersOnlyRegex = @"[^\d]";
            var numbersOnlyPhoneLength = Regex.Replace(phone, numbersOnlyRegex, string.Empty).Length;

            /* Settings */
            var validateBillingFirstName = SettingsManager.ContextSettings["DTM.ClientSites.ValidateBillingFirstName", true];
            var validateBillingLastName = SettingsManager.ContextSettings["DTM.ClientSites.ValidateBillingLastName", true];
            var validateBillingStreet = SettingsManager.ContextSettings["DTM.ClientSites.ValidateBillingStreet", true];
            var validateBillingCity = SettingsManager.ContextSettings["DTM.ClientSites.ValidateBillingCity", true];
            var validateBillingState = SettingsManager.ContextSettings["DTM.ClientSites.ValidateBillingState", true];
            var validateBillingCountry = SettingsManager.ContextSettings["DTM.ClientSites.ValidateBillingCountry", true];
            var validateBillingZip = SettingsManager.ContextSettings["DTM.ClientSites.ValidateBillingZipEmpty", true];
            var validatePhone = SettingsManager.ContextSettings["DTM.ClientSites.ValidatePhoneNumber", true];
            var validateEmail = SettingsManager.ContextSettings["DTM.ClientSites.ValidateEmail", true];

            if (seminarTimes == 0)
            {
                modelState.AddModelError("Form", "Please select a seminar time.");
            }
            if (String.IsNullOrEmpty(billingFirstName) && validateBillingFirstName)
            {
                modelState.AddModelError("BillingFirstName", "First Name is required");
            }
            if (String.IsNullOrEmpty(billingLastName) && validateBillingLastName)
            {
                modelState.AddModelError("BillingLastName", "Last Name is required");
            }
            if (String.IsNullOrEmpty(billingStreet) && validateBillingStreet)
            {
                modelState.AddModelError("BillingStreet", "Address is required");
            }
            else if ((String.IsNullOrEmpty(phone) || (numbersOnlyPhoneLength < 7 || numbersOnlyPhoneLength > 21) && validatePhone))
            {
                modelState.AddModelError("Phone", "Phone is invalid. Please enter a valid phone number.");
            }
            if (String.IsNullOrEmpty(email) && validateEmail)
            {
                modelState.AddModelError("Email", "Email is required.");
            }
            else if (!Regex.IsMatch(email, emailRegex, RegexOptions.IgnoreCase) && validateEmail)
            {
                modelState.AddModelError("Email", "Email is invalid.");
            }

            return modelState;
        }
    }
}