<!DOCTYPE html>
<html lang="en">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<link rel="stylesheet" href="{$theme_path/}css/style.css"/>
	<link rel="stylesheet" href="//fonts.googleapis.com/css2?family=Roboto:wght@300&display=swap" type="text/css" media="all"> 
{if isset="$head"}{$head/}{/if}
{if isset="$styles"}{$styles/}{/if}
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 
	<script src="{$theme_path/}js/jquery.timeago.js"></script>
	<script src="{$theme_path/}js/index.js"></script>
{if isset="$scripts"}{$scripts/}{/if}
{if isset="$head_lines"}{$head_lines/}{/if}
	<title>{$head_title/}</title>
</head>
<body>
  <!-- Page Top -->
  {if isset="$region_top"}
    {$region_top/}
  {/if}
  <!-- Page Header -->
  <div id="header">
    <a id="logo" href="{$site_url/}" title="{$site_title/}">
    <img src="{$theme_path/}images/logo.png" alt="{$site_name/}"/>
    </a>
    {if isset="$page.primary_nav"}
        {$page.primary_nav/}
    {/if}
  </div> 
  {if isset="$page.regions.search"}
  <!-- Page search -->
  <div class="search">{$page.regions.search/}</div>
  {/if}
  <!-- General Page Content -->
  <div id='content'>
  	<!-- Left Sidebar sidebar_first -->
  	{unless isempty="$page.region_sidebar_first"}
  	<div id="sidebar_first" class="sidebar">{$page.region_sidebar_first/}</div>
  	{/unless}
  	<!-- Right Sidebar sidebar_second-->
  	{unless isempty="$page.region_sidebar_second"}
  	<div id="sidebar_second" class="sidebar">{$page.region_sidebar_second/}</div>
  	{/unless}

      <!-- Highlighted, Help, Content -->      
      <div id='main'>
        <!-- Highlighted Section -->
        {unless isempty="$page.region_highlighted"}
  	  <div id="highlighted">{$page.region_highlighted/}</div>
  	  {/unless}
        <!-- Help Section -->
        {unless isempty="$page.region_help"}
  	  <div id="help">{$page.region_help/}</div>
  	  {/unless}

        <!-- Main Content Section -->
  	  {unless isempty="$page_title"}<h1 class="page-title">{$page_title/}</h1>{/unless}
        {$page.region_content/}   
      </div>
  </div>

  <div id="footer">
  <!--Page footer -->
  {$page.region_footer/}
  <!-- Page Bottom -->
  {$page.region_bottom/}
  </div>

</body>
</html>
