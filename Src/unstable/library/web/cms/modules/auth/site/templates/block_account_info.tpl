 	<div class="primary-tabs">
	 {if isset="$user"}
		<h3>Account Information</h3>
		<div>
			<div>
				<div>	
			   		<label>Username:</label>  {$user.name/}
			   	</div>
			   	<div>	
			   		<label>Email:</label>  {$user.email/}
			   	</div>
			   	<div>	
			   		<label>Creation Date:</label>  {$user.creation_date/}
			   	</div>
			   	<div>	
			   		<label>Last login:</label>  {$user.last_login_date/}
			   	</div>	
			   	<div>
			   		<form method="get" action="{$site_url/}{$auth_login_strategy/}">
    					<button type="submit">Logout</button>
					</form>
			   	</div>	
			</div>
    	</div>
    	<hr>
    	{include file="block_change_password.tpl" /}
    	<hr>
    	<h4>Un-Associate Account with Oauth Consumer</h4>
    	<div>
    		{foreach item="consumer" from="$oauth_associated"}
    			<div>
    				<form method="post" action="{$site_url/}account/oauth-un-associate">
    					<div>
                		  	 <input type="hidden" name="consumer" value="{$consumer/}"/>
              			</div>
          				<div>
                			<button type="submit">Unlink {$consumer/}</button>
              			</div>
          			</form>	
			   	</div>
    		{/foreach}
    	</div>
    	<h4>Associate Account with Oauth Consumer</h4>
    	<div>
    		{foreach item="consumer" from="$oauth_not_associated"}
    			<div>
    				<form method="post" action="{$site_url/}account/oauth-associate">
    					<div>
                		  <input type="hidden" name="consumer" value="{$consumer/}"/>
              			</div>
          				<div>
          				  <input type="email" id="email" name="email"  value="{$email/}"  required/>	
                		  <button type="submit">Link with {$consumer/}</button>
              			</div>  
					</form>	
			   	</div>
    		{/foreach}
    	</div>		

    	<hr>
    	<h4>Roles</h4>
    	<div>
    		{foreach item="ic" from="$roles"}
    			<div>	
			   		<ul>
			   			<li>
			   				<strong>{$ic.name/}</strong>
			   				<ul>
			   					<li> <i>permissions</i> 
				   					<ul>	
					   					{foreach item="ip" from="$ic.permissions"}
					   						<li>{$ip/}</li>
					   					{/foreach}
					   				</ul>
					   			</li>	
			   				</ul>		
			   			</li>
			   		</ul>
			   	</div>
    		{/foreach}
    	</div>		


    	<hr>
    	<h4>Profile</h4>
    	<div>
    		{foreach item="the_value" key="the_name" from="$user.profile"}
    			<div>	
			   		<label>{$the_name/}:</label>  {$the_value/} 
			   	</div>
    		{/foreach}
    	</div>		
	{/if}
	{unless isset="$user"}
		<div>
			<p> You are not logged in </p>
				<a href="{$site_url/}account/roc-login">Go to the login page</a>
		</div>	
	{/unless}
	</div>
