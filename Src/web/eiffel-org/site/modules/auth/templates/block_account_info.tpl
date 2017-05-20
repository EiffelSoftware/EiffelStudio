 	<div class="primary-tabs">
	 {if isset="$user"}
		<h3>Account Information</h3>
		<ul class="user-information">
			<div>	
				<label>Username:</label>  {$user.name/}
			</div>
			<div>	
				<label>Email:</label>  {$user.email/}
			</div>
			<div>	
				<label>Profile name:</label>  {$user.profile_name/}
			</div>
			<div>	
				<label>Creation Date:</label>  {$user.creation_date/} (UTC)
			</div>
			<div>	
				<label>Last login:</label>  {$user.last_login_date/} (UTC)
			</div>	
			<div>
				<form method="get" action="{$site_url/}account/roc-logout">
					<button type="submit">Logout</button>
				</form>
			</div>	
    	</ul>
    	<hr>
    	<h4>Profile</h4>
    	<ul class="user-profile">
    		{foreach item="the_value" key="the_name" from="$user.profile"}
    			<li>	
			   		<label>{$the_name/}:</label><div>{$the_value/}</div>
			   	</li>
    		{/foreach}
    	</ul>
	{/if}
	{unless isset="$user"}
		<div>
			<p> You are not logged in </p>
				<a href="{$site_url/}account/roc-login">Go to the login page</a>
		</div>	
	{/unless}
	</div>
