 	<div class="primary-tabs">
 		<div>
			{foreach item="item" from="$oauth_consumers"}
				<a href="{$site_url/}account/login-with-oauth/{$item/}">Login with {$item/}</a><br>
			{/foreach}	
		</div>    	
	</div>
