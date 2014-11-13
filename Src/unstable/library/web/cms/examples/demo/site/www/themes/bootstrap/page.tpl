<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>ROC- Layout with defualt Regions</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

    <style type="text/css">
        
    </style>

    <!-- Latest compiled and minified CSS -->

  <!-- Optional theme -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap-theme.min.css">

    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
</head>
<body>
<head>
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
    
    <!-- General Page Content -->
    <div id='content' class='row-fluid'>
		<!-- Left Sidebar sidebar_first -->
		{unless empty="$page.region_sidebar_first"}
		<div style="float: left;">
		{$page.region_sidebar_first/}
		</div>
		{/unless}


        <!-- Highlighted, Help, Content -->      
        <div class='span8 main'>
          <!-- Highlighted Section -->
          {$page.region_highlighted/}
 
          <!-- Help Section -->
          {$page.region_help/}

          <!-- Main Content Section -->
		  {unless empty="$page_title"}<h1 class="page-title">{$page_title/}</h1>{/unless}
          {$page.region_content/}   
        </div>

		<!-- Right Sidebar sidebar_second-->
		{unless empty="$page.region_sidebar_second"}
		<div style="float: right;">
		{$page.region_sidebar_second/}
		</div>
		{/unless}

      </div>
    </div>

  <!--Page footer -->
  {$page.region_footer/}

  <!-- Page Bottom -->
  {$page.region_bottom/}
</body>
<script type="text/javascript">

</script>
</body>
</html>
