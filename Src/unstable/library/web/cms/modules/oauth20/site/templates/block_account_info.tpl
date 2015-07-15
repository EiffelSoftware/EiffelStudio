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