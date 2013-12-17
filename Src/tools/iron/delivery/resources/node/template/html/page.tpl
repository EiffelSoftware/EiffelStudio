<html xmlns="http://www.w3.org/1999/xhtml">
<head><title>{$title/}</title>
<link rel="stylesheet" href="{$base_url/}/repository/html/style.css" type="text/css"/>
<link rel="stylesheet" href="{$base_url/}/repository/html/bootstrap/css/bootstrap.min.css" type="text/css"/>
<link rel="stylesheet" href="{$base_url/}/repository/html/bootstrap/css/bootstrap-theme.min.css" type="text/css"/>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<script type="text/javascript" src="{$base_url/}/repository/html/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="{$base_url/}/repository/html/iron.js"></script>
{$head/}
</head>
<body>
<div id="page">
  <div id="header">{$big_title/}</div>
  <nav class="navbar navbar-default" role="navigation">
		<!-- Brand and toggle get grouped for better mobile display -->
	  <div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-iron-navbar-collapse-1">
		  <span class="sr-only">Toggle navigation</span>
		  <span class="icon-bar"></span>
		  <span class="icon-bar"></span>
		  <span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="{$current_url/}"><span class="glyphicon glyphicon-refresh"/></a>
	  </div>
	  <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
		  {unless isempty="$menu"}
				{foreach item="i_menu" from="$menu"}<li {if condition="$i_menu.is_active"}class ="active"{/if}>
					<a href="{$i_menu.url/}">{htmlentities}{$i_menu.title/}{/htmlentities}</a>
				</li>{/foreach}
		  {/unless}
		  {if isempty="$iron_version_switch_urls"}
			  {unless isempty="$iron_version"}<li>{$iron_version/}</li>{/unless}
		  {/if}
		  {unless isempty="$iron_version_switch_urls"}
			  <li class="dropdown">
				<a href="#" class="dropdown-toggle" data-toggle="dropdown">
					{if isset="$iron_version"}{$iron_version.value/}{/if}
					{unless isset="$iron_version"}version...{/unless}
					<b class="caret"></b>
				</a>
				<ul class="dropdown-menu">
				  {foreach item="lnk" from="$iron_version_switch_urls"}
					<li role="presentation"><a role="menuitem" tabindex="-1" href="{$lnk.url/}">{htmlentities}{$lnk.title/}{/htmlentities}</a></li>
				  {/foreach}
				</ul>
			  </li>
			{/unless}
		</ul>
	  </div><!-- /.navbar-collapse -->
	</nav>
  <div id="main">
  {unless isempty="$page_title"}<h1>{$page_title/}</h1>{/unless}
  {$main/}
  </div>
  <div id="footer">{$footer/}</div>
</div>
</body>
</html>
