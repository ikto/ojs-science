{**
 * templates/editor/issues/issueGalleys.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form for uploading and editing issue galleys
 *}
{strip}
{assign var="pageTitleTranslated" value=$issue->getIssueIdentification()}
{assign var="pageCrumbTitleTranslated" value=$issue->getIssueIdentification(false,true)}
{include file="common/header.tpl"}
{/strip}

{if !$isLayoutEditor}{* Layout Editors can also access this page. *}
	<ul class="stay">
		<li><a href="{url op="createIssue"}">{translate key="editor.navigation.createIssue"}</a></li>
		<li{if $unpublished} class="current"{/if}><a href="{url op="futureIssues"}">{translate key="editor.navigation.futureIssues"}</a></li>
		<li{if !$unpublished} class="current"{/if}><a href="{url op="backIssues"}">{translate key="editor.navigation.issueArchive"}</a></li>
	</ul>
{/if}
<br />

<form role="form" action="#">
	{translate key="issue.issue"}: <div class="form-group"><select name="issue" class="form-control" onchange="if(this.options[this.selectedIndex].value > 0) location.href='{url|escape:"javascript" op="issueToc" path="ISSUE_ID" escape=false}'.replace('ISSUE_ID', this.options[this.selectedIndex].value)" size="1">{html_options options=$issueOptions selected=$issueId}</select></div>
</form>

<div class="separator"></div>

<ul class="stay">
	<li><a href="{url op="issueToc" path=$issueId}">{translate key="issue.toc"}</a></li>
	<li><a href="{url op="issueData" path=$issueId}">{translate key="editor.issues.issueData"}</a></li>
	<li class="current"><a href="{url op="issueGalleys" path=$issueId}">{translate key="editor.issues.galleys"}</a></li>
	{if $unpublished}<li><a href="{url page="issue" op="view" path=$issue->getBestIssueId()}">{translate key="editor.issues.previewIssue"}</a></li>{/if}
</ul>

<form role="form" id="issueGalleys" method="post" action="{url op="uploadIssueGalley" path=$issueId}" enctype="multipart/form-data">
	
	{include file="common/formErrors.tpl"}
	
	<div id="issueId" class="col-md-12 mag-innert-left">
		<h3>{translate key="editor.issues.galleys"}</h3>
		<p class="help-block">{translate key="editor.issues.issueGalleysDescription"}</p>
	
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				{if count($formLocales) > 1}
					<tr valign="top">
						<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
						<td width="80%" class="value">
							{url|assign:"issueUrl" op="issueGalleys" path=$issueId escape=false}
							{form_language_chooser form="issue" url=$issueUrl}
							<p class="help-block">{translate key="form.formLanguage.description"}</p>
						</td>
					</tr>
				{/if}
			</table>
		</div>
	
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr>
					<td colspan="6" class="separator">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="2" class="heading"><label>{translate key="submission.layout.galleyFormat"}</label></td>
					<td class="heading"><label>{translate key="common.file"}</label></td>
					<td class="heading"><label>{translate key="common.order"}</label></td>
					<td class="heading"><label>{translate key="common.action"}</label></td>
					<td class="heading"><label>{translate key="submission.views"}</label></td>
				</tr>
				{foreach name=galleys from=$issueGalleys item=galley}
					<tr>
						<td width="2%">{$smarty.foreach.galleys.iteration}.</td>
						<td width="26%">{$galley->getGalleyLabel()|escape} &nbsp; <a href="{url op="proofIssueGalley" path=$issue->getId()|to_array:$galley->getId()}" class="action">{translate key="submission.layout.viewProof"}</a></td>
						<td><a href="{url op="downloadIssueFile" path=$issue->getId()|to_array:$galley->getFileId()}" class="file">{$galley->getFileName()|escape}</a>&nbsp;&nbsp;{$galley->getDateModified()|date_format:$dateFormatShort}</td>
						<td><a href="{url op="orderIssueGalley" d=u issueId=$issue->getId() galleyId=$galley->getId()}" class="plain">&uarr;</a> <a href="{url op="orderIssueGalley" d=d issueId=$issue->getId() galleyId=$galley->getId()}" class="plain">&darr;</a></td>
						<td>
							<a href="{url op="editIssueGalley" path=$issue->getId()|to_array:$galley->getId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteIssueGalley" path=$issue->getId()|to_array:$galley->getId()}" onclick="return confirm('{translate|escape:"jsparam" key="editor.issues.confirmDeleteGalley"}')" class="action">{translate key="common.delete"}</a>
						</td>
						<td>{$galley->getViews()|escape}</td>
					</tr>
				{foreachelse}
					<tr>
						<td colspan="6" class="nodata"><p class="help-block">{translate key="editor.issues.noneIssueGalleys"}</p></td>
					</tr>
				{/foreach}
				<tr>
					<td colspan="6" class="separator">&nbsp;</td>
				</tr>
			</table>
		</div>

		<br />

		<div class="form-group"><input type="file" name="galleyFile" id="galleyFile" size="10" class="form-control" /></div>
		<input type="submit" value="{translate key="common.upload"}" class="btn btn-success" />
	</div>
</form>

{include file="common/footer.tpl"}