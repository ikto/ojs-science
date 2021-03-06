{**
 * templates/manager/people/enrollSync.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Synchronize user enrollment with another journal.
 *
 *}
{strip}
{assign var="pageTitle" value="manager.people.enrollment"}
{include file="common/header.tpl"}
{/strip}

<div id="syncUsers" class="col-md-12 mag-innert-left">
	<h3>{translate key="manager.people.syncUsers"}</h3>
	<p class="help-block">{translate key="manager.people.syncUserDescription"}</p>

	<form role="form" method="post" action="{url op="enrollSync"}">
		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr valign="top">
					<td width="20%"><label class="control-label" for="rolePath">{translate key="manager.people.enrollSyncRole"}</label></td>
					<td width="80%" class="value">
						{if $rolePath}
							<input type="hidden" name="rolePath" value="{$rolePath|escape}" />
							{translate key=$roleName}
						{else}
							<div class="form-group">
								<select name="rolePath" id="rolePath" size="1" class="form-control">
									<option value=""></option>
									<option value="all">{translate key="manager.people.allUsers"}</option>
									<option value="manager">{translate key="user.role.manager"}</option>
									<option value="editor">{translate key="user.role.editor"}</option>
									<option value="sectionEditor">{translate key="user.role.sectionEditor"}</option>
									<option value="layoutEditor">{translate key="user.role.layoutEditor"}</option>
									<option value="reviewer">{translate key="user.role.reviewer"}</option>
									<option value="copyeditor">{translate key="user.role.copyeditor"}</option>
									<option value="proofreader">{translate key="user.role.proofreader"}</option>
									<option value="author">{translate key="user.role.author"}</option>
									<option value="reader">{translate key="user.role.reader"}</option>
									<option value="subscriptionManager">{translate key="user.role.subscriptionManager"}</option>
								</select>
							</div>
						{/if}
					</td>
				</tr>
				<tr valign="top">
					<td><label class="control-label" for="syncJournal">{translate key="manager.people.enrollSyncJournal"}</label></td>
					<td class="value">
						<div class="form-group">
							<select name="syncJournal" id="syncJournal" size="1" class="form-control">
								<option value=""></option>
								<option value="all">{translate key="manager.people.allJournals"}</option>
								{html_options options=$journalOptions}
							</select>
						</div>
					</td>
				</tr>
			</table>
		</div>

		<p><input type="submit" value="{translate key="manager.people.enrollSync"}" class="btn btn-warning" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-success" onclick="history.go(-1)" /></p>
	</form>
</div>

{include file="common/footer.tpl"}