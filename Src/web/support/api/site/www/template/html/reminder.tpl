<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="main">
				<form class="form-horizontal well" id="reminder" method='POST' action='{$host/}/reminder' itemprop="create">
					<fieldset>
						<legend>Username/ Password Reminder</legend>
						<p>If you've forgotten your Username or Password, simply fill in your e-mail address below, then answer your security question. We will assign you a new random password and remind you of your Username via email. Once you log back in you may choose your own password by editing your member profile. </p>
						<div class="control-group">
							<label class="control-label" itemprop="email">Email</label>
							<div class="controls">
								<input type="email" class="input-xlarge" id="email" name="email" rel="popover" data-content="Enter your email" data-original-title="Email" placeholder="email@example.com" value="{$form.email/}" required />
							</div>
						</div>
						<div class="control-group">
							<label class="control-label"></label>
							<div class="controls">
								<button type="submit" class="btn btn-primary" >Check e-mail</button>
								<input type="reset" class="btn btn-default" value="Reset" />
							</div>
						</div>
						{if isset="$error"}
							<div class="control-group">
								<label class="control-label">Error</label>
								{$error/}
							</div>
						{/if}
					</fieldset>
				</form>
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
