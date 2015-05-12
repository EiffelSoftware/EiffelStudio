						<div class="container header-holder">
							<strong class="logo"><a href="{$site_url/}"><img src="/theme/images/logo.png" width="226" height="60" alt="Eiffel"></a></strong>
							<nav id="nav">
								<ul>
									<li><a href="{$site_url/}/welcome">welcome</a></li>
									<li><a href="{$site_url/}/documentation">documentation</a></li>
									<li><a href="{$site_url/}/resources">resources</a></li>
									<li><a href="{$site_url/}/contribute">contribute</a></li>
									<li><a href="{$site_url/}/download_options">download</a>
                                        {if condition = "False"}
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
									    {/if}	
									</li>
								</ul>
							</nav>
							<div class="header-right">
								<nav class="add-links">
									<ul> <li></li>
							{if condition = "False"}
										{if isset="$user"}
											<li><a href="{$site_url/}/user">My-Account</a></li>
											<li><a href="{$site_url/}/user/logout">LOG OUT</a></li>
										{/if}
										{unless isset="$user"}
											<li><a href="{$site_url/}/user/register">register</a></li>
											<li><a href="{$site_url/}/user">LOG IN</a></li>
										{/unless}
							{/if}
									</ul>
								</nav>
								<form class="search-form" method="GET" action="http://www.google.com/search"> 
									<input type="text" name="q" size="25" maxlength="255" value=""placeholder=""/>
									<input type="checkbox" name="sitesearch" value="{$site_url/}" checked style="opacity:0; position:absolute; left:9999px;"/>
								</form>
							</div>
						</div>
						{assign name="empty" value=""/}
						{unless condition="$page.region_header ~ $empty"}
							<div class="container">
								<div class="promo-area">
									{$page.region_header/}
								</div>	
							</div>
						{/unless}	

