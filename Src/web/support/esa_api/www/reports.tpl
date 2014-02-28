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
            <li><a href="#">Overview</a></li>
            <li class="active"><a href="{$host/}/reports">Reports</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <h1 class="page-header">Dashboard</h1>
          <div class="row placeholders">
            <div class="col-xs-6 col-sm-2 placeholder">
              <img data-src="holder.js/200x200/#FF0000:#000/text:Open" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>25</h4>
              <span class="text-muted">Open Issues</span>
            </div>
            <div class="col-xs-6 col-sm-2 placeholder">
              <img data-src="holder.js/200x200/#FFFF00:#000/text:Analyzed" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>33</h4>
              <span class="text-muted">Analyzed Issues</span>
            </div>
            <div class="col-xs-6 col-sm-2 placeholder">
              <img data-src="holder.js/200x200/#00FF00:#000/text:Closed" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>34</h4>
              <span class="text-muted">Closed Issues</span>
            </div>
            <div class="col-xs-6 col-sm-2 placeholder">
              <img data-src="holder.js/200x200/#0000FF:#000/text:Suspended" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>12</h4>
              <span class="text-muted">Suspended Issues</span>
            </div>
               <div class="col-xs-6 col-sm-2 placeholder">
              <img data-src="holder.js/200x200/gray/text:Won't Fix" class="img-responsive" alt="Generic placeholder thumbnail">
              <h4>11</h4>
              <span class="text-muted">Won't Fix Issues</span>
            </div>
          </div> 

          {include file="guest_reports.tpl"/}     
          
        </div>
      </div>
    </div>

    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/} 
  </body>
</html>
