{**
 * templates/subscription/subscriptionTypeForm.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subscription type form under journal management.
 *
 *}
{strip}
{if $typeId}
{assign var="pageTitle" value="manager.subscriptionTypes.edit"}

{else}
	{assign var="pageTitle" value="manager.subscriptionTypes.create"}
{/if}
{assign var="pageId" value="manager.subscriptionTypes.subscriptionTypeForm"}
{assign var="pageCrumbTitle" value=$subscriptionTypeTitle}
{include file="common/header.tpl"}
{/strip}

{if $subscriptionTypeCreated}
	<br/>
	{translate key="manager.subscriptionTypes.subscriptionTypeCreatedSuccessfully"}<br />
{/if}

<br/>

<form role="form" id="subscriptionType" method="post" action="{url op="updateSubscriptionType"}">
	
	{if $typeId}
		<input type="hidden" name="typeId" value="{$typeId|escape}" />
	{/if}

	{include file="common/formErrors.tpl"}
	
	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			{if count($formLocales) > 1}
				<tr valign="top">
					<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
					<td width="80%" class="value">
						{if $typeId}{url|assign:"subscriptionTypeUrl" op="editSubscriptionType" path=$typeId escape=false}
						{else}{url|assign:"subscriptionTypeUrl" op="createSubscriptionType" escape=false}
						{/if}
						{form_language_chooser form="subscriptionType" url=$subscriptionTypeUrl}
						<p class="help-block">{translate key="form.formLanguage.description"}</p>
					</td>
				</tr>
			{/if}
			<tr valign="top">
				<td width="20%">{fieldLabel name="name" required="true" key="manager.subscriptionTypes.form.typeName"}</td>
				<td width="80%" class="value"><div class="form-group"><input type="text" name="name[{$formLocale|escape}]" value="{$name[$formLocale]|escape}" size="35" maxlength="80" id="name" class="form-control" /></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="description" key="manager.subscriptionTypes.form.description"}</td>
				<td class="value"><div class="form-group"><textarea name="description[{$formLocale|escape}]" id="description" cols="40" rows="4" class="form-control">{$description[$formLocale]|escape}</textarea></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="cost" required="true" key="manager.subscriptionTypes.form.cost"}</td>
				<td class="value">
					<div class="form-group">
						<input type="text" name="cost" value="{$cost|escape}" size="5" maxlength="10" id="cost" class="form-control" />
						<br />
						<p class="help-block">{translate key="manager.subscriptionTypes.form.costInstructions"}</p>
					</div>
				</td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="currency" required="true" key="manager.subscriptionTypes.form.currency"}</td>
				<td><div class="form-group"><select name="currency" id="currency" class="form-control">{html_options options=$validCurrencies selected=$currency}</select></div></td>
			</tr>
			<tr valign="top">
				<td>{fieldLabel name="format" required="true" key="manager.subscriptionTypes.form.format"}</td>
				<td><div class="form-group"><select id="format" name="format" class="form-control">{html_options options=$validFormats selected=$format}</select></div></td>
			</tr>
			{if !$typeId}
				<tr valign="top">
					<td>{fieldLabel name="duration" required="true" key="manager.subscriptionTypes.form.duration"}</td>
					<td class="value">
						<div class="form-group"><input type="radio" name="nonExpiring" id="nonExpiring-0" value="0"{if !$nonExpiring} checked="checked"{/if} />&nbsp;{translate key="manager.subscriptionTypes.form.nonExpiring.expiresAfter"} </div><div class="form-group"><input type="text" name="duration" value="{$duration|escape}" size="5" maxlength="10" id="duration" class="form-control" /> {translate key="manager.subscriptionTypes.form.nonExpiring.months"}</div>
					</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<div class="form-group"><input type="radio" name="nonExpiring" id="nonExpiring-1" value="1"{if $nonExpiring} checked="checked"{/if} />&nbsp;{translate key="manager.subscriptionTypes.form.nonExpiring.neverExpires"}</div>
					</td>
				</tr>
			{elseif $typeId && !$nonExpiring}
				<tr valign="top">
					<td>{fieldLabel name="duration" required="true" key="manager.subscriptionTypes.form.duration"}</td>
					<td class="value">
						<div class="form-group">
							<input type="text" name="duration" value="{$duration|escape}" size="5" maxlength="10" id="duration" class="form-control" />
							<br />
							<p class="help-block">{translate key="manager.subscriptionTypes.form.durationInstructions"}</p>
						</div>
					</td>
				</tr>
			{/if}
			{if !$typeId}
				<tr valign="top">
					<td>{fieldLabel name="subscriptions" key="manager.subscriptionTypes.form.subscriptions"}</td>
					<td class="value">
						<div class="form-group"><input type="radio" name="institutional" id="institutional-0" value="0"{if !$institutional} checked="checked"{/if} />&nbsp;{translate key="manager.subscriptionTypes.form.individual"}</div>
					</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value">
						<div class="form-group"><input type="radio" name="institutional" id="institutional-1" value="1"{if $institutional} checked="checked"{/if} />&nbsp;{translate key="manager.subscriptionTypes.form.institutional"}</div>
					</td>
				</tr>
			{/if}
			<tr valign="top">
				<td>{fieldLabel name="options" key="manager.subscriptionTypes.form.options"}</td>
				<td class="value">
					<div class="form-group"><input type="checkbox" name="membership" id="membership" value="1"{if $membership} checked="checked"{/if} />&nbsp;{fieldLabel name="membership" key="manager.subscriptionTypes.form.membership"}</div>
				</td>
			</tr>
			<tr valign="top">
				<td>&nbsp;</td>
				<td class="value">
					<div class="form-group"><input type="checkbox" name="disable_public_display" id="disable_public_display" value="1"{if $disable_public_display} checked="checked"{/if} />&nbsp;{fieldLabel name="disable_public_display" key="manager.subscriptionTypes.form.public"}</div>
				</td>
			</tr>
		</table>
	</div>

	<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> {if not $typeId}<input type="submit" name="createAnother" value="{translate key="manager.subscriptionTypes.form.saveAndCreateAnotherType"}" class="btn btn-success" /> {/if}<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="subscriptionTypes" escape=false}'" /></p>
</form>

<p class="help-block">{translate key="common.requiredField"}</p>

{include file="common/footer.tpl"}