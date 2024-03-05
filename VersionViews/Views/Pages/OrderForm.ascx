<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<Dtm.Framework.Base.Models.BaseClientViewData>" %>
<%@ Import Namespace="Dtm.Framework.Models.Ecommerce.Repositories" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="TAXLIENCODE.Utils" %>
<%@ Import Namespace="TAXLIENCODE.Extensions" %>
<%@ Import Namespace="TAXLIENCODE.Navigation" %>
<%@ Import Namespace="TAXLIENCODE.Models" %>

<%
    string productName = SettingsManager.ContextSettings["Label.ProductName"];
    bool enableOrderForm = SettingsManager.ContextSettings["Order.enableOrderForm", true];

    List<SeminarDateGroup> seminarGroups = Model.Locations.AllSeminars.GroupBy(s => s.SeminarDate, s => s, (d, s) => new SeminarDateGroup
    {
        CommonDate = d,
        SeminarGroup = s.ToList()
    }).ToList();

    bool hasSeminars = seminarGroups.Count() > 0;

    string guidebookBox = @"<div class=""guidebook-box""><b><em>FREE</em> TAX LIEN</b> Masterclass Guidebook</div>";

    if (hasSeminars && enableOrderForm)
    {
        %>
            <form action="/<%= DtmContext.OfferCode %>/<%= DtmContext.Version %>/<%= DtmContext.PageCode %><%= DtmContext.ApplicationExtension %>" method="post" class="view checkout element-controller" data-validate-common-form>
                <input type="hidden" name="OrderType" value="None" />
                <input type="hidden" name="BillingCountry" id="BillingCountry" value="USA" />

                <div id="register" class="view__anchor"></div>
                <div class="checkout__group">
                    <div class="checkout__take-all checkout__copy">
                        <div class="location-badge">
                            <div class="location-badge__icon">
                                <svg class="icon icon-location"><use href="#location"></use></svg>
                            </div>
                            <div class="location-badge__text">
                                <div class="location-badge__title">Coming to the</div>
                                <b class="location-badge__location"><%= Model.SeminarDetails.AreaName %></b>
                                <div class="location-badge__dates"><%= Model.SeminarDetails.Dates %></div>
                            </div>
                        </div>

                        <%= guidebookBox %>

                        <script>_AdaErrors = false;</script>
                        <div role="alert" class="vse" data-vse-scroll>
                            <%= Html.ValidationSummary("The following errors have occurred:") %>
                        </div>

                        <fieldset id="register-fieldset-1" class="checkout__take-all element-controller__element" data-element-controller-name="register-next-1">
                            <div class="fieldset fieldset--frame">
                                <div class="fieldset__group">
                                    <h2 class="fieldset__take-all fieldset__title"><b>Step 1:</b> Choose Your Location</h2>
                                    <div class="fieldset__take-all radio-group message">
                                        <div class="radio-group__group message__select">
                                            <%
                                            seminarGroups.ForEach(seminarGroup =>
                                            {
                                                string dateFormat = seminarGroup.CommonDate.ToString("dddd, MMMM dd, yyyy");
                                                %>
                                                <div class="radio-group__take-all">
                                                    <b class="radio-group__date"><%= dateFormat %></b>
                                                    <%
                                                    seminarGroup.SeminarGroup.ForEach(seminar =>
                                                    {
                                                        SeminarTimeViewData seminarTime = seminar.SeminarTimes.FirstOrDefault();
                                                        string productCode = seminarTime.ProductCode ?? string.Empty;

                                                        string inputId = string.Format("ActionCode0-{0}", productCode);
                                                        string labelId = string.Format("Label-{0}", inputId);
                                                        %>
                                                        <div class="radio-group__radio form form--radio">
		                                                    <div class="form__radio-label">
			                                                    <input
				                                                    type="radio"
				                                                    id="<%= inputId %>"
				                                                    name="ActionCode0"
                                                                    required
                                                                    value="<%= productCode %>"
				                                                    aria-labelledby="<%= labelId %>" />
			                                                    <label for="<%= inputId %>" class="form__label">
				                                                    <span class="form__radio"></span>
				                                                    <span id="<%= labelId %>">
                                                                        <%
                                                                            string timeFormat = seminarTime.TimeFormat.ToString("h:mm tt");
                                                                        %>
                                                                        <%= timeFormat %> - <%= seminar.SeminarLocation %><br /><%= seminar.Street.Replace(",", string.Empty) %>, <%= seminar.City %>, <%= seminar.State %> <%= seminar.Zip %>

				                                                    </span>
			                                                    </label>
		                                                    </div>
		                                                </div>
                                                        <%
                                                    });  
                                                    %>
                                                </div>                                        
                                                <%
                                            });
                                            %>
                                        </div>
                                        <div class="message__group" role="alert">
				                            <span id="action-code-error-message" class="message__invalid">Please select an event date</span>
			                            </div>
                                    </div>
                                </div>
                            </div>
                    
                            <div class="checkout__actions">
                                <div class="checkout__next-action">
                                    <a id="register-next-1" href="#register-fieldset-2" aria-controls="register-fieldset-2" data-fieldset-navigator="next" class="element-controller__controller button">
                                        <span>Next</span>
                                    </a>
                                </div>
                            </div>
                        </fieldset>

                        <fieldset id="register-fieldset-2" class="checkout__take-all element-controller__element">
                            <div class="fieldset fieldset--frame">
                                <div class="fieldset__group">
                                    <h2 class="fieldset__take-all fieldset__title"><b>Step 2:</b> Register</h2>
                                    <div class="fieldset__take-all">
                                    <%
                                        SocialMediaAutofillChecker socialMediaAutofillChecker = ViewData["SocialMediaAutofillChecker"] as SocialMediaAutofillChecker ?? new SocialMediaAutofillChecker();

                                        if (socialMediaAutofillChecker.HasSocialAutofill) {
                                    %>
                                            <div class="fieldset__group fieldset__container fieldset__line-break">
                                                <div class="fieldset__take-all">
                                                    <h3 class="fieldset__headline">Autofill with your social media profile</h3>
                                                    <div data-social-autofill-fb></div>
                                                </div>
                                                <div class="fieldset__take-all social social--autofill">
                                                    <ul class="social__group">
                                                        <% if (socialMediaAutofillChecker.IsLinkedInConfigured) { %>
                                                        <li id="LinkedInSignIn" class="social__item">
                                                            <button type="button" href="#LinkedInSignIn" aria-label="LinkedIn" title="LinkedIn Sign In is not available" class="social__button social social__linkedin social-media-linkedin">
                                                                <svg class="social__icon"><use href="#icon-linkedin"></use></svg>
                                                            </button>
                                                        </li>
                                                        <% } %>
                                                        <% if (socialMediaAutofillChecker.IsFacebookConfigured) { %>
                                                        <li id="FacebookSignIn" class="social__item">
                                                            <button type="button" href="#FacebookSignIn" aria-label="Facebook" title="Facebook Sign In is not available" class="social__button social social__facebook social-media-facebook">
                                                                <svg class="social__icon"><use href="#icon-facebook"></use></svg>
                                                            </button>
                                                        </li>
                                                        <% } %>
                                                        <% if (socialMediaAutofillChecker.IsGooglePlusConfigured) { %>
                                                        <li id="GoogleSignIn" class="social__item">
											                <div class="social__button social-media-gplus social__item" data-gsi-container-id="GSIButtonContainer">
	                                                            <svg class="social__icon" id="icon-google" viewBox="0 0 32 32">
													                <path fill="#fbbc05" style="fill: var(--color1, #fbbc05)" d="M7.333 16c0-0.933 0.133-1.867 0.467-2.733l-4.933-3.8c-1 2-1.533 4.2-1.533 6.533s0.533 4.533 1.533 6.467l4.933-3.8c-0.333-0.8-0.467-1.733-0.467-2.667z"></path>
													                <path fill="#ea4335" style="fill: var(--color2, #ea4335)" d="M16 7.333c2.067 0 3.933 0.733 5.4 1.933l4.267-4.267c-2.6-2.267-5.933-3.667-9.667-3.667-5.8 0-10.8 3.333-13.133 8.2l4.933 3.8c1.133-3.533 4.333-6 8.2-6z"></path>
													                <path fill="#34a853" style="fill: var(--color3, #34a853)" d="M20.867 23.4c-1.333 0.867-3 1.267-4.867 1.267-3.867 0-7.067-2.467-8.2-5.933l-4.933 3.8c2.333 4.8 7.333 8.133 13.133 8.133 3.6 0 7-1.267 9.533-3.667l-4.667-3.6z"></path>
													                <path fill="#4285f4" style="fill: var(--color4, #4285f4)" d="M26.533 26c0.133-0.2 0.267-0.333 0.467-0.533 0 0 0 0 0 0 0.133-0.2 0.267-0.333 0.4-0.533 0 0 0 0 0 0 0.133-0.2 0.267-0.333 0.333-0.533 0 0 0 0 0-0.067 0.133-0.2 0.2-0.4 0.333-0.533 0 0 0-0.067 0.067-0.067 0.133-0.2 0.2-0.4 0.267-0.533 0 0 0-0.067 0.067-0.067 0.067-0.2 0.2-0.4 0.267-0.533 0-0.067 0.067-0.067 0.067-0.133 0.067-0.2 0.133-0.4 0.2-0.533 0-0.067 0.067-0.067 0.067-0.133 0.067-0.2 0.133-0.4 0.2-0.533 0-0.067 0.067-0.133 0.067-0.2 0.067-0.2 0.133-0.333 0.133-0.533 0-0.067 0.067-0.133 0.067-0.2 0.067-0.2 0.067-0.333 0.133-0.533 0-0.067 0.067-0.133 0.067-0.267 0.067-0.2 0.067-0.333 0.067-0.533 0-0.067 0-0.2 0.067-0.267 0-0.2 0.067-0.4 0.067-0.533 0-0.067 0-0.2 0-0.267 0-0.2 0-0.4 0.067-0.6 0-0.067 0-0.133 0-0.267 0-0.267 0-0.6 0-0.867 0-0.867-0.133-1.8-0.333-2.667h-13.667v5.667h7.867c-0.067 0.267-0.133 0.467-0.2 0.667 0 0.067-0.067 0.133-0.067 0.2-0.067 0.133-0.133 0.333-0.2 0.467 0 0.067-0.067 0.133-0.067 0.133-0.067 0.133-0.133 0.333-0.2 0.467 0 0.067-0.067 0.067-0.067 0.133-0.067 0.133-0.2 0.267-0.267 0.467 0 0.067-0.067 0.067-0.067 0.133-0.133 0.133-0.2 0.267-0.333 0.4 0 0-0.067 0.067-0.067 0.067-0.133 0.133-0.267 0.267-0.4 0.4 0 0 0 0-0.067 0.067-0.133 0.133-0.333 0.267-0.467 0.4 0 0 0 0 0 0-0.2 0.133-0.333 0.267-0.533 0.4v0l4.667 3.6c0 0 0 0 0 0 0.2-0.133 0.333-0.333 0.467-0.467 0 0 0 0 0 0 0.2-0.4 0.333-0.533 0.533-0.733 0 0 0 0 0 0z"></path>
												                </svg>
												                <div id="GSIButtonContainer" class="social__button-mask"></div>
											                </div>
                                                        </li>
                                                        <% } %>
                                                    </ul>
                                                </div>
                                            </div>
                                    <% } %>
                                    </div>
                                </div>

                                <div class="fieldset__group fieldset__container">
                                    <h3 class="fieldset__take-all fieldset__headline">Attendee Information</h3>

                                    <!-- First Name -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var billingFirstNameMessage = Html.ValidationMessageFor(m => m.BillingFirstName);
                                            var billingFirstNameIsInvalid = billingFirstNameMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" title="First name can only contain letter characters" required autocomplete="section-bill billing given-name" name="BillingFirstName" id="BillingFirstName" placeholder="First Name" class="dtm__restyle form__field <%= billingFirstNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingFirstName"] %>">
                                            <label for="BillingFirstName" class="message__label">
                                                <span class="form__error">* </span>First Name
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (billingFirstNameIsInvalid)
                                                        { %>
                                                    <%= billingFirstNameMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter a first name.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Last Name -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var billingLastNameMessage = Html.ValidationMessageFor(m => m.BillingLastName);
                                            var billingLastNameIsInvalid = billingLastNameMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="BillingLastName" id="BillingLastName" placeholder="Last Name" required autocomplete="section-bill billing family-name" class="dtm__restyle form__field <%= billingLastNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingLastName"] %>">
                                            <label for="BillingLastName" class="message__label">
                                                <span class="form__error">* </span>Last Name
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (billingLastNameIsInvalid)
                                                        { %>
                                                    <%= billingLastNameMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter a last name.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Phone -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var phoneMessage = Html.ValidationMessageFor(m => m.Phone);
                                            var phoneIsInvalid = phoneMessage != null;

                                            string[] phoneCode = (Model.SeminarDetails != null
                                                && Model.SeminarDetails.AdditionalInfo != null
                                                && !string.IsNullOrWhiteSpace(Model.SeminarDetails.AdditionalInfo)
                                                && Model.SeminarDetails.AdditionalInfo.Contains(",")
                                                ? Model.SeminarDetails.AdditionalInfo : ",").Split(',');
                                        %>
                                        <div class="form__field-label">
                                            <input type="tel" name="Phone" id="Phone" placeholder="Phone" required aria-describedby="PhoneDescription" autocomplete="section-bill billing tel" class="dtm__restyle form__field <%= phoneIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["Phone"] %>">
                                            <label for="Phone" class="message__label">
                                                <span class="form__error">* </span>Phone
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (phoneIsInvalid)
                                                    { %>
                                                    <%= phoneMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter a phone number.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Email -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var emailMessage = Html.ValidationMessageFor(m => m.Email);
                                            var emailIsInvalid = emailMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="email" name="Email" id="Email" title="Format example: someone@someplace.com" required autocomplete="section-bill billing email" placeholder="Email" class="dtm__restyle form__field <%= emailIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["Email"] %>">
                                            <label for="Email" class="message__label">
                                                <span class="form__error">* </span>Email
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (emailIsInvalid)
                                                    { %>
                                                    <%= emailMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter an email address.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>

                                    <!-- Notification -->
                                    <div class="fieldset__take-all form message message--checkbox">
                                        <div class="form__checkbox-label">
                                            <input
                                                type="checkbox"
                                                id="CONTACTCONSENT"
                                                aria-labelledby="CONTACTCONSENTLabel" 
                                                name="QuestionCodeCONTACTCONSENT"
                                                required
                                                />
                                            <label for="CONTACTCONSENT" class="form__label">
                                                <span class="form__checkbox"></span>
                                                <%
                                                    NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;
                                                    
                                                    Func<NavigationItem, string> createAttributeList = ((NavigationItem item) =>
                                                    {
                                                        // define attributes for the link
                                                        string attributeList = string.Format(@"id=""checkbox-link-{0}"" href=""{1}""", item.Id, item.Page);

                                                        // add attributes to operate a modal-dialog link
                                                        if (item.IsModalDialog && !sitemap.IsOnSamePage(item.PageCode))
                                                        {
                                                            attributeList = string.Format(@"{0} data-modal-dialog-id=""checkbox-url-{1}"" data-modal-dialog-actor=""open"" data-modal-dialog-iframe=""{3}"" data-modal-dialog-template-modifier=""terms"" data-modal-dialog-title=""{2}""", 
                                                                attributeList, item.Id, item.Name, item.Route
                                                            );
                                                        }

                                                        return attributeList;
                                                    });

                                                    NavigationItem terms = sitemap.GetItemById("terms");
                                                    string termsAttributeList = createAttributeList(terms);

                                                    NavigationItem privacy = sitemap.GetItemById("privacy");
                                                    string privacyAttributeList = createAttributeList(privacy);
 
                                                    string customerServicePhone = SettingsManager.ContextSettings["CustomerService.PhoneNumber"];
                                                %>
                                                <span id="CONTACTCONSENTLabel">By checking this box, I expressly authorize Tax Lien Code to send me emails and text messages about its products and services using automated technology to the email address/phone number provided on the form above. This consent is not required to obtain our goods and services. Contact us at <a href="tel:<%= customerServicePhone %>"><%= customerServicePhone %></a> if you prefer not to use this form to receive this offer. You may opt-out at any time. Use is subject to our <a <%= termsAttributeList %>>Terms</a> and <a <%= privacyAttributeList %>>Privacy</a>.</span>
                                            </label>
                                            <div role="alert" class="message__group">
                                                <div class="message__invalid">Please accept the terms & conditions.</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    
                            <div class="checkout__actions">
                                <div class="checkout__prev-action">
                                    <a href="#register-fieldset-1" aria-controls="register-fieldset-1" data-fieldset-navigator="prev" class="element-controller__controller">
                                        <span>Back</span>
                                    </a>
                                </div>

                                <div class="checkout__next-action">
                                    <a href="#register-fieldset-3" aria-controls="register-fieldset-3" data-fieldset-navigator="next" class="element-controller__controller button">
                                        <span>Next</span>
                                    </a>
                                </div>
                            </div>
                        </fieldset>

                        <fieldset id="register-fieldset-3" class="element-controller__element">
                            <div class="fieldset fieldset--frame">
                                <div class="fieldset__group">
                                    <h2 class="fieldset__take-all fieldset__title"><b>Step 3:</b> Bring a Guest</h2>
                                    <div class="fieldset__take-all ">
                                        <div class="fieldset__container fieldset__line-break">
                                            <h3 class="fieldset__headline">Not Required, But Suggested</h3>
                                        </div>
                                    </div>
                                    <div class="fieldset__take--all">
                                        <div class="fieldset__group fieldset__container">
                                            <h3 class="fieldset__take-all fieldset__headline">Guest Information</h3>

                                            <!-- First Name -->
                                            <div class="fieldset__take-all form message">
                                                <div class="form__field-label">
                                                    <%
                                                        var guestFirstNameMessage = Html.ValidationMessage("GuestFirstName");
                                                        var guestFirstNameIsInvalid = guestFirstNameMessage != null;
                                                    %>
                                                    <input type="text" title="First name can only contain letter characters" data-required="true" autocomplete="section-bill billing given-name" name="GuestFirstName" id="GuestFirstName" placeholder="First Name" class="dtm__restyle form__field <%= guestFirstNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["GuestFirstName"] %>">
                                                    <label for="GuestFirstName" class="message__label">First Name</label>
                                                    <span class="message__group" role="alert">
                                                        <span class="message__invalid">
                                                            <% if (guestFirstNameIsInvalid)
                                                                { %>
                                                            <%= guestFirstNameMessage %>
                                                            <% }
                                                            else
                                                            { %>
                                                            Please enter a first name.
                                                        <% } %>
                                                        </span>
                                                    </span>
                                                </div>
                                            </div>
                
                                            <!-- Last Name -->
                                            <div class="fieldset__take-all form message">
                                                <%
                                                    var guestLastNameMessage = Html.ValidationMessage("GuestLastName");
                                                    var guestLastNameIsInvalid = guestLastNameMessage != null;
                                                %>
                                                <div class="form__field-label">
                                                    <input type="text" name="GuestLastName" id="GuestLastName" placeholder="Last Name" data-required="true" autocomplete="section-bill billing family-name" class="dtm__restyle form__field <%= guestLastNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["GuestLastName"] %>">
                                                    <label for="GuestLastName" class="message__label">Last Name</label>
                                                    <span class="message__group" role="alert">
                                                        <span class="message__invalid">
                                                            <% if (guestLastNameIsInvalid)
                                                                { %>
                                                            <%= guestLastNameMessage %>
                                                            <% }
                                                            else
                                                            { %>
                                                            Please enter a last name.
                                                        <% } %>
                                                        </span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="checkout__actions">
                                <div class="checkout__prev-action">
                                    <a href="#register-fieldset-2" aria-controls="register-fieldset-2" data-fieldset-navigator="prev" class="element-controller__controller">
                                        <span>Back</span>
                                    </a>
                                </div>
                                <div class="checkout__next-action">
                                    <button type="submit" id="AcceptOfferButton" name="acceptOffer" class="button">
                                        <span>Sign Up Now!</span>
                                    </button>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>
            </form>
        <%
    } else
    {
        var context = EcommerceDataContextManager.Current;
        var rootLinks = DtmContext.CampaignOfferVersions.Where(cov => !cov.IsDefault && cov.OfferCode != DtmContext.OfferCode).Select(cov => new
        {
            Path = string.Format("/?o={0}", cov.OfferCode),
            Name = cov.OfferName,
            Seminars = context.Seminars.Where(s => s.CampaignOfferVersionID == cov.OfferVersionId && s.EndDate >= DateTime.Now).OrderBy(s => s.EndDate).ToList()
        }).ToList();
        %>
        <div class="view checkout">
        <div id="register" class="view__anchor"></div>
        <div class="checkout__group">
            <div class="checkout__take-all checkout__copy">
                <div class="location-badge">
                    <div class="location-badge__icon">
                        <svg class="icon icon-location"><use href="#location"></use></svg>
                    </div>
                    <div class="location-badge__text">
                        <div class="location-badge__title">First, Select</div>
                        <b class="location-badge__location">A City Below</b>
                    </div>
                </div>
                <%= guidebookBox %>
                <nav class="fieldset fieldset--frame">
                    <div class="fieldset__group">
                        <h2 class="fieldset__take-all fieldset__title">Available Cities</h2>
                        <div class="fieldset__take-all root-links">
                        <% 
                            rootLinks.ForEach(rootLink =>
                           {
                        %>
                            <div class="root-links__item">
                                <a href="<%= rootLink.Path %>" class="root-links__link">Visit <%= rootLink.Name %></a>

                                <% 
                                if (rootLink.Seminars.Any())
                                {
                                %>
                                <span class="root-links__spots-count">With <%= rootLink.Seminars.Count() %> upcoming events</span>
                                <%
                                    var earliestSeminar = rootLink.Seminars.OrderBy(p => p.SeminarDate).FirstOrDefault();
                                    
                                    if (earliestSeminar != null)
                                    {
                                        var seminarTime = earliestSeminar.SeminarTimes.FirstOrDefault();    
                                        
                                        string dateFormat = earliestSeminar.SeminarDate.ToString("dddd, MMMM dd, yyyy");
                                        string timeFormat = seminarTime.CampaignProduct.EventDate.Value.ToString("h:mm tt") ?? String.Empty;      
                                        %>
                                        <span class="root-links__next-event-header">Next Event</span>
                                        <span class="root-links__earliest-event">
                                            <%= dateFormat %><br />
                                            <%= timeFormat %> - <%= earliestSeminar.SeminarLocation ?? String.Empty %><br /><%= (earliestSeminar.Street ?? String.Empty).Replace(",", string.Empty) %>, <%= earliestSeminar.City ?? String.Empty %>, <%= earliestSeminar.State ?? String.Empty %> <%= earliestSeminar.Zip ?? String.Empty %>
                                        </span>
                                        <%
                                    }
                                %>
                                <%
                                } 
                                else
                                {
                                %>
                                <span class="root-links__spots-count">There are no upcoming events</span>
                                <%
                                }
                                %>
                            </div>
                        <%
                           }); 
                        %>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        </div>
        <%
    }
%>
