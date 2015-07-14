						<div class="container header-holder">
							<strong class="logo"><a href="{$site_url/}"><img src="{$site_url/}theme/images/logo.png" width="226" height="60" alt="Eiffel"></a></strong>
							<nav id="nav">
								<ul>
									<li><a href="{$site_url/}welcome">welcome</a></li>
									<li><a href="{$site_url/}documentation">documentation</a></li>
									<li><a href="{$site_url/}resources">resources</a></li>
									<li><a href="{$site_url/}contribute">contribute</a></li>
									<li><a href="{$site_url/}download_options">download</a></li>
								</ul>
							</nav>
							<div class="header-right">
								<nav class="add-links">
									<ul> 
									{unless isempty="$user"}
									<li><a href="{$site_url/}account">{$user.name/}</a></li>
									{/unless}
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

