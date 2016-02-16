{**
 * templates/rtadmin/searches.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * RTAdmin search list
 *
 *}
{strip}
{assign var="pageTitle" value="rt.searches"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
$(document).ready(function() { setupTableDND("#dragTable", 
{/literal}
"{url op=moveSearch path=$version->getVersionId()|to_array:$context->getContextId()}"
{literal}
); });
{/literal}
</script>

<ul class="stay">
	<li><a href="{url op="editContext" path=$version->getVersionId()|to_array:$context->getContextId()}" class="action">{translate key="rt.admin.contexts.metadata"}</a></li>
	<li class="current"><a href="{url op="searches" path=$version->getVersionId()|to_array:$context->getContextId()}" class="action">{translate key="rt.searches"}</a></li>
</ul>

<br />

<div id="searches" class="col-md-12 mag-innert-left">
	<div class="table-responsive">
		<table class="table table-striped" width="100%" id="dragTable">
			<tr><td class="headseparator" colspan="3">&nbsp;</td></tr>
			<tr valign="top">
				<td class="heading" width="50%"><label>{translate key="rt.search.title"}</label></td>
				<td class="heading" width="30%"><label>{translate key="rt.search.url"}</label></td>
				<td class="heading" width="20%" align="right">&nbsp;</td>
			</tr>
			<tr><td class="headseparator" colspan="3">&nbsp;</td></tr>
			{iterate from=searches item=search}
				<tr valign="top" class="data" id=search-{$search->getSearchId()}>
					<td class="drag">{$search->getTitle()|escape}</td>
					<td class="drag">{$search->getUrl()|truncate:30|escape}</td>
					<td align="right"><a href="{url op="moveSearch" path=$version->getVersionId()|to_array:$context->getContextId() id=$search->getSearchId() dir=u}" class="action">&uarr;</a>&nbsp;<a href="{url op="moveSearch" path=$version->getVersionId()|to_array:$context->getContextId() id=$search->getSearchId() dir=d}" class="action">&darr;</a>&nbsp;|&nbsp;<a href="{url op="editSearch" path=$version->getVersionId()|to_array:$context->getContextId():$search->getSearchId()}" class="action">{translate key="common.edit"}</a>&nbsp;|&nbsp;<a href="{url op="deleteSearch" path=$version->getVersionId()|to_array:$context->getContextId():$search->getSearchId()}" onclick="return confirm('{translate|escape:"jsparam" key="rt.admin.searches.confirmDelete"}')" class="action">{translate key="common.delete"}</a></td>
				</tr>
				{if $searches->eof()}
					<tr><td class="endseparator" colspan="3"></td></tr>
				{/if}
			{/iterate}
			{if $searches->wasEmpty()}
				<tr valign="top">
					<td class="nodata" colspan="3"><p class="help-block">{translate key="common.none"}</p></td>
				</tr>
				<tr><td class="endseparator" colspan="3"></td></tr>
			{else}
				<tr>
					<td align="left">{page_info iterator=$searches}</td>
					<td colspan="2" align="right">{page_links anchor="searches" name="searches" iterator=$searches}</td>
				</tr>
			{/if}
		</table>
	</div>
	
	<br/>

	<a href="{url op="createSearch" path=$version->getVersionId()|to_array:$context->getContextId()}" class="action">{translate key="rt.admin.searches.createSearch"}</a><br/>
</div>

{include file="common/footer.tpl"}