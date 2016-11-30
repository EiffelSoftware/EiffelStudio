{unless isset="$user"}
<div class="login-box">
	<div class="description">The "Session" is the standard authentication system. (based on cookie)</div>
	<h3>Login or <a href="{$site_url/}account/roc-register">Register</a></h3>
	<div>
		<form name="cms_session_auth" action="{$site_url/}account/auth/roc-session-login" method="POST">
			{unless isempty="$site_destination"}<input type="hidden" name="destination" value="{$site_destination/}">{/unless}
			<div>
				<input type="text" name="username" id="username" required value="{$username/}">
				<label>Username</label>
			</div>
			<div>
				<input  type="password" name="password"  id="password" required >
				<label>Password</label>
			</div>
			<button type="submit">Login</button>
		</form>
	</div>
	<div>
		<a href="{$site_url/}account/new-password">Forgot password?</a>
	</div>	
	{if isset="$error"}<div class="error">{$error/}</div>{/if}
</div>
{/unless}
