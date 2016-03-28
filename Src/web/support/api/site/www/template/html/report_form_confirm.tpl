<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container-fluid" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="main">
				<div class="panel panel-default">
					<div class="panel-heading">
						<strong>Problem Report Submission Confirmation</strong>
					</div>
					<div class="panel-body">
						<div class="form-inline">
							<div class="row">
								<div class="col-xs-4">
									<label class="label label-primary-api-default" itemprop="category">Category:</label>
									<span>
									{foreach from="$form.categories" item="item"}
										{if condition="$item.id = $category"}
													{$item.synopsis/}
										{/if}
									{/foreach}
									</span>
								</div>
								<div class="col-xs-4">
									<label class="label label-primary-api-default" itemprop="severity">Severity:</label>
										{foreach from="$form.severities" item="item"}
											{if condition="$item.id = $severity"}
														{$item.synopsis/}
											{/if}
										{/foreach}
								</div>
								<div class="col-xs-4">
									<label class="label label-primary-api-default" itemprop="priority">Priority:</label>
									{foreach from="$form.priorities" item="item"}
										{if condition="$item.id = $priority"}
													{$item.synopsis/}
										{/if}
									{/foreach}
								</div>
							</div>
							<div class="row">
								<div class="col-xs-4">
									<label class="label label-primary-api-default" itemprop="class">Class:</label>
									{foreach from="$form.classes" item="item"}
										{if condition="$item.id = $class"}
													{$item.synopsis/}
										{/if}
									{/foreach}
								</div>
								<div class="col-xs-4">
									<label class="label label-primary-api-default" itemprop="confidential">Confidential:</label>
									{if condition="$confidential"}
										Yes
									{/if}
									{unless condition="confidential"}
										No
									{/unless}
								</div>
								<div class="col-xs-4">
									<label class="label label-primary-api-default" has-success has-feedback itemprop="release">Release:</label>
									<span>{$release/}</span>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<label class="label label-primary-api-default" itemprop="environment">Environment:</label>
									<span>{$environment/}</span>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12">
									<label class="label label-primary-api-default" has-success has-feedback itemprop="synopsis">Synopsis:</label>
									<span>{$synopsis/}</span>
								</div>
							</div>
							{if isset="$attachments"}
							<div class="row">
								<div class="col-xs-4">
									<label class="label label-primary-api-default" itemprop="attachments">Attachments:</label>
									<span>
										{foreach from="$attachments" item="item"}
											{$item/} 
										{/foreach}
									</span>
								</div>
							</div>
							{/if}
							<div class="row">
								<div class="col-xs-4">
									<label class="label label-primary-api-default" itemprop="description">Description:</label>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12" id="textarea_17">
									<pre>{htmlentities}{$description/}{/htmlentities}</pre>
								</div>
							</div>
							{if isset="$to_reproduce"}
							<div class="row">
								<div class="col-xs-4">
									<label class="control-label" itemprop="to_reproduce">To Reproduce:</label>
								</div>
							</div>
							<div class="row">
								<div class="col-xs-12" id="textarea_7">
								    <pre>
										{htmlentities}{$to_reproduce/}{/htmlentities}
									</pre>
								</div>
							</div>
							{/if}
							<hr/>
							<div class="form-actions">
								<form action="{$host/}/report_confirm" method="POST" itemprop="create">
									<button type="submit" class="btn btn-xs btn-primary">Confirm</button>
									<input type="hidden" id="confirm" name="confirm" class="form-control" value="{$id/}" />
									<a class="btn btn-xs btn-primary" href="{$host/}/report_form/{$id/}" itemprop="update" rel="update">Edit</a>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
