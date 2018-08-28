 	<div class="primary-tabs">
 		<div>
			{foreach item="item" from="$oauth_consumers"}
				<a href="{$site_url/}account/auth/login-with-oauth/{$item/}">Login with {htmlentities}{$item/}{/htmlentities}</a><br>
			{/foreach}	
		</div>    	
	</div>
