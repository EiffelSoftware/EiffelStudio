<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container-fluid" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="col-xs-12">
				<form class="form-inline well" id="changeEmail" method='POST' action='{$host/}/email' itemprop="create" >
					<legend><h1>Change Email</h1></legend>
					<p>Use this form to update your email:</p>
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" for="inputEmail" itemprop="email">Email</label>
						</div>
						<div class="col-xs-6">
							<input type="email" class="form-control" id="inputEmail" name="email" placeholder="Email"/>
						</div>
					</div>

					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" for="confirmEmail" itemprop="check_password">Confirm Email</label>
						</div>
						<div class="col-xs-6">
							<input type="email" class="form-control" id="confirmEmail" name="check_email" placeholder="Confirm Email"/>
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
					{if isset="$email_changed"}
						<div class="control-group">
							<p>Your new email was successfully added, please confirm it to make it your default account email.</p>
						</div>
					{/if}
				</form>
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
