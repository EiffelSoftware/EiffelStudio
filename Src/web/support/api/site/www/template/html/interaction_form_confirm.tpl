<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
			<div class="main">
				<div class="form-horizontal well">
					<fieldset>
						<legend><h1>Interaction Submission Confirmation</h1></legend>
						<div class="control-group">
							<label class="control-label" for="textarea" itemprop="description">Confidential</label>
							{if condition="$form.private"}
								<div class="controls">Yes</div>
							{/if}
							{unless condition="$form.private"}
								<div class="controls">No</div>
							{/unless}
						</div>

						<div class="control-group">
							<label class="control-label" for="textarea" itemprop="description">Description</label>
							<div class="controls">
								<pre>{htmlentities}{$form.description/}{/htmlentities}</pre>
							</div>
						</div>
						{if condition="$has_access"}
							{if isset="$new_status"}
								<div class="control-group">
									<label class="control-label" for="textarea" itemprop="status">Change status from {$form.report.status.synopsis/} to</label>
									<div class="controls">
										{foreach from="$status" item="item"}
											{if condition="$item.id = $form.selected_status"}
												{$item.synopsis/}
											{/if}
										{/foreach}
									</div>
								</div>
							{/if}
							{if isset="$new_category"}
								<div class="control-group">
									<label class="control-label" for="textarea" itemprop="category">Change category from {$form.report.category.synopsis/} to</label>
									<div class="controls">
										{foreach from="$categories" item="item"}
											{if condition="$item.id = $form.category"}
												{$item.synopsis/}
											{/if}
										{/foreach}
									</div>
								</div>
							{/if}
						{/if}	
						{if isset="$private"}
							<div class="control-group">
								<label class="control-label" for="textarea" itemprop="private">Change Private from {$form.report.confidential/} to</label>
								<div class="controls">{$private/}</div>
							</div>
						{/if}
						{if isset="$attachments"}
						<div class="control-group">
							<label class="control-label" for="textarea" itemprop="attachments">Attachments</label>
							<div class="controls">
								{foreach from="$attachments" item="item"}
									{$item/} </br>
								{/foreach}
							</div>
						</div>
						{/if}
						<hr/>
						<div class="form-actions">
							<form action="{$host/}/report_detail/{$form.report.number/}/interaction_confirm" method="POST" itemprop="create">
								<button type="submit" class="btn btn-xs btn-primary">Confirm</button>
								<input type="hidden" id="confirm" name="confirm" class="form-control" value="{$form.id/}"/>
								<a class="btn btn-xs btn-primary" href="{$host/}/report_detail/{$form.report.number/}/interaction_form/{$form.id/}" itemprop="update" rel="update">Edit</a>
							</form>
						</div>
					</fieldset>
				</div>
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
