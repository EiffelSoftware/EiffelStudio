<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		{if isset="$user"}
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="hero-unit center" itemscope itemtype="https://www2.eiffel.com/beta/static/profile/esa_api.xml">
							<h1>Unauthorized Request <small><font face="Tahoma" color="red">Error 401</font></small></h1>
							<br />
							<p>The page you requested could not be served because user <b>{$user/}</b> doesn't have access to it. Either contact your webmaster or try again. Use your browser's <b>Back</b> button to navigate to the page you came from.</p>
							<p><b>Or you could just press this neat little button:</b></p>
							<a href="https://www2.eiffel.com/beta" class="btn btn-large btn-primary" iemprop="home" rel="home"><i class="glyphicon glyphicon-home"></i> Take Me Home</a>
						</div>
						<br/>
					</div>
				</div>
			</div>
		{/if}

		{unless isset="$user"}
			<div class="container">
				<div class="row">
					<div class="span12">
						<div class="modal-body" id="redirecLoginForm" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
							<a href="{$host/}/reminder" itemprop="reminder" rel="reminder">Forgot username or password?</a>
							<p></p>
							<form class="form-inline well"	data-rel="login" itemprop="login">
								<legend><h1>Sign In</h1></legend>
								<p>The page you requested could not be served because you don't have access to it. Either contact your webmaster or try again. Use your browser's <b>Back</b> button to navigate to the page you came from.</p>
								<p itemprop="user_name"><input type="text" class="span3" name="username" id="username" placeholder="Enter Username" value="" required></p>
								<p itemprop="password"><input type="password" class="span3" id="password" name="password" placeholder="Enter Password" required></p>
								<input type="hidden" name="redirect" value="{$redirect/}"/>
								<input type="hidden" name="host" value="{$host/}"/>
								<div class="controls">
									<button type="button" class="btn btn-primary" onclick="login_with_redirect();">Sign In</button>
									<input type="reset" class="btn btn-default" value="Reset"/><img src="{$host/}/static/images/ajax-loader.gif" alt="Loading..." style="display: none;" id="imgProgressRedirect" />
								</div>
							</form>
						</div>
					</div>
					<br/>
				</div>
			</div>
		{/unless}
		{include file="master/footer.tpl"/}
	</body>
</html>

