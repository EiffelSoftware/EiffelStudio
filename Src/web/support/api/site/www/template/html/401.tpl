<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		<div class="navbar navbar-default navbar-fixed-top" role="navigation" itemscope="itemscope" itemtype="{$host/}/static/profile/esa_api.xml">
			<input id="host_pe" type="hidden" name="host" value="{$host/}"/>
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span>
					</button>
					<a class="navbar-brand" href="{$host/}" itemprop="home" rel="home">Eiffel Support Site</a>
				</div>
				<div class="navbar-collapse collapse" itemscope="itemscope" itemtype="{$host/}/static/profile/esa_api.xml#report" >
					<ul class="nav navbar-nav navbar-left">
						<li><a href="{$host/}/reports" class="active" itemprop="all" rel="all">Reports</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="{$host/}/register" itemprop="register" rel="register">Register</a></li>	
					</ul>
				</div>		
			</div>	
		</div>
		<div class="main">
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
								<p itemprop="password"><input type="password" class="span3" id="password_redirect" name="password" placeholder="Enter Password" required></p>
								<p itemprop="remember_me"><input type="checkbox" name="remember_me" value="remember me"> Remember me<br>
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
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>

