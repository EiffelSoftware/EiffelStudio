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
				{unless isempty="$user.last_login_date"}
			   	<div>	
			   		<label>Last login:</label>  {$user.last_login_date/}
			   	</div>	
				{/unless}
			   	<div>
			   		<form method="get" action="{$site_url/}{$strategy/}">
    					<button type="submit">Logout</button>
					</form>
			   	</div>	
			</div>
    	</div>
    	<hr>
    	{include file="block_change_password.tpl" /}
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
	</div>
