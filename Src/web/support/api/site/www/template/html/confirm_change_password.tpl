<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}	
		<div class="container-fluid" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="col-xs-12">
				<form class="form-inline well" id="registerHere" method='POST' action='{$host/}/password-reset' itemprop="update">
					<legend><h1>Update Password</h1></legend>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" for="inputPassword" itemprop="password">Password</label>
							</div>
							<div class="col-xs-6">
								<input type="password" class="form-control" id="inputPassword" name="password" placeholder="Password"/>
							</div>
						</div>

						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" for="confirmPassword" itemprop="check_password">Confirm Password</label>
							</div>
							<div class="col-xs-6">
								<input type="password" class="form-control" id="confirmPassword" name="check_password" placeholder="Confirm Password"/>
							</div>
						</div>
						<div class="row">
							<div class="col-xs-2">
								<label class="control-label-api" for="inputToken" itemprop="token">Token</label>
							</div>
							<div class="col-xs-6">
								<input type="text" class="form-control" id="inputToken" name="token" value="{$token/}" placeholder="Token"/>
							</div>
						</div>
							<p></p>
						<div class="row">
							<div class="col-xs-4">
								<input type="submit" class="btn btn-primary" value="Submit"/>
								<input type="reset" class="btn btn-default" value="Reset"/>
							</div>
						</div>
					{if isset="$has_error"} 
						<div class="control-group">
							<label class="col-sm-offset-1	label label-danger">Errors</label>
							{foreach from="$form.errors" item="item"}
								<br>	<span class="col-sm-offset-1 label label-warning">{$item/} </span> 
							{/foreach}
						</div>		
					{/if}
				</form>				
			</div>
		</div> 
		{include file="master/footer.tpl"/} 
	</body>
</html>
