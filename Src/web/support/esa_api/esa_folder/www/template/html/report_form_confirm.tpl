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

    <div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
        <div class=" main">

        <div class="form-horizontal well">
          <fieldset>
            <legend>Problem Report Submission Confirmation</legend>
            <div class="row">
              <div class="col-md-2">
                <label class="control-label" for="input01" itemprop="category">Product/Category:</label>
                    {$categories/} 
              </div>
              <div class="col-md-2">
               <label class="control-label" for="input01" itemprop="severity">Severity:</label>
                {$severities/}
              </div>
              <div class="col-md-2">
                <label class="control-label" for="input01" itemprop="priority">Priority:</label>
                {$priorities/}
              </div>
              <div class="col-md-2">
                <label class="control-label" for="input01" itemprop="class">Class</label>
                {$classes/}
              </div>
              <div class="col-md-2">
               <label class="control-label" for="input01" itemprop="confidential">Confidential</label>
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
              <label class="control-label" for="input" has-success has-feedback itemprop="release">Release</label>
              <div class="controls">
                      {$release/}
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="input"  has-success has-feedback itemprop="synopsis">Synopsis</label>
              <div class="controls">
                    {$synopsis/}
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="textarea" itemprop="environment">Environment</label>
              <div class="controls">
                {$environment/}
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="textarea" itemprop="attachments">Attachments</label>
              <div class="controls">
                {foreach from="attachments" item="item"}
                    {$item.name/} </br>
                {/foreach}
              </div>
            </div>
 
            <div class="control-group">
              <label class="control-label" for="textarea" itemprop="description">Description</label>
              <div class="controls">
                {$description/}
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="textarea" itemprop="to-reproduce">To Reproduce</label>
              <div class="controls">
                {$to_reproduce/}
              </div>
            </div>
           <hr>
            <div class="form-actions">
               <form  action="{$host/}/report_confirm" method="POST" itemprop="create">
                    <button type="submit" class="btn btn-xs btn-primary">Confirm</button>
                    <input type="hidden" id="confirm" name="confirm" class="form-control" value="{$id/}">
               </form> 

               <!--form class="form-horizontal well" action="{$host/}/report_form/{$id/}" id="report" method="POST" enctype="multipart/form-data"-->
              <a class="btn btn-xs btn-primary" href="{$host/}/report_form/{$id/}" itemprop="update" rel="update">Edit</a> 
            </div>
          </fieldset>
        </div>
   
        </div>
     </div> 
   <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>
