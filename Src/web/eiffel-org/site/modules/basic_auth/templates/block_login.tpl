 	<div class="primary-tabs">
 		{unless isset="$user"}
			<h3>Login or <a href="{$site_url/}account/roc-register">Register</a></h3>
		<div>
			<div>	
			    <form name="cms_basic_auth" action method="POST">
					<div>
						<input type="text" name="username" id="username" required>
						<label>Username</label>
					</div>
										
					<div>
						<input  type="password" name="password"  id="password" required>
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
		{/unless}
	</div>
