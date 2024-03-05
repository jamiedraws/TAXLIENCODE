<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Dtm.Framework.Base.Models.BaseClientViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.TokenEngines" %>

<%
    var traffic = DtmContext.Traffic;
    var tokenEngine = new TokenEngine();

    var enableGooglePlus = SettingsManager.ContextSettings["SocialPlugins.GooglePlus.Enable", false];
    var enableTwitter = SettingsManager.ContextSettings["SocialPlugins.Twitter.Enable", false];
    var enableLinkedIn = SettingsManager.ContextSettings["SocialPlugins.LinkedIn.Enable", false];
    var enableFacebook = SettingsManager.ContextSettings["SocialPlugins.Facebook.Enable", false];
    var enableFacebookShare = SettingsManager.ContextSettings["SocialPlugins.Facebook.EnableShareButton", true];
    var enableGooglePlusShare = SettingsManager.ContextSettings["SocialPlugins.GooglePlus.EnableShareButton", true];
    var enableSnapchat = SettingsManager.ContextSettings["SocialPlugins.Snapchat.Enable", false]
        && traffic != null && traffic.VendorId == 384;


    var socialMediaUrlFB = Dtm.Framework.ClientSites.SettingsManager.ContextSettings["SocialPlugin.SocialMediaUrlFB", String.Format("http://{0}", tokenEngine.Process("[#Domain.Domain#]", null, null, null).Content)];
    var socialMediaUrlFGPlus = Dtm.Framework.ClientSites.SettingsManager.ContextSettings["SocialPlugin.socialMediaUrlFGPlus", String.Format("http://{0}", tokenEngine.Process("[#Domain.Domain#]", null, null, null).Content)];
    var socialMediaTextTwitter = Dtm.Framework.ClientSites.SettingsManager.ContextSettings["SocialPlugin.socialMediaTextTwitter", String.Format("http://{0}", tokenEngine.Process("[#Domain.Domain#]", null, null, null).Content)];
    var socialMediaHashtagTwitter = Dtm.Framework.ClientSites.SettingsManager.ContextSettings["SocialPlugin.socialMediaHashtagTwitter", ""];

    if (socialMediaTextTwitter.Length > 140)
    {
        socialMediaTextTwitter = socialMediaTextTwitter.Substring(0, 140);
    }

    var googlePlusClientId = SettingsManager.ContextSettings["SocialPlugins.GooglePlus.ClientId"];
    var linkedInApiKey = SettingsManager.ContextSettings["SocialPlugins.LinkedIn.ApiKey"];
    var facebookAppId = SettingsManager.ContextSettings["SocialPlugins.Facebook.AppId"];
    var facebookSdkVersion = SettingsManager.ContextSettings["SocialPlugins.Facebook.Version", "v8.1"];



