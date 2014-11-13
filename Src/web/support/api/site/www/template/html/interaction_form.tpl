<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container-fluid" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="main">
				{if isset="$id"}
					<form class="form-inline well" action="{$host/}/report_detail/{$form.report.number/}/interaction_form/{$id/}" id="report" method="POST" enctype="multipart/form-data" itemprop="update">
				{/if}
				{unless isset="$id"}
					<form class="form-inline well" action="{$host/}/report_detail/{$form.report.number/}/interaction_form" id="report" method="POST" enctype="multipart/form-data" itemprop="create">
				{/unless}
					<fieldset>
						<legend><h1>Problem Report Interaction Submission</h1></legend>
						<p>Fill in the description for the new interaction for the <strong>{$form.report.status.synopsis/}</strong> problem report <a target="_blank" href="{$host/}/report_detail/{$form.report.number/}">{$form.report.number/}</a>.</p>
						<div class="row">
							<div class="col-xs-12">
								<label class="control-label" for="textarea">Description</label>
								<div class="controls">
									<textarea class="form-control input-xlarge" id="description" name="description" rows="17" placeholder="Give a description of the problem" required form="report">{$form.description/}</textarea>
								</div>
							</div>
						</div>
						<p></p>
						{if condition="$form.is_responsible_or_admin"}
						<div class="row">
							<div class="col-xs-12" itemprop="private">
								{if condition="$form.private"}
									<input type="checkbox" id="checkbox-private" name="private" value="True" checked/>
								{/if}
								{unless condition="$form.private"}
									<input type="checkbox" id="checkbox-private" name="private" value="True"/>
								{/unless}
								<label class="checkbox" for="checkbox-private">Private</label>
							</div>
						</div>
						{/if}
						{if condition="$has_access"}
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label" itemprop="category">Change Category from {$form.report.category.synopsis/} to </label>
							</div>
							<div class="col-xs-4">
								<select class="form-control" data-style="btn-primary" name="category" form="report">
									<option value="0">ALL</option>
									{foreach from="$categories" item="item"}
										{if condition="$item.id = $form.category"}
											<option value="{$item.id/}" selected>{$item.synopsis/}</option>
										{/if}
										{unless condition="$item.id = $form.category"}
											<option value="{$item.id/}">{$item.synopsis/}</option>
										{/unless}
									{/foreach}
								</select>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label" itemprop="status">Change status from {$form.report.status.synopsis/} to </label>
							</div>
							<div class="col-xs-4">
								<select class="form-control" data-style="btn-primary" name="status" form="report">
									<option value="0">ALL</option>
									{foreach from="$status" item="item"}
										{if condition="$item.id = $form.selected_status"}
											<option value="{$item.id/}" selected>{$item.synopsis/}</option>
										{/if}
										{unless condition="$item.id = $form.selected_status"}
											<option value="{$item.id/}">{$item.synopsis/}</option>
										{/unless}
									{/foreach}
								</select>
							</div>
						</div>
						{/if}
						{if isset="$temporary_files"}
						<div class="control-group">
							<label class="control-label" for="fileInput" itemprop="attachments">Temporary Attachments</label>
							{foreach from="temporary_files" item="item"}
								<div class="controls">
									<input type="checkbox" id="checkbox-{$item.name/}" name="temporary_files" value="{$item.name/}" checked />
									<label class="checkbox" for="checkbox-{$item.name/}">{$item.name/}</label>
									<br/>
								</div>
							{/foreach}
						</div>
						{/if}

						<div class="row">
							<div class="col-xs-1">
								<label class="control-label" for="fileInput">Attachments</label>
							</div>
							<div class="col-xs-10">
								<div class="controls">
									<input class="form-control input-file" name="uploaded_file[]" id="fileInput" type="file" multiple>
								</div>
								<small><p>Note: Attachments files size cannot exceed 10240 kilobytes (10 MB).</p></small>
							</div>
						</div>
						<hr>
						<div class="form-actions">
							<button type="submit" class="btn btn-primary">Preview</button>
							<input type="reset" class="btn btn-default" value="Reset">
						</div>
					</fieldset>
				</form>
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
