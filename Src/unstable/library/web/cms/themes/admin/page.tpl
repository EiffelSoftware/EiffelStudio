<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- EWF CMS -->
	<link rel="stylesheet" href="{$theme_path/}css/style.css">
 
	<!-- jQuery dep -->
	<script src="{$theme_path/}js/jquery-1.10.2.min.js"></script>
	<script src="{$theme_path/}js/popup_search.js"></script>

	<!-- CMS JS -->
	<script src="{$theme_path/}js/cms.js"></script>

{if isset="$head"}{$head/}{/if}
{if isset="$styles"}{$styles/}{/if}
{if isset="$scripts"}{$scripts/}{/if}
{if isset="$head_lines"}{$head_lines/}{/if}	

	<!-- bootstrap framework -->
	<!-- Latest compiled and minified CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

	<title>{$head_title/}</title>
</head>
<body>
  <!-- Page Top -->
  {if isset="$region_top"}
    {$region_top/}
  {/if}
  <!-- Body -->
  <div class='container-fluid'>
    
    <!-- Page Header -->
    <div id="header">
      {if isset="$page.primary_nav"}
          {$page.primary_nav/}
      {/if}
    </div> 
	<!-- Page search -->
	<form action="{$site_url/}gcse" class="search-form" id="gcse_search_form">
		<div class="form-group has-feedback">
			<input type="search" class="form-control" name="q" id="gcse_search" placeholder="search" value="{htmlentities}{$cms_search_query/}{/htmlentities}" >
			<span class="glyphicon glyphicon-search form-control-feedback"></span>
		</div>
	</form>
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
		  {if condition="$page.is_front"}
			  {if isset="$page.region_feed_news"}
				<div class="column" style="width: 45%; float: left">{$page.region_feed_news/}</div>
			  {/if}
			  {if isset="$page.region_feed_forum"}
				<div class="column" style="width: 45%; float: left">{$page.region_feed_forum/}</div>
			  {/if}
		  {/if}
          </div>
      </div>
    </div>

  <!--Page footer -->
  {$page.region_footer/}

  <!-- Page Bottom -->
  {$page.region_bottom/}

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

{include file="debug.tpl"/}
</body>
</html>
