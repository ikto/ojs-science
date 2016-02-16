{**
 * templates/sectionEditor/setDueDate.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to set the due date for a review.
 *
 *}
{strip}
{assign var="pageTitle" value="submission.dueDate"}
{include file="common/header.tpl"}
{/strip}

<div id="setDueDate" class="col-md-12 mag-innert-left">
	<h3>{translate key="editor.article.designateDueDate"}</h3>
	<p class="help-block">{translate key="editor.article.designateDueDateDescription"}</p>

	<form role="form" method="post" action="{url op=$actionHandler path=$articleId|to_array:$reviewId}">
		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr valign="top">
					<td width="20%">{translate key="editor.article.todaysDate"}</td>
					<td class="value" width="80%">{$todaysDate|escape}</td>
				</tr>
				<tr valign="top">
					<td>{translate key="editor.article.requestedByDate"}</td>
					<td class="value">
						<div class="form-group">
							<input type="text" size="11" maxlength="10" name="dueDate" value="{if $dueDate}{$dueDate|date_format:"%Y-%m-%d"}{/if}" class="form-control" onfocus="this.form.numWeeks.value=''" />
							<p class="help-block">{translate key="editor.article.dueDateFormat"}</p>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td>&nbsp;</td>
					<td class="value"><p class="help-block">{translate key="common.or"}</p></td>
				</tr>
				<tr valign="top">
					<td>{translate key="editor.article.numberOfWeeks"}</td>
					<td class="value"><div class="form-group"><input type="text" name="numWeeks" value="{if not $dueDate}{$numWeeksPerReview|escape}{/if}" size="3" maxlength="2" class="form-control" onfocus="this.form.dueDate.value=''" /></div></td>
				</tr>
			</table>
		</div>

		<p><input type="submit" value="{translate key="common.continue"}" class="btn btn-success" /> <input type="button" class="btn btn-danger" onclick="history.go(-1)" value="{translate key="common.cancel"}" /></p>
	</form>
</div>

{include file="common/footer.tpl"}