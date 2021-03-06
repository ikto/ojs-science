{**
 * templates/manager/announcement/announcementForm.tpl
 *
 * Copyright (c) 2013-2015 Simon Fraser University Library
 * Copyright (c) 2000-2015 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Announcement form under management.
 *
 *}
{strip}
{assign var="pageCrumbTitle" value="$announcementTitle"}
{if $announcementId}
	{assign var="pageTitle" value="manager.announcements.edit"}
{else}
	{assign var="pageTitle" value="manager.announcements.create"}
{/if}
{assign var="pageId" value="manager.announcement.announcementForm"}
{include file="common/header.tpl"}
{/strip}

<br/>

<div id="announcement" class="col-md-12 mag-innert-left">
	<form role="form" id="announcementForm" method="post" action="{url op="updateAnnouncement"}">
	
		{if $announcementId}
			<input type="hidden" name="announcementId" value="{$announcementId|escape}" />
		{/if}

		{include file="common/formErrors.tpl"}

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				{if count($formLocales) > 1}
					<tr valign="top">
						<td width="20%">{fieldLabel name="formLocale" key="form.formLanguage"}</td>
						<td width="80%" class="value">
							{if $typeId}{url|assign:"announcementUrl" op="editAnnouncement" path=$announcementId escape=false}
							{else}{url|assign:"announcementUrl" op="createAnnouncement" escape=false}
							{/if}
							{form_language_chooser form="announcementForm" url=$announcementUrl}
							<p class="help-block">{translate key="form.formLanguage.description"}</p>
						</td>
					</tr>
				{/if}

				{if $announcementTypes->getCount() != 0}
					<tr valign="top">
						<td width="20%">{fieldLabel name="typeId" key="manager.announcements.form.typeId"}</td>
						<td width="80%" class="value">
							<div class="form-group">
								<select name="typeId" id="typeId" class="form-control">
									<option value=""></option>
									{iterate from=announcementTypes item=announcementType}
										<option value="{$announcementType->getId()}"{if $typeId == $announcementType->getId()} selected="selected"{/if}>{$announcementType->getLocalizedTypeName()|escape}</option>
									{/iterate}
								</select>
							</div>
						</td>
					</tr>
				{/if}{* $announcementTypes->getCount() != 0 *}

				<tr valign="top">
					<td>{fieldLabel name="title" required="true" key="manager.announcements.form.title"}</td>
					<td class="value"><div class="form-group"><input type="text" name="title[{$formLocale|escape}]" value="{$title[$formLocale]|escape}" size="40" id="title" maxlength="255" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="descriptionShort" required="true" key="manager.announcements.form.descriptionShort"}</td>
					<td class="value">
						<div class="form-group">
							<textarea name="descriptionShort[{$formLocale|escape}]" id="descriptionShort" cols="40" rows="6" class="form-control richContent">{$descriptionShort[$formLocale]|escape}</textarea>
							<p class="help-block">{translate key="manager.announcements.form.descriptionShortInstructions"}</p>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="description" key="manager.announcements.form.description"}</td>
					<td class="value">
						<div class="form-group">
							<textarea name="description[{$formLocale|escape}]" id="description" cols="40" rows="6" class="form-control richContent">{$description[$formLocale]|escape}</textarea>
							<p class="help-block">{translate key="manager.announcements.form.descriptionInstructions"}</p>
						</div>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="datePosted" key="manager.announcements.datePublish"}</td>
					<td class="value">
						{html_select_date prefix="datePosted" all_extra="class=\"form-control\"" end_year="$yearOffsetFuture" year_empty="" month_empty="" day_empty="" time="$datePosted"}
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="dateExpire" key="manager.announcements.form.dateExpire"}</td>
					<td class="value">
						{if $dateExpire != null}
							{html_select_date prefix="dateExpire" all_extra="class=\"form-control\"" end_year="$yearOffsetFuture" year_empty="" month_empty="" day_empty="" time="$dateExpire"}
						{else}
							{html_select_date prefix="dateExpire" all_extra="class=\"form-control\"" end_year="$yearOffsetFuture" year_empty="" month_empty="" day_empty="" time="-00-00"}
						{/if}
						<input type="hidden" name="dateExpireHour" value="23" />
						<input type="hidden" name="dateExpireMinute" value="59" />
						<input type="hidden" name="dateExpireSecond" value="59" />
						<p class="help-block">{translate key="manager.announcements.form.dateExpireInstructions"}</p>
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="notificationToggle" key="manager.announcements.form.notificationToggle"}</td>
					<td class="value">
						<div class="form-group"><input type="checkbox" name="notificationToggle" id="notificationToggle" value="1" {if $notificationToggle} checked="checked"{/if} /> {translate key="manager.announcements.form.notificationToggleInstructions"}</div>
					</td>
				</tr>
			</table>
		</div>

		<p><input type="submit" value="{translate key="common.save"}" class="btn btn-success" /> {if not $announcementId}<input type="submit" name="createAnother" value="{translate key="manager.announcements.form.saveAndCreateAnother"}" class="btn btn-success" /> {/if}<input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url op="announcements" escape=false}'" /></p>
	</form>
</div>

<p class="help-block">{translate key="common.requiredField"}</p>

{include file="common/footer.tpl"}