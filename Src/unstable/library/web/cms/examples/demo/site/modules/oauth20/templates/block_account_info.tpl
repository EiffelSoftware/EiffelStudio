	<hr>
		{unless isempty="$oauth_associated"}
    	<h4>Un-Associate Account with Oauth Consumer</h4>
    	<div>
    		{foreach item="consumer" from="$oauth_associated"}
    			<div>
    				<form method="post" action="{$site_url/}account/oauth-un-associate">
						<input type="hidden" name="consumer" value="{htmlentities}{$consumer/}{/htmlentities}"/>
          				<div>
                			<button type="submit">Unlink {htmlentities}{$consumer/}{/htmlentities}</button>
              			</div>
          			</form>	
			   	</div>
    		{/foreach}
    	</div>
		{/unless}
		{unless isempty="$oauth_not_associated"}
    	<h4>Associate Account with Oauth Consumer</h4>
    	<div>
    		{foreach item="consumer" from="$oauth_not_associated"}
    			<div>
    				<form method="post" action="{$site_url/}account/oauth-associate">
						<input type="hidden" name="consumer" value="{htmlentities}{$consumer/}{/htmlentities}"/>
          				<div>
          				  <input type="email" id="email" name="email"  value="{htmlentities}{$email/}{/htmlentities}"  required/>	
                		  <button type="submit">Link with {htmlentities}{$consumer/}{/htmlentities}</button>
              			</div>  
					</form>	
			   	</div>
    		{/foreach}
    	</div>		
		{/unless}
