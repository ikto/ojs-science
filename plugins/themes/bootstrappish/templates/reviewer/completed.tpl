{**
 * templates/reviewer/completed.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Show reviewer's submission archive.
 *
 *}
 
<div id="submissions" class="table-responsive">
	<table class="table table-striped" width="100%">
		<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>
		<tr class="heading" valign="bottom">
			<td width="5%"><label>{sort_heading key="common.id" sort="id"}</label></td>
			<td width="10%"><label><span class="help-block">{translate key="submission.date.mmdd"}</span>{sort_heading key="common.assigned" sort="assignDate"}</label></td>
			<td width="10%"><label>{sort_heading key="submissions.sec" sort="section"}</label></td>
			<td width="35%"><label>{sort_heading key="article.title" sort="title"}</label></td>
			<td width="20%"><label>{sort_heading key="submission.review" sort="review"}</label></td>
			<td width="20%"><label>{sort_heading key="submission.editorDecision" sort="decision"}</label></td>
		</tr>
		<tr><td colspan="6" class="headseparator">&nbsp;</td></tr>
		{iterate from=submissions item=submission}
			{assign var="articleId" value=$submission->getId()}
			{assign var="reviewId" value=$submission->getReviewId()}
			
			<tr valign="top">
				<td>{$articleId|escape}</td>
				<td>{$submission->getDateNotified()|date_format:$dateFormatTrunc}</td>
				<td>{$submission->getSectionAbbrev()|escape}</td>
				<td>{if !$submission->getDeclined()}<a href="{url op="submission" path=$reviewId}" class="action">{/if}{$submission->getLocalizedTitle()|strip_tags|truncate:60:"..."}{if !$submission->getDeclined()}</a>{/if}</td>
				<td>
					{if $submission->getDeclined()}
						{translate key="sectionEditor.regrets"}
					{else}
						{assign var=recommendation value=$submission->getRecommendation()}
						{if $recommendation === '' || $recommendation === null}
							&mdash;
						{else}
							{translate key=$reviewerRecommendationOptions.$recommendation}
						{/if}
					{/if}
				</td>
				<td>
					{if $submission->getCancelled() || $submission->getDeclined()}
						&mdash;
					{else}
						{* Display the most recent editor decision *}
						{assign var=round value=$submission->getRound()}
						{assign var=decisions value=$submission->getDecisions($round)}
						{foreach from=$decisions item=decision name=lastDecisionFinder}
							{if $smarty.foreach.lastDecisionFinder.last and $decision.decision == SUBMISSION_EDITOR_DECISION_ACCEPT}
								{translate key="editor.article.decision.accept"}
							{elseif $smarty.foreach.lastDecisionFinder.last and $decision.decision == SUBMISSION_EDITOR_DECISION_PENDING_REVISIONS}
								{translate key="editor.article.decision.pendingRevisions"}
							{elseif $smarty.foreach.lastDecisionFinder.last and $decision.decision == SUBMISSION_EDITOR_DECISION_RESUBMIT}
								{translate key="editor.article.decision.resubmit"}
							{elseif $smarty.foreach.lastDecisionFinder.last and $decision.decision == SUBMISSION_EDITOR_DECISION_DECLINE}
								{translate key="editor.article.decision.decline"}
							{/if}
						{foreachelse}
							&mdash;
						{/foreach}
					{/if}
				</td>
			</tr>
			<tr>
				<td colspan="6" class="{if $submissions->eof()}end{/if}separator">&nbsp;</td>
			</tr>
		{/iterate}
		{if $submissions->wasEmpty()}
			<tr>
				<td colspan="6" class="nodata"><p class="help-block">{translate key="submissions.noSubmissions"}</p></td>
			</tr>
			<tr>
				<td colspan="6" class="endseparator">&nbsp;</td>
			</tr>
		{else}
			<tr>
				<td colspan="4" align="left">{page_info iterator=$submissions}</td>
				<td colspan="3" align="right">{page_links anchor="submissions" name="submissions" iterator=$submissions sort=$sort sortDirection=$sortDirection}</td>
			</tr>
		{/if}
	</table>
</div>