<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="hero-unit center">
				<h1>Eiffel Support Activation</h1>
				<br/>
				<p>An e-mail with an activation code was sent to your account.</p>
				<p>Please check your email and use the provided link to <a href="{$host/}/activation" itemprop="activation" rel="activation">activate</a> your account.</p>
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
