{**
 * templates/about/contact.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * About the Journal / Journal Contact.
 *
 *}
{strip}
{assign var="pageTitle" value="about.journalContact"}
{include file="common/header.tpl"}
{/strip}

<div class="col-md-12 mag-innert-left">
	<div id="contact" class="col-md-12 contact-in">
		{if !empty($journalSettings.mailingAddress)}
			<div id="mailingAddress" class="more-address">
				<h5>{translate key="common.mailingAddress"}</h5>
				<p class="para1">{$journalSettings.mailingAddress|nl2br}</p>
			</div>
		{/if}

		{if not ($currentJournal->getLocalizedSetting('contactTitle') == '' && $currentJournal->getLocalizedSetting('contactAffiliation') == '' && $currentJournal->getLocalizedSetting('contactMailingAddress') == '' && empty($journalSettings.contactPhone) && empty($journalSettings.contactFax) && empty($journalSettings.contactEmail))}
			<div id="principalContact" class="more-address">
				<h5>{translate key="about.contact.principalContact"}</h5>
				<p class="para1">
					{if !empty($journalSettings.contactName)}
						<strong>{$journalSettings.contactName|escape}</strong><br />
					{/if}

					{assign var=s value=$currentJournal->getLocalizedSetting('contactTitle')}
					{if $s}{$s|escape}<br />{/if}

					{assign var=s value=$currentJournal->getLocalizedSetting('contactAffiliation')}
					{if $s}{$s|escape}<br />{/if}

					{assign var=s value=$currentJournal->getLocalizedSetting('contactMailingAddress')}
					{if $s}{$s|nl2br}<br />{/if}

					{if !empty($journalSettings.contactPhone)}
						{translate key="about.contact.phone"}: {$journalSettings.contactPhone|escape}<br />
					{/if}
					{if !empty($journalSettings.contactFax)}
						{translate key="about.contact.fax"}: {$journalSettings.contactFax|escape}<br />
					{/if}
					{if !empty($journalSettings.contactEmail)}
						{translate key="about.contact.email"}: {mailto address=$journalSettings.contactEmail|escape encode="hex"}<br />
					{/if}
				</p>
			</div>
		{/if}

		{if not (empty($journalSettings.supportName) && empty($journalSettings.supportPhone) && empty($journalSettings.supportEmail))}
			<div id="supportContact" class="more-address">
				<h5>{translate key="about.contact.supportContact"}</h5>
				<p class="para1">
					{if !empty($journalSettings.supportName)}
						<strong>{$journalSettings.supportName|escape}</strong><br />
					{/if}
					{if !empty($journalSettings.supportPhone)}
						{translate key="about.contact.phone"}: {$journalSettings.supportPhone|escape}<br />
					{/if}
					{if !empty($journalSettings.supportEmail)}
						{translate key="about.contact.email"}: {mailto address=$journalSettings.supportEmail|escape encode="hex"}<br />
					{/if}
				</p>
			</div>
		{/if}
	</div>
</div>

{include file="common/footer.tpl"}