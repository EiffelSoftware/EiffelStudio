				<footer id="footer">
					<div class="container">
						<div class="footer-holder">
							<nav class="footer-nav">
								<ul>
									<li><a href="{$site_url/}welcome">Welcome</a>
										<ul>
											<li><a href="{$site_url/}purpose">Purpose</a></li>
											<li><a href="{$site_url/}news">What's new</a></li>
											<li><a href="{$site_url/}updates">Recent updates</a></li>
											<li><a href="{$site_url/}contact">Contact</a></li>
										</ul>
									</li>
									<li><a href="{$site_url/}documentation">Documentation</a>
										<ul>
											<li><a href="#">Documentation</a></li>
											<li><a href="#">Tutorials</a></li>
											<li><a href="#">Packages</a></li>
											<li><a href="#">FAQs</a></li>
										</ul>	
									</li>
									<li><a href="{$site_url/}resources">Resources</a>
										<ul>
											<li><a href="{$site_url/}resources/libraries">Libraries</a></li>
											<li><a href="{$site_url/}resources/tools">Tools</a></li>
											<li><a href="{$site_url/}resources/videos">Videos</a></li>
											<li><a href="{$site_url/}resources/Eiffel_Wish_List">Eiffel wish list</a></li>
											<li><a href="{$site_url/}resources/follow_us">Follow us</a></li>
										</ul>
									</li>
									<li><a href="{$site_url/}contribute">Contribute</a>
									</li>
						
								</ul>
							</nav>
							<div class="btn-holder">
								<a class="btn btn-download" href="{$site_url/}download_options">Download Now</a>
								<a class="btn btn-tryonline" href="{$site_url/}try_eiffel">Try Eiffel Online</a>
							</div>
							<div class="social-holder">
								<ul class="social-networks">
									<li><a class="facebook" target="_blank" href="https://www.facebook.com/eiffelsoftware">Facebook</a></li>
									<li><a class="youtube" target="_blank" href="http://www.youtube.com/user/EiffelLanguage">You Tube</a></li>
									<li><a class="twitter" target="_blank" href="https://twitter.com/eiffel_software">Twitter</a></li>
									<li><a class="googleplus" target="_blank" href="https://plus.google.com/117564431713099800122/posts">Google Plus</a></li>
								</ul>
							</div>
						</div>
						{if isset="$page.region_footer"}
							{$page.region_footer/}
						{/if}
					</div>
				</footer>
