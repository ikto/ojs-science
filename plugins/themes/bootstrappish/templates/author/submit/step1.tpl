{**
 * templates/author/submit/step1.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 1 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step1"}
{include file="author/submit/submitHeader.tpl"}

{if $journalSettings.supportPhone}
	{assign var="howToKeyName" value="author.submit.howToSubmit"}
{else}
	{assign var="howToKeyName" value="author.submit.howToSubmitNoPhone"}
{/if}

<p class="help-block">{translate key=$howToKeyName supportName=$journalSettings.supportName supportEmail=$journalSettings.supportEmail supportPhone=$journalSettings.supportPhone}</p>

<div class="separator"></div>

<form role="form" id="submit" method="post" action="{url op="saveSubmit" path=$submitStep}" onsubmit="return checkSubmissionChecklist()">
	
	{include file="common/formErrors.tpl"}
	
	{if $articleId}<input type="hidden" name="articleId" value="{$articleId|escape}" />{/if}

	{if count($sectionOptions) <= 1}
		<p class="help-block">{translate key="author.submit.notAccepting"}</p>
	{else}

	{if count($sectionOptions) == 2}
		{* If there's only one section, force it and skip the section parts
		   of the interface. *}
		{foreach from=$sectionOptions item=val key=key}
			<input type="hidden" name="sectionId" value="{$key|escape}" />
		{/foreach}
	{else}{* if count($sectionOptions) == 2 *}
		<div id="section" class="col-md-12 mag-innert-left">
			<h3>{translate key="author.submit.journalSection"}</h3>
			{url|assign:"url" page="about"}
			<p class="help-block">{translate key="author.submit.journalSectionDescription" aboutUrl=$url}</p>

			<input type="hidden" name="submissionChecklist" value="1" />

			<div class="table-responsive">
				<table class="table table-striped" width="100%">
					<tr valign="top">
						<td width="20%">{fieldLabel name="sectionId" required="true" key="section.section"}</td>
						<td width="80%" class="value"><div class="form-group"><select name="sectionId" id="sectionId" size="1" class="form-control">{html_options options=$sectionOptions selected=$sectionId}</select></div></td>
					</tr>
				</table>
			</div>
		</div>{* section *}

		<div class="separator"></div>

	{/if}{* if count($sectionOptions) == 2 *}

	{if count($supportedSubmissionLocaleNames) == 1}
		{* There is only one supported submission locale; choose it invisibly *}
		{foreach from=$supportedSubmissionLocaleNames item=localeName key=locale}
			<input type="hidden" name="locale" value="{$locale|escape}" />
		{/foreach}
	{else}
		{* There are several submission locales available; allow choice *}
		<div id="submissionLocale" class="col-md-12 mag-innert-left">
			<h3>{translate key="author.submit.submissionLocale"}</h3>
			<p class="help-block">{translate key="author.submit.submissionLocaleDescription"}</p>

			<div class="table-responsive">
				<table class="table table-striped" width="100%">
					<tr valign="top">
						<td width="20%">{fieldLabel name="locale" required="true" key="article.language"}</td>
						<td width="80%" class="value"><div class="form-group"><select name="locale" id="locale" size="1" class="form-control">{html_options options=$supportedSubmissionLocaleNames selected=$locale}</select></div></td>
					</tr>
				</table>
			</div>

			<div class="separator"></div>
		
		</div>{* submissionLocale *}
	{/if}{* count($supportedSubmissionLocaleNames) == 1 *}

	<script type="text/javascript">
	{literal}
	<!--
	function checkSubmissionChecklist() {
		var elements = document.getElementById('submit').elements;
		for (var i=0; i < elements.length; i++) {
			if (elements[i].type == 'checkbox' && !elements[i].checked) {
				if (elements[i].name.match('^checklist')) {
					alert({/literal}'{translate|escape:"jsparam" key="author.submit.verifyChecklist"}'{literal});
					return false;
				} else if (elements[i].name == 'copyrightNoticeAgree') {
					alert({/literal}'{translate|escape:"jsparam" key="author.submit.copyrightNoticeAgreeRequired"}'{literal});
					return false;
				}
			}
		}
		return true;
	}
	// -->
	{/literal}
	</script>

	{if $authorFees}
		{include file="author/submit/authorFees.tpl" showPayLinks=0}
		<div class="separator"></div>
	{/if}

	{if $currentJournal->getLocalizedSetting('submissionChecklist')}
		{foreach name=checklist from=$currentJournal->getLocalizedSetting('submissionChecklist') key=checklistId item=checklistItem}
			{if $checklistItem.content}
				{if !$notFirstChecklistItem}
					{assign var=notFirstChecklistItem value=1}
					<div id="checklist" class="col-md-12 mag-innert-left">
						<h3>{translate key="author.submit.submissionChecklist"}</h3>
						<p class="help-block">{translate key="author.submit.submissionChecklistDescription"}</p>
						
						<div class="table-responsive">
							<table width="100%" class="table table-striped">
				{/if}
								<tr valign="top">
									<td width="5%"><div class="form-group"><input type="checkbox" id="checklist-{$smarty.foreach.checklist.iteration}" name="checklist[]" value="{$checklistId|escape}"{if $articleId || $submissionChecklist} checked="checked"{/if} /></div></td>
									<td width="95%"><label class="control-label" for="checklist-{$smarty.foreach.checklist.iteration}">{$checklistItem.content|nl2br}</label></td>
								</tr>
			{/if}
		{/foreach}
		
		{if $notFirstChecklistItem}
							</table>
						</div>
					</div>{* checklist *}
			
			<div class="separator"></div>			
		{/if}

	{/if}{* if count($sectionOptions) <= 1 *}

	{if $currentJournal->getLocalizedSetting('copyrightNotice') != ''}
		<div id="copyrightNotice" class="col-md-12 mag-innert-left">
			<h3>{translate key="about.copyrightNotice"}</h3>
			<p class="help-block">{$currentJournal->getLocalizedSetting('copyrightNotice')|nl2br}</p>

			{if $journalSettings.copyrightNoticeAgree}
				<div class="table-responsive">
					<table width="100%" class="table table-striped">
						<tr valign="top">
							<td width="5%"><div class="form-group"><input type="checkbox" name="copyrightNoticeAgree" id="copyrightNoticeAgree" value="1"{if $articleId || $copyrightNoticeAgree} checked="checked"{/if} /></div></td>
							<td width="95%"><label class="control-label" for="copyrightNoticeAgree">{translate key="author.submit.copyrightNoticeAgree"}</label></td>
						</tr>
					</table>
				</div>
			{/if}{* $journalSettings.copyrightNoticeAgree *}
		</div>{* copyrightNotice *}

		<div class="separator"></div>
	{/if}{* $currentJournal->getLocalizedSetting('copyrightNotice') != '' *}

	<div id="privacyStatement" class="col-md-12 mag-innert-left">
		<h3>{translate key="author.submit.privacyStatement"}</h3>
		{$currentJournal->getLocalizedSetting('privacyStatement')|nl2br}
	</div>

	<div class="separator"></div>

	<div id="commentsForEditor" class="col-md-12 mag-innert-left">
		<h3>{translate key="author.submit.commentsForEditor"}</h3>

		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{fieldLabel name="commentsToEditor" key="author.submit.comments"}</td>
					<td width="80%" class="value"><div class="form-group"><textarea name="commentsToEditor" id="commentsToEditor" rows="3" cols="40" class="form-control">{$commentsToEditor|escape}</textarea></div></td>
				</tr>
			</table>
		</div>
	</div>{* commentsForEditor *}

	<div class="separator"></div>

	<p><input type="submit" value="{translate key="common.saveAndContinue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="{if $articleId}confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}'){else}document.location.href='{url page="author" escape=false}'{/if}" /></p>

	<p class="help-block">{translate key="common.requiredField"}</p>
</form>

{/if}{* If not accepting submissions *}

{include file="common/footer.tpl"}