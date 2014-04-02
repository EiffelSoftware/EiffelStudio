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
            <li><a href="{$host/}/reports">Reports</a></li>
            {if isset="$user"}
                 <li><a href="{$host/}/user_reports/{$user/}">My Reports</a></li>
                 <li class="active"><a href="{$host/}/report_form">Report a Problem</a></li>
            {/if}
           </ul> 
         </div>
        <div class="col-sm-6 col-sm-offset-3 col-md-8 col-md-offset-2 main">

        <div class="form-horizontal well">
          <fieldset>
            <legend>Interaction Submission Confirmation</legend>
            <div class="control-group">
              <label class="control-label" for="textarea">Description</label>
              <div class="controls">
                {$form.description/}
              </div>
            </div>
            <hr>
            <div class="form-actions">
              <a class="btn btn-xs btn-primary" href="{$host/}/report_detail/{$form.report.number/}/interaction_confirm/{$form.id/}">Confirm</a>
              <a class="btn btn-xs btn-primary" href="{$host/}/report_detail/{$form.report.number/}/interaction_form/{$form.id/}">Edit</a> 
            </div>
          </fieldset>
        </div>
   
        </div>
     </div> 
    </div>   
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>
