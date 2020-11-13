	 {if isset="$user"}
		<h3>Account Information</h3>
		<ul class="user-information">
			<div>	
				<label>Username:</label>  {htmlentities}{$user.name/}{/htmlentities}
			</div>
			<div>	
				<label>Email:</label>  {$user.email/}
			</div>
			<div>	
				<label>Profile name:</label>  {htmlentities}{$user.profile_name/}{/htmlentities}
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
			   		<label>{htmlentities}{$the_name/}{/htmlentities}:</label><div>{htmlentities}{$the_value/}{/htmlentities}</div>
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
