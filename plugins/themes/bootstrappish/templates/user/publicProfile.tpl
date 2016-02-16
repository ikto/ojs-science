{**
 * templates/user/publicProfile.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Public user profile display.
 *
 *}
{strip}
{assign var="pageTitle" value="user.profile.publicProfile"}
{url|assign:"url" op="profile"}{include file="common/header.tpl"}
{/strip}

<div id="profilePicContent" style="float: right;">
	{assign var="profileImage" value=$user->getSetting('profileImage')}
	{if $profileImage}
		<img class="img-responsive" height="{$profileImage.height|escape}" width="{$profileImage.width|escape}" alt="{translate key="user.profile.profileImage"}" src="{$sitePublicFilesDir}/{$profileImage.uploadName}" />
	{/if}
</div>

<div id="mainContent">
	<h4>
		{$user->getFullName()|escape}
		{if $isUserLoggedIn}
			{url|assign:"mailUrl" page="user" op="email" to=$user->getEmail()|to_array}
			{icon name="mail" url=$mailUrl}
		{/if}
	</h4>

	<div class="table-responsive">
		<table class="table table-striped" width="100%">
			{if $user->getLocalizedAffiliation()}
				<tr valign="top">
					<td width="20%">
						{translate key="user.affiliation"}
					</td>
					<td class="data" width="80%">
						{$user->getLocalizedAffiliation()|escape|nl2br}
					</td>
				</tr>
			{/if}{* $user->getLocalizedAffiliation() *}

			{if $user->getLocalizedBiography()}
				<tr valign="top">
					<td>
						{translate key="user.biography"}
					</td>
					<td class="data">
						{$user->getLocalizedBiography()|strip_unsafe_html}
					</td>
				</tr>
			{/if}{* $user->getLocalizedBiography() *}
		</table>
	</div>
</div>{* id="mainContent" *}

{include file="common/footer.tpl"}