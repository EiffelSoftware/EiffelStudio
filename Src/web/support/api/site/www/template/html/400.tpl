<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container">
			<div class="row">
				<div class="span12">
					<div class="hero-unit center" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
						<h1>Bad Request <small><font face="Tahoma" color="red">Error 400</font></small></h1>
						<br/>
						<p>The page you requested could not be served because it's not well formed. Either contact your webmaster or try again. Use your browser's <b>Back</b> button to navigate to the page you came from.</p>
						<p><b>Or you could just press this neat little button:</b></p>
						<a href="{$host/}" class="btn btn-large btn-primary" itemprop="home" rel="home"><i class="glyphicon glyphicon-home"></i> Take Me Home</a>
					</div>
					<br/>

					{if isset="$errors"}
						<div class="control-group">
							<label class="col-xs-offset-1	label label-danger">Errors</label>
							{foreach from="$errors" item="item"}
								<br>	<span class="col-xs-offset-1 label label-warning">{$item/} </span>
							{/foreach}
						</div>
					{/if}
				</div>
			</div>
		</div>
		{include file="master/footer.tpl"}
	</body>
</html>
