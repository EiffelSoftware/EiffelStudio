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
            <legend>Problem Report Submission Confirmation</legend>
            <div class="row">
              <div class="col-md-2">
                <label class="control-label" for="input01">Product/Category:</label>
                    {$categories/} 
              </div>
              <div class="col-md-2">
               <label class="control-label" for="input01">Severity:</label>
                {$severities/}
              </div>
              <div class="col-md-2">
                <label class="control-label" for="input01">Priority:</label>
                {$priorities/}
              </div>
              <div class="col-md-2">
                <label class="control-label" for="input01">Class</label>
                {$classes/}
              </div>
              <div class="col-md-2">
               <label class="control-label" for="input01">Confidential</label>
                  {if condition="$confidential"} 
                        Yes
                  {/if}
                  {unless condition="confidential"}
                        No
                  {/unless}
                 </select>
              </div>
            </div>    
            <div class="control-group">
              <label class="control-label" for="input" has-success has-feedback>Release</label>
              <div class="controls">
                      {$release/}
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="input"  has-success has-feedback>Synopsis</label>
              <div class="controls">
                    {$synopsis/}
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="textarea">Environment</label>
              <div class="controls">
                {$environment/}
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="textarea">Attachments</label>
              <div class="controls">
                {foreach from="attachments" item="item"}
                    {$item.name/} </br>
                {/foreach}
              </div>
            </div>
 
            <div class="control-group">
              <label class="control-label" for="textarea">Description</label>
              <div class="controls">
                {$description/}
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="textarea">To Reproduce</label>
              <div class="controls">
                {$to_reproduce/}
              </div>
            </div>
           <hr>
            <div class="form-actions">
              <a class="btn btn-xs btn-primary" href="{$host/}/report_confirm/{$id/}">Confirm</a>
              <a class="btn btn-xs btn-primary" href="{$host/}/report_form/{$id/}">Edit</a> 
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
