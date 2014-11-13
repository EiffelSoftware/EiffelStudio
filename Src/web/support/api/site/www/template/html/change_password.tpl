<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container-fluid" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="col-xs-12">
				<form class="form-inline well" id="changePassword" method='POST' action='{$host/}/password' itemprop="update" >
					<legend><h1>Change Password</h1></legend>
					<p>Use this form to update your password:<p>
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
					<p></p>

					<div class="row">
						<div class="col-xs-4">
							<input type="submit" class="btn btn-primary" value="Submit"/>
							<input type="reset" class="btn btn-default" value="Reset"/>
						</div>
					</div>

					{if isset="$has_error"}
						<div class="control-group">
							<label class="col-xs-offset-1	label label-danger">Errors</label>
							{foreach from="$form.errors" item="item"}
								<br>	<span class="col-xs-offset-1 label label-warning">{$item/} </span>
							{/foreach}
						</div>
					{/if}
					{if isset="$password_changed"}
						<div class="control-group">
							<p>Your password was successfully changed, please sign in again.</p>
						</div>
					{/if}
				</form>
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
