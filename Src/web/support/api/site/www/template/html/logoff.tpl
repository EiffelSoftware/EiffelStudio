<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}		 
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container">
			<div class="row">
				<div class="span12">
					<div class="hero-unit center" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
						<h1>You have successfully signed out</h1>
						<br />
						<p>You may want to return</p>
						<p><b>Press this neat little button:</b></p>
						<a href="{$host/}" class="btn btn-large btn-primary" itemprop="home" rel="home"><i class="glyphicon glyphicon-home"></i> Take Me Home</a>
					</div>
					<br />
				</div>
			</div>
		</div>
		{include file="master/footer.tpl"/}		 
	</body>
</html>

