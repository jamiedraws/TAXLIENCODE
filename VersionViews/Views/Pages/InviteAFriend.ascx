<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Models.Ecommerce" %>

<%
	var showFormOnPageLoad = SettingsManager.ContextSettings["InviteAGuest.ShowFormOnPageLoad", false];
	var inviteHeaderImage = SettingsManager.ContextSettings["Email.HeaderImage", string.Empty];
	var inviteHeadline = SettingsManager.ContextSettings["InviteAGuest.Headline", "Tell your friends about attending"];
	var inviteSubheadline = SettingsManager.ContextSettings["InviteAGuest.Subheadline", "a Free Live Wealth Building Event!"];
	
	var inviteDescription = SettingsManager.ContextSettings["InviteAGuest.Description", "We'll send your friend an e-mail telling them about this event."];
	var inviteEmailTempPath = SettingsManager.ContextSettings["InviteAGuest.EmailTemplatePath", "/email/1/Invite"];
	var inviteSuccessMessage =  SettingsManager.ContextSettings["InviteAGuest.SuccessMessage", "Email sent!"];
	var inviteSuccessHeadline = SettingsManager.ContextSettings["InviteAGuest.SuccessHeadline", "Thank you!"];

	var inviteValidationStartEffect = SettingsManager.ContextSettings["InviteAGuest.ValidationStartEffect", "show"];
	var inviteValidationDuration = SettingsManager.ContextSettings["InviteAGuest.ValidationDuration", 400];
	var inviteValidationEasing = SettingsManager.ContextSettings["InviteAGuest.ValidationEasing", "swing"];
%>

<form 
	action="/AdditionalLeads/Index?oid=<%= ViewData["OrderId"] %>&r=<%= ViewData["ReferURL"] %>&f=<%= ViewData["FromAddress"] %>" 
	method="post"
	data-validate-form 
	data-message-status="Sending request"
	data-message-success="Your invitation has been submitted."
	data-message-error="There was a problem sending the request. Try again."
	>
	<%= Html.Hidden("oid", DtmContext.OrderId) %>
	<%= Html.Hidden("r", ViewData["ReferURL"]) %>
	<%= Html.Hidden("mode", "ajax") %>
	<%= Html.Hidden("t", inviteEmailTempPath) %>

	<fieldset class="fieldset">
		<div class="fieldset__group">
			<!-- First Name -->
			<div class="form message">
				<%
					var billingFirstNameMessage = Html.ValidationMessageFor(m => m.BillingFirstName);
					var billingFirstNameIsInvalid = billingFirstNameMessage != null;
				%>
				<div class="form__field-label">
					<input type="text" title="First name can only contain letter characters" data-required="true" autocomplete="section-bill billing given-name" name="FirstName" id="FirstName" placeholder="First Name" class="dtm__restyle form__field <%= billingFirstNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingFirstName"] %>">
					<label for="FirstName" class="message__label">
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
			<div class="form message">
				<%
					var billingLastNameMessage = Html.ValidationMessageFor(m => m.BillingLastName);
					var billingLastNameIsInvalid = billingLastNameMessage != null;
				%>
				<div class="form__field-label">
					<input type="text" name="LastName" id="LastName" placeholder="Last Name" data-required="true" autocomplete="section-bill billing family-name" class="dtm__restyle form__field <%= billingLastNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingLastName"] %>">
					<label for="LastName" class="message__label">
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

			<!-- Email -->
			<div class="form message">
				<%
					var emailMessage = Html.ValidationMessageFor(m => m.Email);
					var emailIsInvalid = emailMessage != null;
				%>
				<div class="form__field-label">
					<input type="email" name="Email" id="Email" title="Format example: someone@someplace.com" data-required="true" autocomplete="section-bill billing email" placeholder="Email" class="dtm__restyle form__field <%= emailIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["Email"] %>">
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

			<div class="fieldset__take-all">
				<button type="submit" id="AdditonalLeads" name="acceptOffer" data-validate-form-type="submit">
					<span class="button">
						<span>Invite</span>
					</span>
				</button>
			</div>
		</div>
	</fieldset>
</form>