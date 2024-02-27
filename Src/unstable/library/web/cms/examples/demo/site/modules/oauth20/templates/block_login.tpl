 	<div class="primary-tabs">
 		<div>
			{foreach item="item" from="$oauth_consumers"}
				<a href="{$site_url/}account/auth/login-with-oauth/{$item/}{unless isempty="$site_destination"}?destination={htmlentities}{$site_destination/}{/htmlentities}{/unless}">Login with {htmlentities}{$item/}{/htmlentities}</a><br>
			{/foreach}	
		</div>    	
	</div>
