{**
 * templates/sectionEditor/reviewerRecommendation.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Form to set the due date for a review.
 *
 *}
{strip}
{assign var="pageTitle" value="submission.recommendation"}
{include file="common/header.tpl"}
{/strip}

<div id="reviewerRecommendation" class="col-md-12 mag-innert-left">
	<h3>{translate key="editor.article.enterReviewerRecommendation"}</h3>

	<br />

	<form role="form" method="post" action="{url op="enterReviewerRecommendation"}">
		<input type="hidden" name="articleId" value="{$articleId|escape}" />
		<input type="hidden" name="reviewId" value="{$reviewId|escape}" />
		<div class="table-responsive">
			<table width="100%" class="table table-striped">
				<tr valign="top">
					<td width="20%">{translate key="editor.article.recommendation"}</td>
					<td width="80%" class="value">
						<div class="form-group">
							<select name="recommendation" size="1" class="form-control">
								{html_options_translate options=$reviewerRecommendationOptions}
							</select>
						</div>
					</td>
				</tr>
			</table>
		</div>
		
		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="submissionReview" path=$articleId escape=false}';"/></p>
	</form>
</div>

{include file="common/footer.tpl"}