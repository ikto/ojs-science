{**
 * templates/manager/people/email.tpl
 *
 * Copyright (c) 2003-2012 John Willinsky
 * Distributed under the GNU GPL v2. For full terms see the file docs/COPYING.
 *
 * Generic email template form
 *
 *}
{strip}
{assign var="pageTitle" value="email.compose"}
{assign var="pageCrumbTitle" value="email.email"}
{include file="common/header.tpl"}
{/strip}

<script type="text/javascript">
{literal}
<!--
function deleteAttachment(fileId) {
	document.getElementById('submit').deleteAttachment.value = fileId;
	document.getElementById('submit').submit();
}
// -->
{/literal}
</script>

<div id="genericEmail" class="col-md-12 mag-innert-left">
	<form role="form" method="post" id="submit" action="{$formActionUrl}"{if $attachmentsEnabled} enctype="multipart/form-data"{/if}>
		<input type="hidden" name="continued" value="1"/>
		
		{if $attachmentsEnabled}
			<input type="hidden" name="deleteAttachment" value="" />
			{foreach from=$persistAttachments item=temporaryFile}
				<input type="hidden" name="persistAttachments[]" value="{$temporaryFile->getId()}" />
			{/foreach}
		{/if}

		{if $hiddenFormParams}
			{foreach from=$hiddenFormParams item=hiddenFormParam key=key}
				<input type="hidden" name="{$key|escape}" value="{$hiddenFormParam|escape}" />
			{/foreach}
		{/if}

		{include file="common/formErrors.tpl"}

		{foreach from=$errorMessages item=message}
			{if !$notFirstMessage}
				{assign var=notFirstMessage value=1}
				<h4>{translate key="form.errorsOccurred"}</h4>
				<ul class="stay">
			{/if}
			{if $message.type == MAIL_ERROR_INVALID_EMAIL}
				{translate|assign:"message" key="email.invalid" email=$message.address}
				<li>{$message|escape}</li>
			{/if}
		{/foreach}
		{if $notFirstMessage}</ul>{/if}

		<br/>

		<div class="table-responsive">
			<table class="table table-striped" width="100%">
				<tr valign="top">
					<td width="20%">{fieldLabel name="to" key="email.to"}</td>
					<td width="80%" class="value">
						{foreach from=$to item=toAddress}
							<div class="form-group"><input type="text" name="to[]" id="to" value="{if $toAddress.name != ''}{$toAddress.name|escape} &lt;{$toAddress.email|escape}&gt;{else}{$toAddress.email|escape}{/if}" {if !$addressFieldsEnabled}disabled="disabled" {/if}size="40" maxlength="120" class="form-control" /></div><br/>
						{foreachelse}
							<div class="form-group"><input type="text" name="to[]" id="to" size="40" maxlength="120" class="form-control" {if !$addressFieldsEnabled}disabled="disabled" {/if}/></div>
						{/foreach}

						{if $blankTo}
							<div class="form-group"><input type="text" name="to[]" id="to" size="40" maxlength="120" class="form-control" {if !$addressFieldsEnabled}disabled="disabled" {/if}/></div>
						{/if}
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="cc" key="email.cc"}</td>
					<td class="value">
						{foreach from=$cc item=ccAddress}
							<div class="form-group"><input type="text" name="cc[]" id="cc" value="{if $ccAddress.name != ''}{$ccAddress.name|escape} &lt;{$ccAddress.email|escape}&gt;{else}{$ccAddress.email|escape}{/if}" size="40" maxlength="120" class="form-control" {if !$addressFieldsEnabled}disabled="disabled" {/if}/></div><br/>
						{foreachelse}
							<div class="form-group"><input type="text" name="cc[]" id="cc" size="40" maxlength="120" class="form-control" {if !$addressFieldsEnabled}disabled="disabled" {/if}/></div>
						{/foreach}

						{if $blankCc}
							<div class="form-group"><input type="text" name="cc[]" id="cc" size="40" maxlength="120" class="form-control" {if !$addressFieldsEnabled}disabled="disabled" {/if}/></div>
						{/if}
					</td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="bcc" key="email.bcc"}</td>
					<td class="value">
						{foreach from=$bcc item=bccAddress}
							<div class="form-group"><input type="text" name="bcc[]" id="bcc" value="{if $bccAddress.name != ''}{$bccAddress.name|escape} &lt;{$bccAddress.email|escape}&gt;{else}{$bccAddress.email|escape}{/if}" size="40" maxlength="120" class="form-control" {if !$addressFieldsEnabled}disabled="disabled" {/if}/></div><br/>
						{foreachelse}
							<div class="form-group"><input type="text" name="bcc[]" id="bcc" size="40" maxlength="120" class="form-control" {if !$addressFieldsEnabled}disabled="disabled" {/if}/></div>
						{/foreach}

						{if $blankBcc}
							<div class="form-group"><input type="text" name="bcc[]" id="bcc" size="40" maxlength="120" class="form-control" {if !$addressFieldsEnabled}disabled="disabled" {/if}/></div>
						{/if}
					</td>
				</tr>
				{if $addressFieldsEnabled}
					<tr valign="top">
						<td>&nbsp;</td>
						<td class="value">
							<input type="submit" name="blankTo" class="btn btn-success" value="{translate key="email.addToRecipient"}"/>
							<input type="submit" name="blankCc" class="btn btn-success" value="{translate key="email.addCcRecipient"}"/>
							<input type="submit" name="blankBcc" class="btn btn-success" value="{translate key="email.addBccRecipient"}"/>
						</td>
					</tr>
				{/if}{* $addressFieldsEnabled *}

				{if $attachmentsEnabled}
					<tr valign="top">
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr valign="top">
						<td>{translate key="email.attachments"}</td>
						<td class="value">
							{assign var=attachmentNum value=1}
							{foreach from=$persistAttachments item=temporaryFile}
								{$attachmentNum|escape}.&nbsp;{$temporaryFile->getOriginalFileName()|escape}&nbsp;
								({$temporaryFile->getNiceFileSize()})&nbsp;
								<a href="javascript:deleteAttachment({$temporaryFile->getId()})" class="action">{translate key="common.delete"}</a>
								<br/>
								{assign var=attachmentNum value=$attachmentNum+1}
							{/foreach}

							{if $attachmentNum != 1}<br/>{/if}

							<div class="form-group"><input type="file" name="newAttachment" class="form-control" /></div> <input name="addAttachment" type="submit" class="btn btn-success" value="{translate key="common.upload"}" />
						</td>
					</tr>
				{/if}
				<tr valign="top">
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr valign="top">
					<td>{translate key="email.from"}</td>
					<td class="value">{$from|escape}</td>
				</tr>
				<tr valign="top">
					<td width="20%">{fieldLabel name="subject" key="email.subject"}</td>
					<td width="80%" class="value"><div class="form-group"><input type="text" id="subject" name="subject" value="{$subject|escape}" size="60" maxlength="120" class="form-control" /></div></td>
				</tr>
				<tr valign="top">
					<td>{fieldLabel name="body" key="email.body"}</td>
					<td class="value"><div class="form-group"><textarea name="body" cols="60" rows="15" class="form-control">{$body|escape}</textarea></div></td>
				</tr>
			</table>
		</div>

		<p><input name="send" type="submit" value="{translate key="email.send"}" class="btn btn-success" /> <input type="button" value="{translate key="common.cancel"}" class="btn btn-danger" onclick="history.go(-1)" /></p>
	</form>
</div>

{include file="common/footer.tpl"}