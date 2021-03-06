{**
 * templates/author/submit/step4.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Step 4 of author article submission.
 *
 *}
{assign var="pageTitle" value="author.submit.step4"}
{include file="author/submit/submitHeader.tpl"}

<script type="text/javascript">
{literal}
<!--
function confirmForgottenUpload() {
	var fieldValue = document.getElementById('submitForm').uploadSuppFile.value;
	if (fieldValue) {
		return confirm("{/literal}{translate key="author.submit.forgottenSubmitSuppFile"}{literal}");
	}
	return true;
}
// -->
{/literal}
</script>

<form role="form" id="submitForm" method="post" action="{url op="saveSubmit" path=$submitStep}" enctype="multipart/form-data">
	<input type="hidden" name="articleId" value="{$articleId|escape}" />
	
	{include file="common/formErrors.tpl"}

	<p class="help-block">{translate key="author.submit.supplementaryFilesInstructions"}</p>

	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr>
				<td colspan="5" class="headseparator">&nbsp;</td>
			</tr>
			<tr class="heading" valign="bottom">
				<td width="5%"><label>{translate key="common.id"}</label></td>
				<td width="40%"><label>{translate key="common.title"}</label></td>
				<td width="25%"><label>{translate key="common.originalFileName"}</label></td>
				<td width="15%" class="nowrap"><label>{translate key="common.dateUploaded"}</label></td>
				<td width="15%" align="right"><label>{translate key="common.action"}</label></td>
			</tr>
			<tr>
				<td colspan="6" class="headseparator">&nbsp;</td>
			</tr>
			{foreach from=$suppFiles item=file}
				<tr valign="top">
					<td>{$file->getSuppFileId()}</td>
					<td>{$file->getSuppFileTitle()|escape}</td>
					<td>{$file->getOriginalFileName()|escape}</td>
					<td>{$file->getDateSubmitted()|date_format:$dateFormatTrunc}</td>
					<td align="right"><a href="{url op="submitSuppFile" path=$file->getSuppFileId() articleId=$articleId}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteSubmitSuppFile" path=$file->getSuppFileId() articleId=$articleId}" onclick="return confirm('{translate|escape:"jsparam" key="author.submit.confirmDeleteSuppFile"}')" class="action">{translate key="common.delete"}</a></td>
				</tr>
			{foreachelse}
				<tr valign="top">
					<td colspan="6" class="nodata"><p class="help-block">{translate key="author.submit.noSupplementaryFiles"}</p></td>
				</tr>
			{/foreach}
		</table>
	</div>

	<div class="separator"></div>

	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr>
				<td width="30%">{fieldLabel name="uploadSuppFile" key="author.submit.uploadSuppFile"}</td>
				<td width="70%" class="value">
					<div class="form-group"><input type="file" name="uploadSuppFile" id="uploadSuppFile"  class="form-control" /> </div><input name="submitUploadSuppFile" type="submit" class="btn btn-success" value="{translate key="common.upload"}" />
					{if $currentJournal->getSetting('showEnsuringLink')}<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
				</td>
			</tr>
		</table>
	</div>

	<div class="separator"></div>

	<p><input type="submit" onclick="return confirmForgottenUpload()" value="{translate key="common.saveAndContinue"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="confirmAction('{url page="author"}', '{translate|escape:"jsparam" key="author.submit.cancelSubmission"}')" /></p>
</form>

{include file="common/footer.tpl"}