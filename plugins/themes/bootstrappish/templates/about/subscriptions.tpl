{**
 * templates/about/subscriptions.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal Subscriptions.
 *
 *}
{strip}
{assign var="pageTitle" value="about.subscriptions"}
{include file="common/header.tpl"}
{/strip}

<div id="subscriptionsContact" class="col-md-12 mag-innert-left">
	<h3>{translate key="about.subscriptionsContact"}</h3>
	<p class="text">
		{if !empty($subscriptionName)}
			<strong>{$subscriptionName|escape}</strong><br />
		{/if}
		{if !empty($subscriptionMailingAddress)}
			{$subscriptionMailingAddress|nl2br}<br />
		{/if}
		{if !empty($subscriptionPhone)}
			{translate key="user.phone"}: {$subscriptionPhone|escape}<br />
		{/if}
		{if !empty($subscriptionFax)}
			{translate key="user.fax"}: {$subscriptionFax|escape}<br />
		{/if}
		{if !empty($subscriptionEmail)}
			{translate key="user.email"}: {mailto address=$subscriptionEmail|escape encode="hex"}<br /><br />
		{/if}
		{if !empty($subscriptionAdditionalInformation)}
			{$subscriptionAdditionalInformation|nl2br}<br />
		{/if}
		{if $acceptGiftSubscriptionPayments}
			{translate key="gifts.giftSubscriptionsAvailable"}&nbsp;
			<a href="{url page="gifts" op="purchaseGiftSubscription"}">{translate key="gifts.purchaseGiftSubscription"}</a>
		{/if}
	</p>
</div>

<a name="subscriptionTypes" id="subscriptionTypes"></a>
{if !$individualSubscriptionTypes->wasEmpty()}
	<h3>{translate key="about.subscriptions.individual"}</h3>
	<p class="text">{translate key="subscriptions.individualDescription"}</p>
	<div class="table-responsive">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>{translate key="about.subscriptionTypes.name"}</th>
					<th>{translate key="about.subscriptionTypes.format"}</th>
					<th>{translate key="about.subscriptionTypes.duration"}</th>
					<th>{translate key="about.subscriptionTypes.cost"}</th>
				</tr>
			</thead>
			<tbody>
			{iterate from=individualSubscriptionTypes item=subscriptionType}
				<tr>
					<td><strong>{$subscriptionType->getSubscriptionTypeName()|escape}</strong><br />{$subscriptionType->getSubscriptionTypeDescription()|nl2br}</td>
					<td>{translate key=$subscriptionType->getFormatString()}</td>
					<td>{$subscriptionType->getDurationYearsMonths()|escape}</td>
					<td>{$subscriptionType->getCost()|string_format:"%.2f"}&nbsp;({$subscriptionType->getCurrencyStringShort()|escape})</td>
				</tr>
			{/iterate}
			</tbody>
		</table>
	</div>
	<br />
{/if}

{if !$institutionalSubscriptionTypes->wasEmpty()}
	<h3>{translate key="about.subscriptions.institutional"}</h3>
	<p class="text">{translate key="subscriptions.institutionalDescription"}</p>
	<div class="table-responsive">
		<table class="table table-striped">
			<thead>
				<tr>
					<th>{translate key="about.subscriptionTypes.name"}</th>
					<th>{translate key="about.subscriptionTypes.format"}</th>
					<th>{translate key="about.subscriptionTypes.duration"}</th>
					<th>{translate key="about.subscriptionTypes.cost"}</th>
				</tr>
			</thead>
			<tbody>
			{iterate from=institutionalSubscriptionTypes item=subscriptionType}
				<tr>
					<td><strong>{$subscriptionType->getSubscriptionTypeName()|escape}</strong><br />{$subscriptionType->getSubscriptionTypeDescription()|nl2br}</td>
					<td>{translate key=$subscriptionType->getFormatString()}</td>
					<td>{$subscriptionType->getDurationYearsMonths()|escape}</td>
					<td>{$subscriptionType->getCost()|string_format:"%.2f"}&nbsp;({$subscriptionType->getCurrencyStringShort()|escape})</td>
				</tr>
			{/iterate}
			</tbody>
		</table>
	</div>
{/if}

{include file="common/footer.tpl"}