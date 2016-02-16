{**
 * templates/author/submit/step2.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 2 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step2"}
{include file="author/submit/submitHeader.tpl"}

<form role="form" method="post" action="{url op="saveSubmit" path=$submitStep}" enctype="multipart/form-data">
	<input type="hidden" name="articleId" value="{$articleId|escape}" />
	
	{include file="common/formErrors.tpl"}

	<div id="uploadInstructions" class="col-md-12 mag-innert-left"><p class="help-block">{translate key="author.submit.uploadInstructions"}</p></div>

	{if $journalSettings.supportPhone}
		{assign var="howToKeyName" value="author.submit.howToSubmit"}
	{else}
		{assign var="howToKeyName" value="author.submit.howToSubmitNoPhone"}
	{/if}

	<p class="help-block">{translate key=$howToKeyName supportName=$journalSettings.supportName supportEmail=$journalSettings.supportEmail supportPhone=$journalSettings.supportPhone}</p>

	<div class="separator"></div>

	<div id="submissionFile" class="table-responsive">
		<h3>{translate key="author.submit.submissionFile"}</h3>
		
		<table class="table table-striped" width="100%">
			{if $submissionFile}
				<tr valign="top">
					<td width="20%">{translate key="common.fileName"}</td>
					<td width="80%" class="value"><a href="{url op="download" path=$articleId|to_array:$submissionFile->getFileId()}">{$submissionFile->getFileName()|escape}</a></td>
				</tr>
				<tr valign="top">
					<td width="20%">{translate key="common.originalFileName"}</td>
					<td width="80%" class="value">{$submissionFile->getOriginalFileName()|escape}</td>
				</tr>
				<tr valign="top">
					<td width="20%">{translate key="common.fileSize"}</td>
					<td width="80%" class="value">{$submissionFile->getNiceFileSize()}</td>
				</tr>
				<tr valign="top">
					<td width="20%">{translate key="common.dateUploaded"}</td>
					<td width="80%" class="value">{$submissionFile->getDateUploaded()|date_format:$datetimeFormatShort}</td>
				</tr>
			{else}
				<tr valign="top">
					<td colspan="2" class="nodata"><p class="help-block">{translate key="author.submit.noSubmissionFile"}</p></td>
				</tr>
			{/if}
		</table>
	</div>

	<div class="separator"></div>

	<div id="addSubmissionFile" class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr>
				<td width="30%">
					{if $submissionFile}
						{fieldLabel name="submissionFile" key="author.submit.replaceSubmissionFile"}
					{else}
						{fieldLabel name="submissionFile" key="author.submit.uploadSubmissionFile"}
					{/if}
				</td>
				<td width="70%" class="value">
					<div class="form-group"><input type="file" class="form-control" name="submissionFile" id="submissionFile" /> </div><input name="uploadSubmissionFile" type="submit" class="btn btn-success" value="{translate key="common.upload"}" />
					{if $currentJournal->getSetting('showEnsuringLink')}<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
				</td>
			</tr>
		</table>
	</div>

	<div class="separator"></div>

	<p><input type="submit"{if !$submissionFile} onclick="return confirm('{translate|escape:"jsparam" key="author.submit.noSubmissionConfirm"}')"{/if} value="{translate key="common.saveAndContinue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /></p>
</form>

{include file="common/footer.tpl"}