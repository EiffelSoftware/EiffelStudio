				<footer id="footer">
					<div class="container">
						<div class="footer-holder">
							<nav class="footer-nav">
								<ul>
									<li><a href="/about">ABOUT</a>
										<ul>
											<li><a href="/purpose">Purpose</a></li>
											<li><a href="/news">News</a></li>
											<li><a href="/articles">Articles</a></li>
											<li><a href="/contact">Contact</a></li>
										</ul>
									</li>
									<li><a href="#">LEARN</a>
										<ul>
											<li><a href="#">Documentation</a></li>
											<li><a href="#">Tutorials</a></li>
											<li><a href="#">Packages</a></li>
											<li><a href="#">FAQs</a></li>
										</ul>	
									</li>
									<li><a href="#">Contribute</a>
										<ul>
											<li><a href="{$site_url/}/contribute_description">Libraries</a></li>
											<li><a href="{$site_url/}/contribute_description">Projects</a></li>
											<li><a href="{$site_url/}/contribute_description">Tools</a></li>
											<li><a href="{$site_url/}/contribute_description">Feature Requests</a></li>
											<li><a href="{$site_url/}/contribute_description">Forum</a></li>
										</ul>
									</li>
						
								</ul>
							</nav>
							<div class="btn-holder">
								<a class="btn btn-download" href="{$site_url/}/download_options">Download Now</a>
								<a class="btn btn-tryonline" href="{$site_url/}/try_eiffel">Try Eiffel Online</a>
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
