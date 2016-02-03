{unless isset="$user"}
 	<div class="login-box">
		<div class="description">The "Basic Auth" relies on the HTTP basic acces authentication.<br/>(see also: <a href="https://en.wikipedia.org/wiki/Basic_access_authentication">https://en.wikipedia.org/wiki/Basic_access_authentication</a> )</div>
		<h3>Login or <a href="{$site_url/}account/roc-register">Register</a></h3>
		<div>
			<form name="cms_basic_auth" action="{$site_url/}roc-basic-login" method="POST">
				<input type="hidden" name="host" id="host" value="{$site_url/}">
				<div>
					<input type="text" name="username" id="username" required>
					<label>Username</label>
				</div>
				<div>
					<input type="password" name="password"  id="password" required>
					<label>Password</label>
				</div>
				<button type="button" onclick="ROC_AUTH.login();">Login</button>
			</form>
    	</div>
		<div>
			<a href="{$site_url/}account/new-password">Forgot password?</a>
		</div>	
	</div>
{/unless}
