 				{if isset="$user"}
 					<li class="menu-item"><a href="{$host/}/logout">Logout</a></li>
				{/if}
				{unless isset="$user"}
					<li class="menu-item"><a href="{$host/}/login_with_github">Login</a></li>
				{/unless}

 				
				
