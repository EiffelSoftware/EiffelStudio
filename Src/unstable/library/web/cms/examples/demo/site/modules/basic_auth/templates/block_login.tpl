 	<div class="primary-tabs">
 		{unless isset="$user"}
			<h3>Login or <a href="{$site_url/}account/roc-register">Register</a></h3>
		<div>
			<div>	
			    <form action method="POST">
					<div>
						<input type="text" name="username" required>
						<label>Username</label>
					</div>
										
					<div>
						<input  type="password" name="password" required>
						<label>Password</label>
					</div>
        
					<button type="button" onclick="ROC_AUTH.login();">Login</button>
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
		<div>
			{foreach item="item" from="$oauth_consumers"}
				<a href="{$site_url/}account/login-with-oauth/{$item/}">Login with {$item/}</a><br>
			{/foreach}	
		</div>    	
		{/unless}
	</div>
