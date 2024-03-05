using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Dtm.Framework.ClientSites;

namespace TAXLIENCODE.Utils
{
    public class SocialMediaAutofillChecker
    {
        private bool _enableFacebook { get; set; } 

        private bool _enableLinkedIn { get; set; }

        private bool _enableGooglePlus { get; set; }

        private string _facebookAppId { get; set; }

        private string _linkedInApiKey { get; set; }

        private string _googlePlusClientId { get; set; }

        public SocialMediaAutofillChecker()
        {
            _enableFacebook = SettingsManager.ContextSettings["SocialPlugins.Facebook.Enable", false];
            _enableLinkedIn = SettingsManager.ContextSettings["SocialPlugins.LinkedIn.Enable", false];
            _enableGooglePlus = SettingsManager.ContextSettings["SocialPlugins.GooglePlus.Enable", false];

            _facebookAppId = SettingsManager.ContextSettings["SocialPlugins.Facebook.AppId", string.Empty];
            _linkedInApiKey = SettingsManager.ContextSettings["SocialPlugins.LinkedIn.ApiKey", string.Empty];
            _googlePlusClientId = SettingsManager.ContextSettings["SocialPlugins.GooglePlus.ClientId", string.Empty];
        }

        public bool IsFacebookConfigured 
        { 
        get 
            { 
                return _enableFacebook && !string.IsNullOrEmpty(_facebookAppId); 
            } 
        }

        public bool IsLinkedInConfigured
        {
            get
            {
                return _enableLinkedIn && !string.IsNullOrEmpty(_linkedInApiKey);
            }
        }

        public bool IsGooglePlusConfigured
        {
            get
            {
                return _enableGooglePlus && !string.IsNullOrEmpty(_googlePlusClientId);
            }
        }

        public bool HasSocialAutofill
        {
            get
            {
                return IsLinkedInConfigured || IsFacebookConfigured || IsGooglePlusConfigured;
            }
        }
    }
}