{**
 * templates/manager/people/searchUsers.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Search form for enrolled users.
 *
 *
 *}
{strip}
{translate|assign:"pageTitleTranslated" key="manager.people.roleEnrollment" role=$roleName|translate}
{include file="common/header.tpl"}
{/strip}

<form role="form" id="disableUser" method="post" action="{url op="disableUser"}">
	<input type="hidden" name="reason" value=""/>
	<input type="hidden" name="userId" value=""/>
</form>

<script type="text/javascript">
{literal}
<!--
function confirmAndPrompt(userId) {
	var reason = prompt('{/literal}{translate|escape:"javascript" key="manager.people.confirmDisable"}{literal}');
	if (reason == null) return;

	document.getElementById('disableUser').reason.value = reason;
	document.getElementById('disableUser').userId.value = userId;

	document.getElementById('disableUser').submit();
}

function toggleChecked() {
	var elements = document.getElementById('enroll').elements;
	for (var i=0; i < elements.length; i++) {
		if (elements[i].name == 'users[]') {
			elements[i].checked = !elements[i].checked;
		}
	}
}
// -->
{/literal}
</script>

{if not $omitSearch}
	<form role="form" class="form-inline" method="post" id="submit" action="{url op="enrollSearch"}">
		<input type="hidden" name="roleId" value="{$roleId|escape}"/>
		<div class="form-group">
			<select name="searchField" size="1" class="form-control">
				{html_options_translate options=$fieldOptions selected=$searchField}
			</select>
		</div>
		<div class="form-group">
			<select name="searchMatch" size="1" class="form-control">
				<option value="contains"{if $searchMatch == 'contains'} selected="selected"{/if}>{translate key="form.contains"}</option>
				<option value="is"{if $searchMatch == 'is'} selected="selected"{/if}>{translate key="form.is"}</option>
				<option value="startsWith"{if $searchMatch == 'startsWith'} selected="selected"{/if}>{translate key="form.startsWith"}</option>
			</select>
		</div>
		<div class="form-group"><input type="text" size="15" name="search" class="form-control" value="{$search|escape}" /></div>&nbsp;<input type="submit" value="{translate key="common.search"}" class="btn btn-info" />
	</form>

	<br/>
	<p>{foreach from=$alphaList item=letter}<a href="{url op="enrollSearch" searchInitial=$letter roleId=$roleId}">{if $letter == $searchInitial}<strong>{$letter|escape}</strong>{else}{$letter|escape}{/if}</a> {/foreach}<a href="{url op="enrollSearch" roleId=$roleId}">{if $searchInitial==''}<strong>{translate key="common.all"}</strong>{else}{translate key="common.all"}{/if}</a></p>
{/if}

