<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container">
			<div class="row">
				<div class="span12" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
					<h1>Internal Server Error <small><font face="Tahoma" color="red">Error 500</font></small></h1>
					<br />
					<p>The page you requested could not be served because the server is down, either contact your webmaster or try again. Use your browser's <b>Back</b> button to navigate to the page you came from.</p>
					<p><b>Or you could just press this neat little button:</b></p>
					<a href="{$host/}" class="btn btn-large btn-primary" itemprop="home" rel="home"><i class="glyphicon glyphicon-home"></i> Take Me Home</a>
				</div>
				<br />
			</div>
		 </div>
		{include file="master/footer.tpl"/}
	</body>
</html>

