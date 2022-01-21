<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- EWF CMS -->
	<link rel="stylesheet" href="{$theme_path/}css/style.css">
{if isset="$head"}{$head/}{/if}
{if isset="$styles"}{$styles/}{/if}
{if isset="$scripts"}{$scripts/}{/if}
{if isset="$head_lines"}{$head_lines/}{/if}	
	<title>{$head_title/}</title>
</head>
<body>
  <!-- Page Top -->
  {if isset="$region_top"}
    {$region_top/}
  {/if}
  <!-- Body -->
  <div>
    <!-- Page Header -->
    <div id="header">
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
        <div id='main' {unless isempty="$page.page_class_css"}class="{$page.page_class_css/}"{/unless}>
          <!-- Highlighted Section -->
          {unless isempty="$page.region_highlighted"}
		  <div id="highlighted">{$page.region_highlighted/}</div>
		  {/unless}
          <!-- Help Section -->
          {unless isempty="$page.region_help"}
		  <div id="help">{$page.region_help/}</div>
		  {/unless}

          <!-- Main Content Section -->
		  {unless isempty="$page.page_title"}<h1 class="page-title">{$page.page_title/}</h1>{/unless}
          {$page.region_content/}   
          </div>
      </div>
    </div>

  <!--Page footer -->
  {$page.region_footer/}

  <!-- Page Bottom -->
  {$page.region_bottom/}
</body>
</html>
