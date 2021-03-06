{**
 * templates/manager/importexport/plugins.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * List available import/export plugins.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.importExport"}
{include file="common/header.tpl"}
{/strip}

<ul class="list-group">
	{foreach from=$plugins item=plugin}
		<li class="list-group-item"><a href="{url op="importexport" path="plugin"|to_array:$plugin->getName()}">{$plugin->getDisplayName()|escape}</a>:&nbsp;<p class="help-block">{$plugin->getDescription()|escape}</p></li>
	{/foreach}
</ul>

{include file="common/footer.tpl"}