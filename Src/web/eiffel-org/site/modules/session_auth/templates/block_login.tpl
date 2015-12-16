 	<div class="primary-tabs">
 		{unless isset="$user"}
			<h3>Login or <a href="{$site_url/}account/roc-register">Register</a></h3>
		<div>
			<div>	
			    <form name="cms_session_auth" action="{$site_url/}account/login-with-session" method="POST">
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
    	</div>
		<div>
			<div>
				<p>
					<a href="{$site_url/}account/new-password">Forgot password?</a>
				</p>
			</div>
		</div>	
		{/unless}
		{if isset=$error}
			<div>
			<div>
				<p>
					<strong>{$error/}
				</p>
			</div>
		</div>	
		{/if}
	</div>
