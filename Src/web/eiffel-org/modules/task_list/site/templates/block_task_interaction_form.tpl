		<div class="row">
				{if isset="$id"}
					<form class="form-inline well" action="{$site_url/}{$resource_path/}/{$module_item/}/detail/{$form.wish.id/}/interaction_form/{$id/}" id="wish" method="POST" enctype="multipart/form-data" itemprop="update">
				{/if}
				{unless isset="$id"}
					<form class="form-inline well" action="{$site_url/}{$resource_path/}/{$module_item/}/detail/{$form.wish.id/}/interaction_form" id="wish" method="POST" enctype="multipart/form-data" itemprop="create">
				{/unless}
					<fieldset>
						<legend><h1>Wish Interaction Submission</h1></legend>
						<p>Fill in the description for the new interaction for the <strong>{$form.wish.status.synopsis/}</strong> item wish <a target="_blank" href="{$site_url/}{$resource_path/}/{$module_item/}/{$form.wish.id/}/detail">{$form.wish.id/}</a>.</p>
								<label class="control-label" for="textarea">Description</label>
								<div class="controls">
									<textarea class="class-form-textarea" id="description" name="description" rows="17" placeholder="" required form="wish">{$form.description/}</textarea>
								</div>
						<p></p>
						{if condition="$can_edit_category"}
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label" itemprop="category">Change Category from <strong>{$form.wish.category.synopsis/}</strong> to </label>
							</div>
							<div class="col-xs-4">
								<select class="form-control" data-style="btn-primary" name="category" form="wish">
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
						{/if}
						{if condition="$can_edit_status"}
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label" itemprop="status">Change status from <strong>{$form.wish.status.synopsis/}</strong> to </label>
							</div>
							<div class="col-xs-4">
								<select class="form-control" data-style="btn-primary" name="status" form="wish">
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
						{if isset="$uploaded_files"}
						<div class="control-group">
							<label class="control-label" for="fileInput" itemprop="attachments">Attachments</label>
							{foreach from="uploaded_files" item="item"}
								<div class="controls">
									<input type="checkbox" id="checkbox-{$item.name/}" name="uploaded_files" value="{$item.name/}" checked />
									<label class="checkbox" for="checkbox-{$item.name/}">{$item.name/}</label>
									<br/>
								</div>
							{/foreach}
						</div>
						{/if}

						<div class="row">
							<div class="col-xs-1">
								<label class="control-label" for="fileInput">Temporary Attachments</label>
							</div>
							<div class="col-xs-10">
								<div class="controls">
									<input class="form-control input-file" name="uploaded_file[]" id="fileInput" type="file" multiple>
								</div>
								<small><p>Note: Attachments files size cannot exceed 10240 kilobytes (10 MB).</p></small>
							</div>
						</div>
						<hr>
						{if isset="$id"}
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Update</button>
								<a href="{$site_url/}{$resource_path/}/{$module_item/}_list">Go to wish list</a>
							</div>
						{/if}
						{unless isset="$id"}
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Save</button>
								<input type="reset" class="btn btn-default" value="Reset"></p>
							</div>
						{/unless}
					</fieldset>
				</form>
			</div>
	