%>
<%if (enableSnapchat)
    { %>
<script type='text/javascript'>
    (function (win, doc, sdk_url) {
        if (win.snaptr) return;
        var tr = win.snaptr = function () {
            tr.handleRequest ? tr.handleRequest.apply(tr, arguments) : tr.queue.push(arguments);
        };
        tr.queue = [];
        var s = 'script';
        var new_script_section = doc.createElement(s);
        new_script_section.async = !0;
        new_script_section.src = sdk_url;
        var insert_pos = doc.getElementsByTagName(s)[0];
        insert_pos.parentNode.insertBefore(new_script_section, insert_pos);
    })(window, document, 'https://sc-static.net/scevent.min.js ');
</script>
<%} %>
<%if (enableGooglePlus)
    { %>
<!-- Place this tag in your head or just before your close body tag. -->
<script src="https://accounts.google.com/gsi/client" async defer></script>
<% if (enableGooglePlusShare)
    { %>
<!-- Place this tag where you want the share button to render. -->
<div class="g-plus" data-action="share"></div>
<%} %>
<% if (enableLinkedIn) { %>
<style>
    .linkedin-loading-layover {
        pointer-events:none;opacity:0; width:100%;height:100%;position:fixed;background-color:black;top:0;left:0;z-index:9999999;transition:opacity .3s ease-in-out;
    }
    .linkedin-loading-layover--is-visible {
        opacity:.7; pointer-events:all;
    }
</style>
<% } %>
<%} %>
<%if (enableTwitter)
    { %>
<style>
    .custom-tweet-button a,
    .custom-follow-button a {
        position: relative;
        display: inline;
        height: 16px;
        padding: 3px;
        border: 1px solid #ccc;
        font-size: 11px;
        color: #333;
        text-decoration: none;
        text-shadow: 0 1px 0 rgba(255, 255, 255, .5);
        font-weight: bold;
        background-color: #F8F8F8;
        background-image: -webkit-gradient(linear,left top,left bottom,from(#FFF),to(#DEDEDE));
        background-image: -moz-linear-gradient(top,#FFF,#DEDEDE);
        background-image: -o-linear-gradient(top,#FFF,#DEDEDE);
        background-image: -ms-linear-gradient(top,#FFF,#DEDEDE);
        border: #CCC solid 1px;
        -moz-border-radius: 3px;
        -webkit-border-radius: 3px;
        border-radius: 3px;
        cursor: pointer;
        overflow: hidden;
    }

        .custom-tweet-button a:hover,
        .custom-follow-button a:hover {
            border-color: #BBB;
            background-color: #F8F8F8;
            background-image: -webkit-gradient(linear,left top,left bottom,from(#F8F8F8),to(#D9D9D9));
            background-image: -moz-linear-gradient(top,#F8F8F8,#D9D9D9);
            background-image: -o-linear-gradient(top,#F8F8F8,#D9D9D9);
            background-image: -ms-linear-gradient(top,#F8F8F8,#D9D9D9);
            background-image: linear-gradient(top,#F8F8F8,#D9D9D9);
            -webkit-box-shadow: none;
            -moz-box-shadow: none;
            box-shadow: none;
        }

        .custom-tweet-button a .btn-icon,
        .custom-follow-button a .btn-icon {
            position: absolute;
            width: 16px;
            height: 13px;
            top: 50%;
            left: 3px;
            margin-top: -6px;
            background: url('https://twitter.com/favicons/favicon.ico') 1px center no-repeat;
            background-size: 13px;
        }

        .custom-tweet-button a .btn-text,
        .custom-follow-button a .btn-text {
            padding: 2px 3px 0 20px;
        }

    #___plus_0 {
        max-width: 70px;
    }

    #dtm_upgrade #content_top .fb-share-button, #dtm_upgrade #content_top .custom-tweet-button {
        border: none;
    }
</style>
<div class="custom-tweet-button">
    <a
        onclick='window.open("https://twitter.com/intent/tweet?text=" + encodeURIComponent("<%=socialMediaTextTwitter%>") + "&hashtags=<%=socialMediaHashtagTwitter%>" , "Share", "height=200, width=200");'>
        <i class="btn-icon"></i>
        <span class="btn-text">Tweet</span>
    </a>
</div>
<%} %>
<%if (enableFacebook)
    { %>
<div id="fb-root"></div>
<script>(function (d, s, id) {
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=<%=facebookSdkVersion%>";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
<%  if (enableFacebookShare)
    { %>
<div class="fb-share-button" data-href="<%=socialMediaUrlFB %>" data-layout="button_count" data-size="small" data-mobile-iframe="true"><a class="fb-xfbml-parse-ignore" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=https%3A%2F%2Fdevelopers.facebook.com%2Fdocs%2Fplugins%2F&amp;src=sdkpreparse">Share</a></div>
<%
    }
}
%>

<script type="text/javascript">
    var SocialContext = function () {
        var self = this;
        var _debug = '<%=Request["debug"]%>' == '1';
        // to display user feedback
        var $fb = $('[data-social-autofill-fb]');
        // set continuation message to display to user
        var continuation = 'Please continue to register below.';
        // set timeout delay
        var delay = 5000;

        this.GoogleUser = {};
        this.GoogleData = {};

        // sets the pending message on the form and temporarily disables the button
        this.setPendingMessage = function ($button, platform) {
            let self = this;
            $fb.text('Checking. Please wait for ' + platform + '.');
            this.disableButton($button);
            setTimeout(function () {
                self.enableButton($button);
                $fb.text(continuation);
            }, delay);
        }

        // sets a status message on the form and temporarily disables the button
        this.setStatusMessage = function ($button, message) {
            $fb.text(message);
            this.disableButton($button);
        }

        // sets the success message on the form and enables the button
        this.setSuccessMessage = function ($button, platform) {
            $fb.text(platform + ' successfully autofilled name & email.');
            this.enableButton($button);
        };

        // disables the button on the form
        this.disableButton = function ($button) {
            $button.removeClass('social__is-available')
            .attr({
                'aria-disabled' : 'true',
                'tabindex' : -1
            });
        };

        // enables the button on the form
        this.enableButton = function ($button, title) {
            let config = {
                'aria-disabled' : 'false',
                'tabindex' : 0
            };
            if ( typeof title === 'string' ) {
                config.title = title;
            }
            $button.addClass('social__is-available').attr(config);
        };

        function toAddress(value) {
            var hasStreet = false, hasCity = false, hasState = false, hasZipCode = false, hasCountry = false;
            var street, city, state, zipCode, country;
            var stateWord, countryWord;
            if (value != null && value != "") {
                var findValueFromWord = function (target, matchWord) {
                    var foundMatchWord, foundValue, found = false;
                    if ($('#' + target).length > 0 && matchWord != '') {
                        var findValue = matchWord.toLowerCase().replace(/[^A-Z]/gi, '').trim();
                        if (target.indexOf('Country') > -1 && matchWord == 'US') {
                            findValue = 'USA';
                        }
                        $('#' + target + ' option').each(function (i, item) {
                            var optionSearchString = (($(item).val() || '').replace(/[^A-Z]/gi, '') + ',' + ($(item).text() || '').replace(/[^A-Z]/gi, '')).toLowerCase().trim();
                            if (optionSearchString.indexOf(findValue) > -1) {
                                found = true;
                                foundValue = $(item).val();
                                foundMatchWord = matchWord.replace(',', '');
                                return false;
                            }
                        });
                    }
                    return { found: found, foundValue: foundValue, foundMatchWord: foundMatchWord };
                };

                var parseWords = function (words) {
                    for (var i = 0; i < words.length; i++) {
                        var word = words[i];

                        var stateMatchResult = findValueFromWord('BillingState', word);
                        if (stateMatchResult.found) {
                            hasState = stateMatchResult.found;
                            state = stateMatchResult.foundValue;
                            stateWord = stateMatchResult.foundMatchWord;
                        }
                        var countryMatchResult = findValueFromWord('BillingCountry', word);
                        if (countryMatchResult.found) {
                            hasCountry = countryMatchResult.found;
                            country = countryMatchResult.foundValue;
                            countryWord = countryMatchResult.foundMatchWord;
                        }
                    }
                };
                var words = value.split(',');
                parseWords(words);
                words = value.split(' ');
                parseWords(words);

                var newValue = value;
                if (hasState) {
                    newValue = newValue.replace(stateWord, '');
                }
                if (hasCountry) {
                    newValue = newValue.replace(countryWord, '');
                }
                var values = newValue.split(',');
                switch (values.length - 1) {
                    case 1: // Street? City, State Zip? Country?
                        var leftString = values[0].trim(), rightString = values[1].trim();
                        if (leftString.length > 0) {
                            hasCity = true;
                            city = leftString;
                        }
                        if (rightString.length > 0 && /\d+([-]\d+)?/.test(rightString)) {
                            hasZipCode = true;
                            zipCode = rightString;
                        }
                        break;
                }
            }
            return {
                hasStreet: hasStreet,
                hasCity: hasCity,
                hasState: hasState,
                hasZipCode: hasZipCode,
                hasCountry: hasCountry,
                street: street,
                city: city,
                state: state,
                zipCode: zipCode,
                country: country
            };
        }

        function assignValues(pluginType, data) {
            if ( 'Platform' in data && 'PlatformCode' in data ) {
                self.setSuccessMessage($(self.options[data.PlatformCode].targets), data.Platform);
            }

            if (_debug) {
                console.log(data);
            }

            if (data.FullName && $('#BillingFullName').length > 0) {
                var fullName = data.FullName.replace(/[^A-Za-z .]/gi, '').trim();
                $('#BillingFullName').val(fullName)
                if ($('#ShippingIsDifferentThanBilling').is(':checked')) {
                    $('#ShippingFullName').val(fullName)
                }

                if (!data.FirstName && !data.LastName) {
                    var firstName = fullName.split(' ')[0];
                    var lastName = fullName.substr(firstName.length).trim();
                    data.FirstName = firstName;
                    data.LastName = lastName;
                }
            }

            if (data.FirstName && $('#BillingFirstName').length > 0) {
                var firstName = data.FirstName.replace(/[^A-Za-z .]/gi, '').trim();
                $('#BillingFirstName').val(firstName)
                if ($('#ShippingIsDifferentThanBilling').is(':checked')) {
                    $('#ShippingFirstName').val(firstName)
                }
            }

            if (data.LastName && $('#BillingLastName').length > 0) {
                var lastName = data.LastName.replace(/[^A-Za-z .]/gi, '').trim();
                $('#BillingLastName').val(lastName)
                if ($('#ShippingIsDifferentThanBilling').is(':checked')) {
                    $('#ShippingLastName').val(lastName)
                }
            }

            if (data.Email && $('#Email').length > 0) {
                var email = data.Email;
                $('#Email').val(email);
            }

            if (data.Phone && $('#Phone').length > 0) {
                var phone = data.Phone;
                $('#Phone').val(phone);
            }

            if (data.Location) {
                var streetInput;
                if ($('#BillingFullStreet').length > 0) {
                    streetInput = $('#BillingFullStreet');
                }
                else if ($('#BillingStreet').length > 0) {
                    streetInput = $('#BillingStreet');
                }
                var address = toAddress(data.Location);
                if (address.hasStreet) {
                    streetInput.val(address["street"]);
                }
                if (address.hasCity && $('#BillingCity').length > 0) {
                    $('#BillingCity').val(address["city"]);
                }
                if (address.hasState && $('#BillingState').length > 0) {
                    $('#BillingState').val(address["state"]);
                }
                if (address.hasZipCode && $('#BillingZip').length > 0) {
                    $('#BillingZip').val(address["zipCode"]).trigger('change');
                }
                if (address.hasCountry && $('#BillingCountry').length > 0) {
                    $('#BillingCountry').val(address["country"]);
                }
            }

            if (data.Token) {
                var idTarget = 'SOCIAL_' + pluginType + '_TOKEN';
                if ($('#' + idTarget).length > 0) {
                    $('#' + idTarget).val(data.Id);
                } else {
                    $('form').prepend('<input type="hidden" id="' + idTarget + '" name="' + idTarget + '" value="' + data.Token + '"/>')
                }
            }

            if (data.Id) {
                var idTarget = 'SOCIAL_' + pluginType + '_ID';
                if ($('#' + idTarget).length > 0) {
                    $('#' + idTarget).val(data.Id);
                } else {
                    $('form').prepend('<input type="hidden" id="' + idTarget + '" name="' + idTarget + '" value="' + data.Id + '"/>')
                }
                idTarget = 'SOCIAL_PLUGIN';
                if ($('#' + idTarget).length > 0) {
                    $('#' + idTarget).val(pluginType);
                } else {
                    $('form').prepend('<input type="hidden" id="' + idTarget + '" name="' + idTarget + '" value="' + pluginType + '"/>')
                }
            }
        }

        <% if (enableLinkedIn) { %>
        function onLinkedInLogin () {
            $('<div/>', {
                id : 'linkedinLoadingLayover',
                class : 'linkedin-loading-layover'
            }).appendTo($('body'));

            var memberInformation = "";
            var loginWindow = null;
            var runInterval = false;
            var myElement = document.querySelector('#linkedinLoadingLayover');

            function closeLoginWindow () {
                toggleLayover(false);
                if (runInterval !== null)
                    window.clearInterval(runInterval);
                if(loginWindow !== null)
                    loginWindow.close();
            }

            myElement.addEventListener('click', closeLoginWindow);

            function trigger ($this) {
                toggleLayover(true);
                var html = "<b>Please wait...</b>";
                loginWindow = window.open("", '_blank', 'location=no,height=570,width=520,scrollbars=yes');
                loginWindow.document.write(html);
                $.post("/Shared/Services/LinkedIn.ashx?m=1").done(function (response) {
                    deleteCookie();
                    var start = Date.now();
                    var responseObj = JSON.parse(response);
                    if (responseObj !== null && responseObj.isSuccess === true) {
                        
                        //loginWindow = window.open(responseObj.content, '_blank', 'location=no,height=570,width=520,scrollbars=yes');
                        loginWindow.location.href = responseObj.content;
                        runLogin = true;
                        //var token = '';
                        runInterval = setInterval(function() {
                            var delta = Date.now() - start; 
                            var cookie = getCookie("_liac");
                            if (!((cookie === null || cookie === '') && delta < 120000 && loginWindow !== null)) {
                                window.clearInterval(runInterval);
                                closeLoginWindow();
                            }
                            //token = cooks;
                            if (cookie !== null && cookie !== "") {  
                                memberInformation = getCookie("_limi");
                                email = getCookie("_liem");
                                populateName(memberInformation);
                                populateEmail(email);
                                self.setSuccessMessage($this, 'LinkedIn');
                        }
                        }, 1000);
                    }
                })
                .fail(function() { 
                    setTimeout(function() { closeLoginWindow(); }, 500);
                });
            }

            function getCookie(cname) {
                var name = cname + "=";
                var decodedCookie = decodeURIComponent(document.cookie);
                var ca = decodedCookie.split(';');
                for(var i = 0; i <ca.length; i++) {
                    var c = ca[i];
                    while (c.charAt(0) === ' ') {
                    c = c.substring(1);
                    }
                    if (c.indexOf(name) === 0) {
                    return c.substring(name.length, c.length);
                    }
                }
                return "";
            }

            function deleteCookie(name) {
                document.cookie = name + "=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
            }
            
            function toggleLayover(enable){
                if (enable) {
                    myElement.classList.add('linkedin-loading-layover--is-visible');
                } else {
                    myElement.classList.remove('linkedin-loading-layover--is-visible');
                }
            }

            function populateName(jsonString) {
                var jsonObject = (jsonString !== "") ?  JSON.parse(jsonString) : "";
                var firstName = (jsonObject !==  "") ? jsonObject.firstName.localized.en_US : "";
                var lastName = (jsonObject !==  "") ? jsonObject.lastName.localized.en_US : "";

                $("#BillingFirstName").val(firstName);
                $("#BillingLastName").val(lastName);
                deleteCookie("_liac");
                deleteCookie("_limi");
            }

            function populateEmail(jsonString) {
                var jsonObject = (jsonString !== null && jsonString !== "") ? JSON.parse(jsonString) : "";

                if (jsonObject !== "") {
                    var elements = (typeof jsonObject["elements"] !== "undefined" && jsonObject["elements"] !== null) ? jsonObject["elements"] : "";
                    var handle = (typeof elements[0]["handle~"] !== "undefined" && elements[0]["handle~"] !== null) ? elements[0]["handle~"] : "";

                    if (handle !== "" && handle.hasOwnProperty("emailAddress")) {
                        $("#Email").val(handle["emailAddress"]);
                        deleteCookie("_liem");
                    }
                }
            }

            return trigger;
        }
        <% } %>

        <% if ( enableGooglePlus ) { %>
        const decodeJwtResponse = (credential) => {
            return JSON.parse(atob(credential.split('.')[1]));
        }

        const handleCredentialResponse = (response) => {
            const responsePayload = decodeJwtResponse(response.credential);

            assignValues('GPLUS',
            {
                FirstName: responsePayload.given_name,
                LastName: responsePayload.family_name,
                FullName: responsePayload.name,
                Email: responsePayload.email,
                Id: responsePayload.sub,
                Platform: 'Google',
                PlatformCode: 'gPlus'
            });
        }

        const initializeGoogleSignIn = (options) => {
            google.accounts.id.initialize({
                client_id: options.gPlus.clientId,
                callback: handleCredentialResponse
            });

            google.accounts.id.prompt((notification) => {
                if (!notification.isNotDisplayed()) return;

                const reason = notification.getNotDisplayedReason();

                switch (reason) {
                    case "unregistered_origin":
                        this.setStatusMessage($(options.gPlus.targets), "Google Sign-in is not enabled for this page.");
                        break;
                    default:
                        break;
                }
            });

            const signInButton = document.querySelector(options.gPlus.targets);
            if (!signInButton) return;

            const gsiContainerIdRef = signInButton.getAttribute("data-gsi-container-id");
            if (!gsiContainerIdRef) return;

            const gsiContainer = document.getElementById(gsiContainerIdRef);
            if (!gsiContainer) return;

            google.accounts.id.renderButton(gsiContainer, {
                type: 'icon',
                size: 'large',
                click_listener: (event) => {
                    self.setPendingMessage($(signInButton), 'Google');
                }
            });
        }
        <% } %>

        <% if ( enableFacebook ) { %>
        function onFacebookLogin(response) {
            if (response.status === 'connected') {
                var id_token = response.authResponse.accessToken;
                FB.api('/me?fields=name,first_name,last_name,email', function (response) {
                    var id = response.id;
                    var email = response.email;
                    var firstName = response.first_name;
                    var lastName = response.last_name;
                    var fullName = response.name;
                    var location = response.location || { name: '' };
                    assignValues('FACEBOOK',
                        {
                            FirstName: firstName,
                            LastName: lastName,
                            FullName: fullName,
                            Email: email,
                            Location: location["name"],
                            Id: id,
                            Token: id_token,
                            Platform: 'Facebook',
                            PlatformCode: 'facebook'
                        });
                });
                return true;
            }
            return false;
        }

		const initializeFacebookLogin = (options) => {
			const $target = $(options.facebook.targets);
			
			FB.init({
				appId: options.facebook.appId,
				cookie: true,
				xfbml: false,
				version: options.facebook.version
			});

			FB.getLoginStatus(function (response) {
				self.enableButton($target, 'Sign in with Facebook');
				onFacebookLogin(response);
			});

			$target.each(function (i, item) {
				$(item).click(function () {
					self.setPendingMessage($target, 'Facebook');
					FB.login(function (response) {
						onFacebookLogin(response);
					}, {
						scope: 'public_profile,email'
					});
				});
			});
		}
        <% } %>

        <% if ( enableSnapchat ) { %>
        function onSnapchatLogin(response) {
            if (_debug) {
                console.log(response);
            }

            var fullName = response['name'] || '';
            var email = response['email'] || '';
            var phone = response['phone'] || '';

            assignValues('SNAPCHAT',
                        {
                            FullName: fullName,
                            Email: email,
                            Phone: phone
                        });
        }
        <% } %>

        function logout(plugin) {
            switch (plugin) {
                case "GPLUS":
                    google.accounts.id.disableAutoSelect();
                    break;
                case "FACEBOOK":
                    FB.logout(function (response) {
                        console.log('User signed out.');
                    });
                    break;
                case "TWITTER":

                    break;
                case "LINKEDIN":
                    IN.User.logout(function (response) {
                        console.log('User signed out.');
                    });
                    break;
                case "SNAPCHAT":
                    break;
            }
        }

        this.init = function (options) {

            this.options = options;

            <% if ( enableLinkedIn ) { %>
            if (options.linkedIn) {
                if (options.linkedIn.enabled) {
                    var $target = $(options.linkedIn.targets);
                    var init = onLinkedInLogin();
                    self.enableButton($target, 'Sign in with LinkedIn');
                    $target.on('click', function () {
                        var $this = $(this);
                        self.setPendingMessage($this, 'LinkedIn');
                        init($this);
                    });
                }
            }
            <% } %>

            <% if ( enableGooglePlus ) { %>
            if (options.gPlus) {
                if (options.gPlus.enabled) {
                    addEventListener("load", event => initializeGoogleSignIn(options));
                } else {
                    $(options.gPlus.targets).hide();
                }
            }
            <% } %>

            <% if ( enableFacebook ) { %>
            if (options.facebook) {
                if (options.facebook.enabled) {
                    if (!document.getElementById('facebook-jssdk')) {
                        var fjs = document.getElementsByTagName('script')[0];
                        var js = document.createElement('script');
                        js.id = 'facebook-jssdk';
                        js.src = "//connect.facebook.net/en_US/sdk.js";
                        fjs.parentNode.insertBefore(js, fjs);
                    }

                    addEventListener("load", (event) => initializeFacebookLogin(options));
                } else {
                    $(options.facebook.targets).hide();
                }
            }
            <% } %>

            <% if ( enableSnapchat ) { %>
            if (options.snapchat) {
                if (options.snapchat.enabled) {
                    $(options.snapchat.targets).each(function (i, item) {
                        $(item).click(function () {
                            snaptr('autofill', {
                                onComplete: onSnapchatLogin,
                                fields: ['name', 'email', 'phone']
                            });
                        });
                    });
                } else {
                    $(options.snapchat.targets).hide();
                }
            }
            <% } %>
        }
    };

    var SOCIAL_CONTEXT = new SocialContext();

    if (typeof (DtmContext) == "object") {
        DtmContext["SocialContext"] = SOCIAL_CONTEXT;
    }

    $(window).ready(function () {
        SOCIAL_CONTEXT.init({
            gPlus: {
                targets: '.social-media-gplus',
                enabled: parseInt('<%= enableGooglePlus ? 1 : 0%>'),
                clientId: '<%=googlePlusClientId%>'
            },
            twitter: {
                targets: '.social-media-twitter',
                enabled: parseInt('<%= enableTwitter ? 1 : 0%>')
            },
            linkedIn: {
                targets: '.social-media-linkedin',
                enabled: parseInt('<%= enableLinkedIn ? 1 : 0%>')
            },
            facebook: {
                targets: '.social-media-facebook',
                enabled: parseInt('<%= enableFacebook ? 1 : 0%>'),
                appId: '<%= facebookAppId %>',
                version: '<%=facebookSdkVersion %>'
            },
            snapchat: {
                targets: '.social-media-snapchat',
                enabled: parseInt('<%= enableSnapchat ? 1 : 0 %>')
            }
        });

    });
</script>