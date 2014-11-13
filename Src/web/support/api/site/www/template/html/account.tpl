<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}	
		<div class="container-fluid" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<form class="form-inline well" id="registerHere" method='POST' action='{$host/}/account' itemprop="update">
				<fieldset>
					<legend>Account Information</legend>
					<div class="span3"><p>The information in this page is used by Eiffel Software should we need to contact you.
						We will never share this information with other companies.
						Please provide as much information as possible so we can better assist you.</p>
					</div>

					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="first_name">First Name</label>
						</div>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="input01" name="first_name" rel="popover" data-content="Enter your first" data-original-title="First Name" value="{$account.first_name/}">
						</div>
					</div>

					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="last_name">Last Name</label>
						</div>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="input01" name="last_name" rel="popover" data-content="Enter your last name" data-original-title="Last Name" value="{$account.last_name/}">
						</div>
					</div>

					<div class="row">
						<div class="col-xs-1">
							<label class=" control-label-api" itemprop="email">Email</label>
						</div>
						<div class="col-xs-6">
							<input type="email" class="form-control" id="input01" name="user_email" rel="popover" data-content="What is your email address?" data-original-title="Email" value="{$account.email/}" disabled>
						</div>
					</div>

					<div class="row">
						<div class="col-xs-1">
							<label class=" control-label-api" itemprop="country">Country</label>
						</div>
						<div class="col-xs-6">
							<select class="form-control" id="input01"	data-style="btn-primary" name="country" >
								{foreach from="$account.countries" item="item"}
								{if condition="$item.id ~ $account.selected_country"}
									<option value="{$item.id/}" selected>{$item.name/}</option>
								{/if}
								{unless condition="$item.id ~ $account.selected_country"}
									<option value="{$item.id/}">{$item.name/}</option>
								{/unless}
								{/foreach}
							</select>
						</div>
					</div>

					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="region">Region</label>
						</div>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="input01" name="user_region" rel="popover" data-content="Enter your region" data-original-title="Region" value="{$account.region/}">
						</div>
					</div>
								
					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="position">Position</label>
						</div>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="input01" name="user_position" rel="popover" data-content="Enter your position" data-original-title="Position" value="{$account.position/}">
						</div>
					</div>

					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="city">City</label>
						</div>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="input01" name="user_city" rel="popover" data-content="Enter your city" data-original-title="city" value="{$account.city/}">
						</div>
					</div>			

					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="address">Address</label>
						</div>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="input01" name="user_address" rel="popover" data-content="Enter your address" data-original-title="Address" value="{$account.address/}">
						</div>
					</div>

					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="postal_code">Postal Code</label>
						</div>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="input01" name="user_postal_code" rel="popover" data-content="Enter your postal code" data-original-title="Postal Code" value="{$account.postal_code/}">
						</div>
					</div>			

					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="telephone">Telephone</label>
						</div>
						<div class="col-xs-6">
							<input type="tel" class="form-control" id="input01" name="user_phone" rel="popover" data-content="Enter your phone" data-original-title="phone" value="{$account.telephone/}">
						</div>
					</div>		

					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="fax">Fax</label>
						</div>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="input01" name="user_fax" rel="popover" data-content="Enter your fax" data-original-title="fax" value="{$account.fax/}">
						</div>
					</div>
						
					<input type="hidden" class="input-xlarge" id="input01" name="user_name" rel="popover"	value="{$account.username/}">
							
					<div class="row">
							<div class="col-xs-12">
								<button type="submit" class="btn btn-primary" id="input01">Update</button>
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
		{include file="master/footer.tpl"/}
	</body>
</html>
