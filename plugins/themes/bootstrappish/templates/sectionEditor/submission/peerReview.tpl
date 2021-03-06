{**
 * templates/sectionEditor/submission/peerReview.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Subtemplate defining the peer review table.
 *
 *}

<div id="submission" class="col-md-12 mag-innert-left">
	<h3>{translate key="article.submission"}</h3>

	<div class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr>
				<td width="20%">{translate key="article.authors"}</td>
				<td width="80%">
					{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$submission->getAuthorEmails() subject=$submission->getLocalizedTitle() articleId=$submission->getId()}
					{$submission->getAuthorString()|escape} {icon name="mail" url=$url}
				</td>
			</tr>
			<tr>
				<td>{translate key="article.title"}</td>
				<td>{$submission->getLocalizedTitle()|strip_unsafe_html}</td>
			</tr>
			<tr>
				<td>{translate key="section.section"}</td>
				<td>{$submission->getSectionTitle()|escape}</td>
			</tr>
			<tr>
				<td>{translate key="user.role.editor"}</td>
				<td>
					{assign var=editAssignments value=$submission->getEditAssignments()}
					{foreach from=$editAssignments item=editAssignment}
						{assign var=emailString value=$editAssignment->getEditorFullName()|concat:" <":$editAssignment->getEditorEmail():">"}
						{url|assign:"url" page="user" op="email" redirectUrl=$currentUrl to=$emailString|to_array subject=$submission->getLocalizedTitle|strip_tags articleId=$submission->getId()}
						{$editAssignment->getEditorFullName()|escape} {icon name="mail" url=$url}
						{if !$editAssignment->getCanEdit() || !$editAssignment->getCanReview()}
							{if $editAssignment->getCanEdit()}
								({translate key="submission.editing"})
							{else}
								({translate key="submission.review"})
							{/if}
						{/if}
						<br/>
					{foreachelse}
						{translate key="common.noneAssigned"}
					{/foreach}
				</td>
			</tr>
			<tr valign="top">
				<td width="20%">{translate key="submission.reviewVersion"}</td>
				{if $reviewFile}
					<td width="80%" class="value">
						<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewFile->getFileId():$reviewFile->getRevision()}" class="file">{$reviewFile->getFileName()|escape}</a>&nbsp;&nbsp;
						{$reviewFile->getDateModified()|date_format:$dateFormatShort}{if $currentJournal->getSetting('showEnsuringLink')}&nbsp;&nbsp;&nbsp;&nbsp;<a class="action" href="javascript:openHelp('{get_help_id key="editorial.sectionEditorsRole.review.blindPeerReview" url="true"}')">{translate key="reviewer.article.ensuringBlindReview"}</a>{/if}
					</td>
				{else}
					<td width="80%" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
				{/if}
			</tr>
			<tr valign="top">
				<td>&nbsp;</td>
				<td>
					<form role="form" method="post" action="{url op="uploadReviewVersion"}" enctype="multipart/form-data">
						{translate key="editor.article.uploadReviewVersion"}
						<input type="hidden" name="articleId" value="{$submission->getId()}" />
						<div class="form-group"><input type="file" name="upload" class="form-control" /></div>
						<input type="submit" name="submit" value="{translate key="common.upload"}" class="btn btn-success" />
					</form>
				</td>
			</tr>
			{foreach from=$suppFiles item=suppFile}
				<tr valign="top">
					{if !$notFirstSuppFile}
						<td rowspan="{$suppFiles|@count}">{translate key="article.suppFilesAbbrev"}</td>
						{assign var=notFirstSuppFile value=1}
					{/if}
					<td width="80%" class="value nowrap">
						<form role="form" method="post" action="{url op="setSuppFileVisibility"}">
							<input type="hidden" name="articleId" value="{$submission->getId()}" />
							<input type="hidden" name="fileId" value="{$suppFile->getId()}" />
							
							<a href="{url op="downloadFile" path=$submission->getId()|to_array:$suppFile->getFileId():$suppFile->getRevision()}" class="file">{$suppFile->getFileName()|escape}</a>&nbsp;&nbsp;
							{$suppFile->getDateModified()|date_format:$dateFormatShort}&nbsp;&nbsp;
							<br/>
							<div class="form-group">
								<input type="checkbox" name="show" id="show" value="1"{if $suppFile->getShowReviewers()==1} checked="checked"{/if}/>
								<label class="control-label" for="show">{translate key="editor.article.showSuppFile"}</label>
							</div>
							<input type="submit" name="submit" value="{translate key="common.record"}" class="btn btn-success" />
						</form>
					</td>
				</tr>
			{foreachelse}
				<tr valign="top">
					<td>{translate key="article.suppFilesAbbrev"}</td>
					<td class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
				</tr>
			{/foreach}
		</table>
	</div>

	<div class="separator"></div>

