		<div class="row">
				{if isset="$id"}
					<form class="form-inline well" action="{$site_url/}{$resource_path/}/{$module_item/}/{$id/}/form" id="wish" method="POST" enctype="multipart/form-data" itemprop="update">
						{if isset="$status"}
							<input type="hidden" name="status" value="{$status.id/}">
						{/if}
				{/if}
				{unless isset="$id"}
					<form class="form-inline well" action="{$site_url/}{$resource_path/}/{$module_item/}/form" id="wish" method="POST" enctype="multipart/form-data" itemprop="create">
				{/unless}
						{unless isset="$status"}
							<input type="hidden" name="status" value="1">
						{/unless}
					<fieldset>
						<legend class="wish_submission">Wish Submission</legend>
						<label class="class-form-2 tooltip" title="The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.">Category</label>
						<select id="wish_category" class="class-form-4" data-style="btn-primary" name="category" form="wish" required onchange="onChangeCategory();">
											<option value=""></option>
											{foreach from="$categories" item="item"}
												{if condition="$item.id = $category"}
													<option value="{$item.id/}" selected>{htmlentities}{$item.synopsis/}{/htmlentities}</option>
												{/if}
												{unless condition="$item.id = $category"}
													<option value="{$item.id/}">{htmlentities}{$item.synopsis/}{/htmlentities}</option>
												{/unless}
											{/foreach}
						</select>
						{if false}-- It is a small entry, so make the column narrower {/if}
						{if isset="$uploaded_files"}
						<label class="class-form-6" itemprop="attachments">Attachments</label>
								{foreach from="uploaded_files" item="item"}
									<div class="controls">
										<input type="checkbox" id="checkbox-{$item.name/}" name="uploaded_files" value="{$item.name/}" checked />
										<label class="checkbox" for="checkbox-{$item.name/}"/>{$item.name/}</label>
										<button onclick="myFunction()">View</button>
										<br/>
									</div>
								{/foreach}
						{/if}
						<label class="class-form-2 tooltip" for="fileInput" itemprop="attachment" title="<p>List of files that will be stored together with the description of the problem</p>">Temporary Attachments</label>
								<input  name="uploaded_file[]" id="fileInput" type="file" multiple>
							<small><p>Note: Attachments files size cannot exceed 10240 kilobytes (10 MB).</p></small>

							<label class="class-form-4 tooltip" has-success has-feedback itemprop="synopsis" title="<p>One-line summary of the problem. This information will be used as the subject of the problem and it should be short, but still descriptive enough to be different from other problem wish subjects.</p>">Synopsis</label>
							<input type="text" id="synopsis" name="synopsis" class="form-control" placeholder="synopsis" value="{htmlentities}{$synopsis/}{/htmlentities}" required>
							<div>
							<label class="class-form-12 tooltip" for="description" itemprop="description" title="<p>Precise description of the problem.</p>">Description</label>
							<textarea  id="wish_textarea" class="class-form-textarea" id="description" name="description" rows="17" placeholder="" maxlength="32768" required form="wish">{htmlentities}{$description/}{/htmlentities}</textarea>
							<small><p>Note: Description cannot exceed 32768 bytes (32 KB).</p></small>
							</div>
						<hr>
						{if isset="$id"}
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Update</button>
								<a href="{$site_url/}{$resource_path/}/{$module_item/}_list">Go to {$module_item/} list</a>
							</div>
						{/if}
						{unless isset="$id"}
							<div class="form-actions">
								<button type="submit" class="btn btn-primary">Save</button>
								<input type="reset" class="btn btn-primary" value="Reset"></p>
							</div>
						{/unless}
				</form>
			</div>
