 <div>
 	<form action="{$site_url/}account/roc-openid-login" id="openid-login" method="POST">
		<div>
				<strong><label for="openid">OpenID identifier</label></strong><br/>
				<input type="text" name="openid" value="" size="50"/>
		</div>
		<div><input type="submit" name="op" value="Validate"/></div>
		<div hgv vtid="openid">Login with 			
			{foreach item="item" from="$openid_consumers"}
				<a href="{$site_url/}account/login-with-openid/{$item/}">{htmlentities}{$item/}{/htmlentities}</a><br>
			{/foreach}	
	</form>
	<div>
	  {if isset="$error"}
       <span><i>{$error/}</i></span> <br>
      {/if}
     </div> 
</div>
