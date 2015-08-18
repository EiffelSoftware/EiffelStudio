	<div class="container-fluid">
		<div class="main">
				{if isset="$id"}
					<form class="form-inline well" action="{$site_url/}resources/wish_form/{$id/}" id="wish" method="POST" enctype="multipart/form-data" itemprop="update">
						{if isset="$status"}
							<input type="hidden" name="status" value="{$status.id/}">
						{/if}
				{/if}
				{unless isset="$id"}
					<form class="form-inline well" action="{$site_url/}resources/wish_form" id="wish" method="POST" enctype="multipart/form-data" itemprop="create">
				{/unless}
						{unless isset="$status"}
							<input type="hidden" name="status" value="1">
						{/unless}
					<fieldset>
						<legend>Wish Submission</legend>
						<div class="row">
							<div class="col-xs-3">
								<div class="row">
									<div class="col-xs-3" itemprop="category">
										<label class="control-label-api" data-original-title="The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.">Category</label>
									</div>
									<div class="col-xs-4">
										<select class="form-control" data-style="btn-primary" name="category" form="wish" required>
											<option value=""></option>
											{foreach from="$categories" item="item"}
												{if condition="$item.id = $category"}
													<option value="{$item.id/}" selected>{$item.synopsis/}</option>
												{/if}
												{unless condition="$item.id = $category"}
													<option value="{$item.id/}">{$item.synopsis/}</option>
												{/unless}
											{/foreach}
										</select>
									</div>
								</div>
							</div>
							{if false}-- It is a small entry, so make the column narrower {/if}
						{if isset="$uploaded_files"}
							<div class="row">
								<label class="control-label" itemprop="attachments">Attachments</label>
								{foreach from="uploaded_files" item="item"}
									<div class="controls">
										<input type="checkbox" id="checkbox-{$item.name/}" name="uploaded_files" value="{$item.name/}" checked />
										<label class="checkbox" for="checkbox-{$item.name/}"/>{$item.name/}</label>
										<button onclick="myFunction()">View</button>
										<br/>
									</div>
								{/foreach}
							</div>
						{/if}
						<div class="row">
							<label class="control-label" for="fileInput" itemprop="attachment" data-original-title="<p>List of files that will be stored together with the description of the problem</p>">Temporary Attachments</label>
							<div class="controls">
								<input class="form-control input-file" name="uploaded_file[]" id="fileInput" type="file" multiple>
							</div>
							<small><p>Note: Attachments files size cannot exceed 10240 kilobytes (10 MB).</p></small>

						</div>	
						<div class="row" has-error>
							<label class="control-label" has-success has-feedback itemprop="synopsis" data-original-title="<p>One-line summary of the problem. This information will be used as the subject of the problem and it should be short, but still descriptive enough to be different from other problem wish subjects.</p>">Synopsis</label>
							<div class="controls">
								<input type="text" id="synopsis" name="synopsis" class="form-control" value="{$synopsis/}" required>
							</div>
						</div>

						<div class="row" has-error>
							<label class="control-label" for="description" itemprop="description" data-original-title="<p>Precise description of the problem.</p>">Description</label>
							<div class="controls">
								<textarea class="form-control input-xlarge" id="description" name="description" rows="17" placeholder="" maxlength="32768" required form="wish">{$description/}</textarea>
							</div>
							<small><p>Note: Description cannot exceed 32768 bytes (32 KB).</p></small>

						</div>
						<hr>
						{if isset="$id"}
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Update</button>
								<a href="{$site_url/}resources/wish_list">Go to wish list</a>
							</div>
						{/if}
						{unless isset="$id"}
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Save</button>
								<input type="reset" class="btn btn-default" value="Reset"></p>
							</div>
						{/unless}
				</form>
			</div>
		</div>