<form role="form" id="enroll" onsubmit="return enrollUser(0)" action="{if $roleId}{url op="enroll" path=$roleId}{else}{url op="enroll"}{/if}" method="post">
	{if !$roleId}
		<p>
			<p class="help-block">{translate key="manager.people.enrollUserAs"}:</p>
			<div class="form-group">
				<select name="roleId" size="1"  class="form-control">
					<option value=""></option>
					<option value="{$smarty.const.ROLE_ID_JOURNAL_MANAGER}">{translate key="user.role.manager"}</option>
					<option value="{$smarty.const.ROLE_ID_EDITOR}">{translate key="user.role.editor"}</option>
					<option value="{$smarty.const.ROLE_ID_SECTION_EDITOR}">{translate key="user.role.sectionEditor"}</option>
					{if $roleSettings.useLayoutEditors}
						<option value="{$smarty.const.ROLE_ID_LAYOUT_EDITOR}">{translate key="user.role.layoutEditor"}</option>
					{/if}
					{if $roleSettings.useCopyeditors}
						<option value="{$smarty.const.ROLE_ID_COPYEDITOR}">{translate key="user.role.copyeditor"}</option>
					{/if}
					{if $roleSettings.useProofreaders}
						<option value="{$smarty.const.ROLE_ID_PROOFREADER}">{translate key="user.role.proofreader"}</option>
					{/if}
					<option value="{$smarty.const.ROLE_ID_REVIEWER}">{translate key="user.role.reviewer"}</option>
					<option value="{$smarty.const.ROLE_ID_AUTHOR}">{translate key="user.role.author"}</option>
					<option value="{$smarty.const.ROLE_ID_READER}">{translate key="user.role.reader"}</option>
					<option value="{$smarty.const.ROLE_ID_SUBSCRIPTION_MANAGER}">{translate key="user.role.subscriptionManager"}</option>
				</select>
			</div>		
		</p>

		<script type="text/javascript">
		<!--
		function enrollUser(userId) {ldelim}
			var fakeUrl = '{url op="enroll" path="ROLE_ID" userId="USER_ID"}';
			if (document.getElementById('enroll').roleId.options[document.getElementById('enroll').roleId.selectedIndex].value == '') {ldelim}
				alert("{translate|escape:"javascript" key="manager.people.mustChooseRole"}");
				return false;
			{rdelim}
			if (userId != 0){ldelim}
			fakeUrl = fakeUrl.replace('ROLE_ID', document.getElementById('enroll').roleId.options[document.getElementById('enroll').roleId.selectedIndex].value);
			fakeUrl = fakeUrl.replace('USER_ID', userId);
			location.href = fakeUrl;
		{rdelim}
		{rdelim}
		// -->
		</script>
	{/if}

	<div id="users" class="table-responsive">
		<table width="100%" class="table table-striped">
			<tr><td colspan="5" class="headseparator">&nbsp;</td></tr>
			<tr class="heading" valign="bottom">
				<td width="5%">&nbsp;</td>
				<td width="25%"><label>{sort_heading key="user.username" sort="username"}</label></td>
				<td width="30%"><label>{sort_heading key="user.name" sort="name"}</label></td>
				<td width="10%"><label>{sort_heading key="user.email" sort="email"}</label></td>
				<td width="10%" align="right"><label>{translate key="common.action"}</label></td>
			</tr>
			<tr><td colspan="5" class="headseparator">&nbsp;</td></tr>
			{iterate from=users item=user}
				{assign var="userid" value=$user->getId()}
				{assign var="stats" value=$statistics[$userid]}
				<tr valign="top">
					<td><div class="form-group"><input type="checkbox" name="users[]" value="{$user->getId()}" /></div></td>
					<td><a class="action" href="{url op="userProfile" path=$userid}">{$user->getUsername()|escape}</a></td>
					<td>{$user->getFullName(true)|escape}</td>
					<td class="nowrap">
						{assign var=emailString value=$user->getFullName()|concat:" <":$user->getEmail():">"}
						{url|assign:"url" page="user" op="email" to=$emailString|to_array}
						{$user->getEmail()|truncate:20:"..."|escape}&nbsp;{icon name="mail" url=$url}
					</td>
					<td align="right" class="nowrap">
						{if $roleId}
						<a href="{url op="enroll" path=$roleId userId=$user->getId()}" class="action">{translate key="manager.people.enroll"}</a>
						{else}
						<a href="#" onclick="enrollUser({$user->getId()})" class="action">{translate key="manager.people.enroll"}</a>
						{/if}
						{if $thisUser->getId() != $user->getId()}
							{if $user->getDisabled()}
								|&nbsp;<a href="{url op="enableUser" path=$user->getId()}" class="action">{translate key="manager.people.enable"}</a>
							{else}
								|&nbsp;<a href="javascript:confirmAndPrompt({$user->getId()})" class="action">{translate key="manager.people.disable"}</a>
							{/if}
						{/if}
					</td>
				</tr>
				<tr><td colspan="5" class="{if $users->eof()}end{/if}separator">&nbsp;</td></tr>
			{/iterate}
			{if $users->wasEmpty()}
				<tr>
					<td colspan="5" class="nodata"><p class="help-block">{translate key="common.none"}</p></td>
				</tr>
				<tr><td colspan="5" class="endseparator">&nbsp;</td></tr>
			{else}
				<tr>
					<td colspan="3" align="left">{page_info iterator=$users}</td>
					<td colspan="2" align="right">{page_links anchor="users" name="users" iterator=$users searchInitial=$searchInitial searchField=$searchField searchMatch=$searchMatch search=$search dateFromDay=$dateFromDay dateFromYear=$dateFromYear dateFromMonth=$dateFromMonth dateToDay=$dateToDay dateToYear=$dateToYear dateToMonth=$dateToMonth roleId=$roleId sort=$sort sortDirection=$sortDirection}</td>
				</tr>
			{/if}
		</table>
	</div>

	<input type="submit" value="{translate key="manager.people.enrollSelected"}" class="btn btn-success" /> <input type="button" value="{translate key="common.selectAll"}" class="btn btn-success" onclick="toggleChecked()" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="document.location.href='{url page="manager" escape=false}'" />
</form>

{if $backLink}
	<a href="{$backLink}">{translate key="$backLinkLabel"}</a>
{/if}

{include file="common/footer.tpl"}