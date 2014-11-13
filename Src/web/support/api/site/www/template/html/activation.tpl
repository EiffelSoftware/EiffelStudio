<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container-fluid" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="col-xs-12">
				<form class="form-inline well" id="registerHere" method='POST' action='{$host/}/activation' itemprop="create">
					<legend><h1>Account Activation</h1></legend>
					<p>Enter the activation token associated with the email address you registered.</p>
					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="email">Email</label>
						</div>
						<div class="col-xs-6">
							<input type="email" class="form-control" id="email" name="email" rel="popover" data-content="Enter your email" data-original-title="Email" placeholder="Email" value="{$form.email/}"/>
						</div>
					</div>
					<div class="row">
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="token">Token</label>
						</div>
						<div class="col-xs-6">
							<input type="text" class="form-control" id="token" name="token" rel="popover" data-content="Enter your roken" data-original-title="Token" placeholder="Token" value="{$form.token/}"/>
						</div>
					</div>
					<p></p>

					<div class="row">
						<div class="col-xs-4">
							<input type="submit" class="btn btn-primary" value="Activate"/>
							<input type="reset" class="btn btn-default" value="Reset"/>
						</div>
					</div>

					{if isset="$error"}
						<div class="control-group">
							<label class="control-label">Error</label>
							{$error/}
						</div>
					{/if}
				</form>
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
