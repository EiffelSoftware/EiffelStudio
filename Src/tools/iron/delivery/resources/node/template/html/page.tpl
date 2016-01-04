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
  <div id="header">{$big_title/}
  </div>
  <nav class="navbar navbar-default" role="navigation">
		<!-- Brand and toggle get grouped for better mobile display -->
	  <div class="navbar-header">
		<a class="navbar-brand" href="#"><span class="glyphicon glyphicon-refresh"/></a>
	  </div>
		<ul class="nav navbar-nav">
		  {unless isempty="$menu"}
				{foreach item="i_menu" from="$menu"}
				{if isempty="$i_menu.sub_links"}
				<li {if condition="$i_menu.is_active"}class ="active"{/if}>
					<a href="{$i_menu.url/}">{htmlentities}{$i_menu.title/}{/htmlentities}</a>
				</li>
				{/if}
				{unless isempty="$i_menu.sub_links"}
				<li class="{if condition="$i_menu.is_active"}active{/if} dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						{htmlentities}{$i_menu.title/}{/htmlentities}
						<b class="caret"></b>
					</a>
					<ul class="dropdown-menu">
					{foreach item="i_submenu" from="$i_menu.sub_links"}
					<li><a href="{$i_submenu.url/}">{htmlentities}{$i_submenu.title/}{/htmlentities}</a></li>
					{/foreach}
					</ul>
				</li>
				{/unless}
				{/foreach}
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
	    {unless isempty="$iron_version"}
		<ul>
		  <form class="navbar-form navbar-left" role="search" action="{$base_url/}/repository/{$iron_version.value/}/package/">
			  <div class="form-group">
				  {unless isempty="$search_sort_by"}<input type="hidden" name="sort-by" value="{$search_sort_by/}" />{/unless}
				  <input type="text" class="form-control" placeholder="Search" name="query" 
				  	tooltip="Wildcard are supported" 
					{unless isempty="$search_query_text"}value="{$search_query_text/}"{/unless}></input>
			  </div>
			  <button type="submit" class="btn btn-default" 
				  {unless isempty="$search_query_description"}
	 			    data-toggle="popover" data-html="true" data-placement="left" data-content="{nl2br}{htmlentities}{$search_query_description/}{/htmlentities}{/nl2br}" data-trigger="hover"
				  {/unless}
			  ><span class="glyphicon glyphicon-search"></span>
			  </button>
		  </form>
		</ul>
		{/unless}
	</nav>
  <div id="main">
  {unless isempty="$page_title"}<h1>{$page_title/}</h1>{/unless}
  {if condition="$is_front"}{include file="front-page-message.tpl"/}{/if}
  {$main/}
  </div>
  <div id="footer">{$footer/}</div>
</div>
</body>
</html>
