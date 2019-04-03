<footer id="footer">
	<div class="container">
		<nav class="footer-nav">
			<ul class="grid-5 has-gutter">
				<li class="one-sixth"><a href="{$site_url/}welcome">Welcome</a>
					<ul>
						<li><a href="{$site_url/}purpose">Purpose</a></li>
						<li><a href="{$site_url/}news">News</a></li>
						<li><a href="{$site_url/}updates">Updates</a></li>
						<li><a href="{$site_url/}forum">Forum</a></li>
						<li><a href="{$site_url/}community">Community</a></li>
						<li><a href="{$site_url/}contact">Contact</a></li>
						{if isempty="$user"}
						<li>
						{unless isempty="$site_sign_in_url"}<a href="{$site_sign_in_url/}">Sign in</a>{/unless}
						{if isempty="$site_sign_in_url"}<a href="{$site_url/}account">Sign in</a>{/if}
						</li>
						{/if}
					</ul>
				</li>
				<li class="one-sixth"><a href="{$site_url/}documentation">Documentation</a>
					<ul>
						<li><a href="{$site_url/}doc/eiffel">Eiffel</a></li>
						<li><a href="{$site_url/}doc/eiffelstudio">EiffelStudio</a></li>
						<li><a href="{$site_url/}doc/solutions">Solutions</a></li>
						<li><a href="{$site_url/}doc/glossary">Glossary</a></li>
						<li><a href="{$site_url/}doc/faqs">FAQs</a></li>
						<li><a href="{$site_url/}contribute">Contribute</a></li>
					</ul>	
				</li>
				<li class="one-sixth"><a href="{$site_url/}resources">Resources</a>
					<ul>
						<li><a href="{$site_url/}resources/libraries">Libraries</a></li>
						<li><a href="{$site_url/}resources/tools">Tools</a></li>
						<li><a href="{$site_url/}resources/wish_list">Wish list</a></li>
						<li><a href="{$site_url/}resources/videos">Videos</a></li>
						<li><a href="{$site_url/}resources/follow_us">Follow us</a></li>
					</ul>
				</li>
				<li class="">
					<div class="btn-holder">
						<a class="btn btn-download" href="{$site_url/}downloads">Download Now</a>
						<a class="btn btn-tryonline" href="{$site_url/}try_eiffel">Try Eiffel Online</a>
						<a class="btn btn-contribute" href="{$site_url/}contribute">Contribute</a>
						{if isempty="$user"}
							{unless isempty="$site_sign_in_url"}<a class="btn btn-account" href="{$site_sign_in_url/}">Sign in</a>{/unless}
							{if isempty="$site_sign_in_url"}<a class="btn btn-account" href="{$site_url/}account">Sign in</a>{/if}
						{/if}
						{unless isempty="$user"}
							<a class="btn btn-account" href="{$site_url/}account">{htmlentities}{$user.name/}{/htmlentities}</a>
						{/unless}
					</div>
				</li>
				<li class="one-sixth">
					<ul class="social-networks">
						<li><a class="facebook" target="_blank" href="https://www.facebook.com/pages/Eiffel-Programming-Language/235981463124887">Facebook</a></li>
						<li><a class="youtube" target="_blank" href="http://www.youtube.com/user/EiffelLanguage">You Tube</a></li>
						<li><a class="twitter" target="_blank" href="https://twitter.com/Eiffel_Language">Twitter</a></li>
					</ul>
				</li>
			</ul>
		</nav>
		{if isset="$page.region_footer"}
			{$page.region_footer/}
		{/if}
	</div>
</footer>
