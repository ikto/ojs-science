{**
 * templates/subscription/institutionalSubscriptions.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Display list of institutional subscriptions in journal management.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.institutionalSubscriptions"}
{assign var="pageId" value="manager.institutionalSubscriptions"}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
	<ul class="stay">
		<li><a href="{url op="subscriptionsSummary"}">{translate key="manager.subscriptions.summary"}</a></li>
		<li><a href="{url op="subscriptions" path="individual"}">{translate key="manager.individualSubscriptions"}</a></li>
		<li class="current"><a href="{url op="subscriptions" path="institutional"}">{translate key="manager.institutionalSubscriptions"}</a></li>
		<li><a href="{url op="subscriptionTypes"}">{translate key="manager.subscriptionTypes"}</a></li>
		<li><a href="{url op="subscriptionPolicies"}">{translate key="manager.subscriptionPolicies"}</a></li>
		<li><a href="{url op="payments"}">{translate key="manager.payments"}</a></li>
	</ul>

	<form role="form" action="#">
		<ul class="stay">
			<li>{translate key="manager.subscriptions.withStatus"}: <div class="form-group"><select name="filterStatus" onchange="location.href='{url|escape:"javascript" path="institutional" searchField=$searchField searchMatch=$searchMatch search=$search dateSearchField=$dateSearchField dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth filterStatus="STATUS_ID" escape=false}'.replace('STATUS_ID', this.options[this.selectedIndex].value)" size="1" class="form-control">{html_options_translate options=$statusOptions selected=$filterStatus}</select></div></li>
		</ul>
	</form>

	{if !$dateFrom}
		{assign var="dateFrom" value="--"}
	{/if}

	{if !$dateTo}
		{assign var="dateTo" value="--"}
	{/if}

	<form role="form" class="form-inline" method="post" id="submit" action="{url op="subscriptions" path="institutional"}">
		<div class="form-group">
			<select name="searchField" size="1" class="form-control">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		</div>
		<div class="form-group">
			<select name="searchMatch" size="1" class="form-control">
				<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
				<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
				<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
			</select>
		</div>
		<div class="form-group"><input type="text" size="15" name="search" class="form-control" value="{$search|escape}" /></div>
		<br/>
		<div class="form-group">
			<select name="dateSearchField" size="1" class="form-control">
				{html_options_translate options=$dateFieldOptions selected=$dateSearchField}
			</select>
		</div>
		{translate key="common.between"}
		{html_select_date prefix="dateFrom" time=$dateFrom all_extra="class=\"form-control\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+5"}
		{translate key="common.and"}
		{html_select_date prefix="dateTo" time=$dateTo all_extra="class=\"form-control\"" year_empty="" month_empty="" day_empty="" start_year="-5" end_year="+5"}
		<input type="hidden" name="dateToHour" value="23" />
		<input type="hidden" name="dateToMinute" value="59" />
		<input type="hidden" name="dateToSecond" value="59" />
		<br/>
		<input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
	</form>

	<br />

	<div id="subscriptions" class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr>
				<td colspan="6" class="headseparator">&nbsp;</td>
			</tr>
			<tr class="heading" valign="bottom">
				<td width="30%"><label>{translate key="manager.subscriptions.institutionName"}</label></td>
				<td width="25%"><label>{translate key="manager.subscriptions.subscriptionType"}</label></td>
				<td width="10%"><label>{translate key="subscriptions.status"}</label></td>
				<td width="10%"><label>{translate key="manager.subscriptions.dateStart"}</label></td>
				<td width="10%"><label>{translate key="manager.subscriptions.dateEnd"}</label></td>
				<td width="15%"><label>{translate key="common.action"}</label></td>
			</tr>
			<tr>
				<td colspan="6" class="headseparator">&nbsp;</td>
			</tr>
			{iterate from=subscriptions item=subscription}
				{assign var=isNonExpiring value=$subscription->isNonExpiring()}
				<tr valign="top">
					<td>
						{assign var=emailString value=$subscription->getUserFullName()|concat:" <":$subscription->getUserEmail():">"}
						{url|assign:"redirectUrl" op="subscriptions" path="institutional" escape=false}
						{url|assign:"url" page="user" op="email" to=$emailString|to_array redirectUrl=$redirectUrl}
						{$subscription->getInstitutionName()|escape}&nbsp;{icon name="mail" url=$url}
					</td>
					<td>{$subscription->getSubscriptionTypeName()|escape}</td>
					<td>{$subscription->getStatusString()|escape}</td>
					<td>{if $isNonExpiring}&nbsp;{else}{if $subscription->isExpired()}<span class="help-block">{$subscription->getDateStart()|date_format:$dateFormatShort}</span>{else}{$subscription->getDateStart()|date_format:$dateFormatShort}{/if}{/if}</td>
					<td>{if $isNonExpiring}{translate key="subscriptionTypes.nonExpiring"}{else}{if $subscription->isExpired()}<span class="help-block">{$subscription->getDateEnd()|date_format:$dateFormatShort}</span>{else}{$subscription->getDateEnd()|date_format:$dateFormatShort}{/if}{/if}</td>
					<td><a href="{url op="editSubscription" path="institutional"|to_array:$subscription->getId()}" class="action">{translate key="common.edit"}</a>{if !$isNonExpiring}&nbsp;|&nbsp;<a href="{url op="renewSubscription" path="institutional"|to_array:$subscription->getId()}" class="action">{translate key="manager.subscriptions.renew"}</a>{/if}&nbsp;|&nbsp;<a href="{url op="deleteSubscription" path="institutional"|to_array:$subscription->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="manager.subscriptions.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
				</tr>
				<tr>
					<td colspan="6" class="{if $subscriptions->eof()}end{/if}separator">&nbsp;</td>
				</tr>
			{/iterate}
			{if $subscriptions->wasEmpty()}
				<tr>
					<td colspan="6" class="nodata"><p class="help-block">{translate key="manager.subscriptions.noneCreated"}</p></td>
				</tr>
				<tr>
					<td colspan="6" class="endseparator">&nbsp;</td>
				</tr>
			{else}
				<tr>
					<td colspan="2" align="left">{page_info iterator=$subscriptions}</td>
					<td colspan="4" align="right">{page_links anchor="subscriptions" name="subscriptions" iterator=$subscriptions searchField=$searchField searchMatch=$searchMatch search=$search dateSearchField=$dateSearchField dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth filterStatus=$filterStatus}</td>
				</tr>
			{/if}
		</table>
		<a href="{url op="selectSubscriber" path="institutional"}" class="action">{translate key="manager.subscriptions.create"}</a>
	</div>
</div>

{include file="common/footer.tpl"}