</div>

<div id="peerReview" class="col-md-12 mag-innert-left">
	
	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			<tr id="reviewersHeader" valign="middle">
				<td width="22%"><h3>{translate key="submission.peerReview"}</h3></td>
				<td width="14%"><h4>{translate key="submission.round" round=$round}</h4></td>
				<td width="64%" class="nowrap">
					<a href="{url op="selectReviewer" path=$submission->getId()}" class="action">{translate key="editor.article.selectReviewer"}</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="{url op="submissionRegrets" path=$submission->getId()}" class="action">{translate|escape key="sectionEditor.regrets.link"}</a>
				</td>
			</tr>
		</table>
	</div>

	{assign var="start" value="A"|ord}
	{foreach from=$reviewAssignments item=reviewAssignment key=reviewKey}
		{assign var="reviewId" value=$reviewAssignment->getId()}

		{if not $reviewAssignment->getCancelled() and not $reviewAssignment->getDeclined()}
			{assign var="reviewIndex" value=$reviewIndexes[$reviewId]}
			
			<div class="separator"></div>

			<div class="table-responsive">
				<table class="table table-striped" width="100%">
					<tr class="reviewer">
						<td class="r1" width="20%"><h4>{translate key="user.role.reviewer"} {$reviewIndex+$start|chr}</h4></td>
						<td class="r2" width="34%"><h4>{$reviewAssignment->getReviewerFullName()|escape}</h4></td>
						<td class="r3" width="46%">
								{if not $reviewAssignment->getDateNotified()}
									<a href="{url op="clearReview" path=$submission->getId()|to_array:$reviewAssignment->getId()}" class="action">{translate key="editor.article.clearReview"}</a>
								{elseif $reviewAssignment->getDeclined() or not $reviewAssignment->getDateCompleted()}
									<a href="{url op="cancelReview" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}" class="action">{translate key="editor.article.cancelReview"}</a>
								{/if}
						</td>
					</tr>
				</table>
			</div>

			<div class="table-responsive">
				<table width="100%" class="table table-striped">
					<tr valign="top">
						<td>{translate key="submission.reviewForm"}</td>
						<td>
							{if $reviewAssignment->getReviewFormId()}
								{assign var="reviewFormId" value=$reviewAssignment->getReviewFormId()}
								{$reviewFormTitles[$reviewFormId]}
							{else}
								{translate key="manager.reviewForms.noneChosen"}
							{/if}
							{if !$reviewAssignment->getDateCompleted()}
								&nbsp;&nbsp;&nbsp;&nbsp;<a class="action" href="{url op="selectReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.selectReviewForm"}</a>{if $reviewAssignment->getReviewFormId()}&nbsp;&nbsp;&nbsp;&nbsp;<a class="action" href="{url op="clearReviewForm" path=$submission->getId()|to_array:$reviewAssignment->getId()}"{if $reviewFormResponses[$reviewId]} onclick="return confirm('{translate|escape:"jsparam" key="editor.article.confirmChangeReviewForm"}')"{/if}>{translate key="editor.article.clearReviewForm"}</a>{/if}
							{/if}
						</td>
					</tr>
					<tr valign="top">
						<td width="20%">&nbsp;</td>
						<td width="80%">
							<table width="100%" class="table table-striped">
								<tr>
									<td class="heading" width="25%"><label>{translate key="submission.request"}</label></td>
									<td class="heading" width="25%"><label>{translate key="submission.underway"}</label></td>
									<td class="heading" width="25%"><label>{translate key="submission.due"}</label></td>
									<td class="heading" width="25%"><label>{translate key="submission.acknowledge"}</label></td>
								</tr>
								<tr valign="top">
									<td>
										{url|assign:"reviewUrl" op="notifyReviewer" reviewId=$reviewAssignment->getId() articleId=$submission->getId()}
										{if $reviewAssignment->getDateNotified()}
											{$reviewAssignment->getDateNotified()|date_format:$dateFormatShort}
											{if !$reviewAssignment->getDateCompleted()}
												{icon name="mail" url=$reviewUrl}
											{/if}
										{elseif $reviewAssignment->getReviewFileId()}
											{icon name="mail" url=$reviewUrl}
										{else}
											{icon name="mail" disabled="disabled" url=$reviewUrl}
											{assign var=needsReviewFileNote value=1}
										{/if}
									</td>
									<td>
										{$reviewAssignment->getDateConfirmed()|date_format:$dateFormatShort|default:"&mdash;"}
									</td>
									<td>
										{if $reviewAssignment->getDeclined()}
											{translate key="sectionEditor.regrets"}
										{else}
											<a href="{url op="setDueDate" path=$reviewAssignment->getSubmissionId()|to_array:$reviewAssignment->getId()}">{if $reviewAssignment->getDateDue()}{$reviewAssignment->getDateDue()|date_format:$dateFormatShort}{else}&mdash;{/if}</a>
										{/if}
									</td>
									<td>
										{url|assign:"thankUrl" op="thankReviewer" reviewId=$reviewAssignment->getId() articleId=$submission->getId()}
										{if $reviewAssignment->getDateAcknowledged()}
											{$reviewAssignment->getDateAcknowledged()|date_format:$dateFormatShort}
										{elseif $reviewAssignment->getDateCompleted()}
											{icon name="mail" url=$thankUrl}
										{else}
											{icon name="mail" disabled="disabled" url=$thankUrl}
										{/if}
									</td>
								</tr>
							</table>
						</td>
					</tr>

					{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
						<tr valign="top">
							<td>{translate key="reviewer.article.recommendation"}</td>
							<td>
								{if $reviewAssignment->getRecommendation() !== null && $reviewAssignment->getRecommendation() !== ''}
									{assign var="recommendation" value=$reviewAssignment->getRecommendation()}
									{translate key=$reviewerRecommendationOptions.$recommendation}
									&nbsp;&nbsp;{$reviewAssignment->getDateCompleted()|date_format:$dateFormatShort}
								{else}
									{translate key="common.none"}&nbsp;&nbsp;&nbsp;&nbsp;
									<a href="{url op="remindReviewer" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}" class="action">{translate key="reviewer.article.sendReminder"}</a>
									{if $reviewAssignment->getDateReminded()}
										&nbsp;&nbsp;{$reviewAssignment->getDateReminded()|date_format:$dateFormatShort}
										{if $reviewAssignment->getReminderWasAutomatic()}
											&nbsp;&nbsp;{translate key="reviewer.article.automatic"}
										{/if}
									{/if}
								{/if}
							</td>
						</tr>
						{if $currentJournal->getSetting('requireReviewerCompetingInterests')}
							<tr valign="top">
								<td>{translate key="reviewer.competingInterests"}</td>
								<td>{$reviewAssignment->getCompetingInterests()|strip_unsafe_html|nl2br|default:"&mdash;"}</td>
							</tr>
						{/if}{* requireReviewerCompetingInterests *}
						{if $reviewFormResponses[$reviewId]}
							<tr valign="top">
								<td>{translate key="submission.reviewFormResponse"}</td>
								<td>
									<a href="javascript:openComments('{url op="viewReviewFormResponse" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="comment"}</a>
								</td>
							</tr>
						{/if}
						{if !$reviewAssignment->getReviewFormId() || $reviewAssignment->getMostRecentPeerReviewComment()}{* Only display comments link if a comment is entered or this is a non-review form review *}
							<tr valign="top">
								<td>{translate key="submission.review"}</td>
								<td>
									{if $reviewAssignment->getMostRecentPeerReviewComment()}
										{assign var="comment" value=$reviewAssignment->getMostRecentPeerReviewComment()}
										<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId() anchor=$comment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{$comment->getDatePosted()|date_format:$dateFormatShort}
									{else}
										<a href="javascript:openComments('{url op="viewPeerReviewComments" path=$submission->getId()|to_array:$reviewAssignment->getId()}');" class="icon">{icon name="comment"}</a>&nbsp;&nbsp;{translate key="submission.comments.noComments"}
									{/if}
								</td>
							</tr>
						{/if}
						<tr valign="top">
							<td>{translate key="reviewer.article.uploadedFile"}</td>
							<td>
								<table width="100%" class="table table-striped">
									{foreach from=$reviewAssignment->getReviewerFileRevisions() item=reviewerFile key=key}
										<tr valign="top">
											<td valign="middle">
												<form role="form" id="authorView{$reviewAssignment->getId()}" method="post" action="{url op="makeReviewerFileViewable"}">
													<a href="{url op="downloadFile" path=$submission->getId()|to_array:$reviewerFile->getFileId():$reviewerFile->getRevision()}" class="file">{$reviewerFile->getFileName()|escape}</a>&nbsp;&nbsp;{$reviewerFile->getDateModified()|date_format:$dateFormatShort}
													<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
													<input type="hidden" name="articleId" value="{$submission->getId()}" />
													<input type="hidden" name="fileId" value="{$reviewerFile->getFileId()}" />
													<input type="hidden" name="revision" value="{$reviewerFile->getRevision()}" />
													{translate key="editor.article.showAuthor"} <div class="form-group"><input type="checkbox" name="viewable" value="1"{if $reviewerFile->getViewable()} checked="checked"{/if} /></div>
													<input type="submit" value="{translate key="common.record"}" class="btn btn-success" />
												</form>
											</td>
										</tr>
									{foreachelse}
										<tr valign="top">
											<td>{translate key="common.none"}</td>
										</tr>
									{/foreach}
								</table>
							</td>
						</tr>
					{/if}

					{if (($reviewAssignment->getRecommendation() === null || $reviewAssignment->getRecommendation() === '') || !$reviewAssignment->getDateConfirmed()) && $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined()}
						<tr valign="top">
							<td>{translate key="reviewer.article.editorToEnter"}</td>
							<td>
								{if !$reviewAssignment->getDateConfirmed()}
									<a href="{url op="confirmReviewForReviewer" path=$submission->getId()|to_array:$reviewAssignment->getId() accept=1}" class="action">{translate key="reviewer.article.canDoReview"}</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="{url op="confirmReviewForReviewer" path=$submission->getId()|to_array:$reviewAssignment->getId() accept=0}" class="action">{translate key="reviewer.article.cannotDoReview"}</a><br />
								{/if}
								<form role="form" method="post" action="{url op="uploadReviewForReviewer"}" enctype="multipart/form-data">
									{translate key="editor.article.uploadReviewForReviewer"}
									<input type="hidden" name="articleId" value="{$submission->getId()}" />
									<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}"/>
									<div class="form-group"><input type="file" name="upload" class="form-control" /></div>
									<input type="submit" name="submit" value="{translate key="common.upload"}" class="btn btn-success" />
								</form>
								{if $reviewAssignment->getDateConfirmed() && !$reviewAssignment->getDeclined()}
									<a class="action" href="{url op="enterReviewerRecommendation" articleId=$submission->getId() reviewId=$reviewAssignment->getId()}">{translate key="editor.article.recommendation"}</a>
								{/if}
							</td>
						</tr>
					{/if}

					{if $reviewAssignment->getDateNotified() && !$reviewAssignment->getDeclined() && $rateReviewerOnQuality}
						<tr valign="top">
							<td>{translate key="editor.article.rateReviewer"}</td>
							<td>
								<form role="form" method="post" action="{url op="rateReviewer"}">
									<input type="hidden" name="reviewId" value="{$reviewAssignment->getId()}" />
									<input type="hidden" name="articleId" value="{$submission->getId()}" />
									<div class="form-group">
										<select name="quality" size="1" class="form-control">
											{html_options_translate options=$reviewerRatingOptions selected=$reviewAssignment->getQuality()}
										</select>&nbsp;&nbsp;
									</div>
									<input type="submit" value="{translate key="common.record"}" class="btn btn-success" />
									{if $reviewAssignment->getDateRated()}
										&nbsp;&nbsp;{$reviewAssignment->getDateRated()|date_format:$dateFormatShort}
									{/if}
								</form>
							</td>
						</tr>
					{/if}
					{if $needsReviewFileNote}
						<tr valign="top">
							<td>&nbsp;</td>
							<td>
								{translate key="submission.review.mustUploadFileForReview"}
							</td>
						</tr>
					{/if}
				</table>
			</div>
		{/if}
	{/foreach}
</div>