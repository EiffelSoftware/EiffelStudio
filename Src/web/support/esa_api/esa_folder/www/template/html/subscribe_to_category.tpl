<!DOCTYPE html>
<html lang="en">

	{include file="head.tpl"/}


	<body>

		{include file="navbar.tpl"/}	

		<div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
			<form class="form-inline well" id="registerHere" method='POST' action='{$host/}/subscribe_to_category' itemprop="update">
				<fieldset>
					<legend>Problem Report Categories Selection</legend>
					<div class="span3"><p>The information in this page is used by Eiffel Software should we need to contact you.
						We will never share this information with other companies.
						Please provide as much information as possible so we can better assist you.</p>
					</div>
					<input type="hidden" name="subscriber_to_category" value="-1"/>

 					{foreach from="$categories" item="item"}
						{if condition="$item.subscribed"}
                      		<label class="checkbox inline" for="checkboxes-{$item.id/}">
                         			<input type="checkbox" name="subscriber_to_category" value="{$item.id/}" checked /> {$item.synopsis/}
                      		</label> </br>   
                    	{/if}
                    	{unless condition="$item.subscribed"}
                              <label class="checkbox inline" for="checkboxes-{$item.id/}">
                                 <input type="checkbox" name="subscriber_to_category" value="{$item.id/}"/> {$item.synopsis/}
                              </label> </br>
                    	{/unless}
                	{/foreach}					
					<div class="row">
							<div class="col-sm-12">
								<button type="submit" class="btn btn-primary" id="input01">Subscribe</button>
								<input type="reset" class="btn btn-default" value="Reset">
							</div>
					</div>
						
					{if isset="$has_error"}
						<div class="control-group">
							<label class="control-label">Errors</label>
							{foreach from="$form.errors" item="item"}
									{$item/} <br>
							{/foreach}
						</div>		
					{/if}	
							
				</fieldset>
			</form>
		</div>
		<!-- Placed at the end of the document so the pages load faster -->

		{include file="optional_enhancement_js.tpl"/}
	</body>
</html>
