						<div class="container header-holder">
							<strong class="logo"><a href="{$site_url/}"><img src="/theme/images/logo.png" width="226" height="60" alt="Eiffel"></a></strong>
							<nav id="nav">
								<ul>
									<li><a href="{$site_url/}/about#">about</a></li>
									<li><a href="{$site_url/}/learn">learn</a></li>
									<li><a href="{$site_url/}/contribute">contribute</a></li>
									<li><a href="{$site_url/}/download#">download</a>
										<div class="dropdown">
											<ul>
												<li><a href="#">Libraries</a></li>
												<li><a href="#">Projects</a></li>
												<li><a href="#">Tools</a></li>
												<li><a href="#">Feature</a></li>
												<li><a href="#">requests</a></li>
												<li><a href="#">Forum</a></li>
												<li><a href="#">Social Media</a></li>
											</ul>
										</div>
									</li>
								</ul>
							</nav>
							<div class="header-right">
								<nav class="add-links">
									<ul>
										{if isset="$user"}
										<li><a href="{$site_url/}/user">My-Account</a></li>
										<li><a href="{$site_url/}/user/logout">LOG OUT</a></li>
										{/if}
										{unless isset="$user"}
										<li><a href="{$site_url/}/user/register">register</a></li>
										<li><a href="{$site_url/}/user">LOG IN</a></li>
										{/unless}
									</ul>
								</nav>
								<form class="search-form">
									<input type="search" placeholder="">
								</form>
							</div>
						</div>
