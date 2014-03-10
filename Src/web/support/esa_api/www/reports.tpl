<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">
    {include file="optional_styling_css.tpl"/}  

  </head>

  <body>

    {include file="navbar.tpl"/}  
 
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li class="active"><a href="{$host/}/reports">Reports</a></li>
            {if isset="$user"}
                   <li><a href="{$host/}/user_reports/{$user/}">My Reports</a></li>
            {/if}
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
          {include file="dashboard.tpl"/}

          {include file="guest_reports.tpl"/}     
          
        </div>
      </div>
    </div>

    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/} 
  </body>
</html>
