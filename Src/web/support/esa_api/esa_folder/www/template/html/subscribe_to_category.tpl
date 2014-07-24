<!DOCTYPE html>
<html lang="en">

	{include file="master/head.tpl"/}


	<body>

		{include file="master/navbar.tpl"/}	

		<div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
			<form class="form-inline well" id="registerHere" method='POST' action='{$host/}/subscribe_to_category' itemprop="update">
				<fieldset>
					<legend>Problem Report Categories Selection</legend>
					<div class="span3"><p>Select the categories you would like to subscribe to below. Once subscribed to a category, you will receive a notification each time a problem report is submitted to that category or a new interaction is added to an existing problem report from that category.</p>
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
