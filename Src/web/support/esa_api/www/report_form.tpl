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

        {if isset="$id"}  
          <form class="form-horizontal well" action="{$host/}/report_form/{$id/}" id="report" method="POST" enctype="multipart/form-data">
        {/if}
        {unless isset="$id"}
          <form class="form-horizontal well" action="{$host/}/report_form" id="report" method="POST" enctype="multipart/form-data">
        {/unless}
          <fieldset>
            <legend>Problem Report Submission</legend>
            <div class="row">
              <div class="col-md-2">
                <label class="control-label" for="input01">Product/Category</label>
                <select class="form-control"  data-style="btn-primary" name="category" form="report">
                {foreach from="$categories" item="item"}
                  {if condition="$item.id = $category"} 
                    <option value="{$item.id/}" selected>{$item.synopsis/}</option>
                  {/if}
                  {unless condition="$item.id = $category"}
                    <option value="{$item.id/}">{$item.synopsis/}</option>
                  {/unless}
                {/foreach}  
               </select>
              </div>
              <div class="col-md-2">
               <label class="control-label" for="input01">Severity</label>
               <select class="form-control"  data-style="btn-primary" name="severity" form="report">
                {foreach from="$severities" item="item"}
                  {if condition="$item.id = $severity"} 
                    <option value="{$item.id/}" selected>{$item.synopsis/}</option>
                  {/if}
                  {unless condition="$item.id = $severity"}
                    <option value="{$item.id/}">{$item.synopsis/}</option>
                  {/unless}
                {/foreach}  
              </select>
              </div>
              <div class="col-md-2">
                <label class="control-label" for="input01">Priority</label>
                <select class="form-control"  data-style="btn-primary" name="priority" form="report">
                {foreach from="$priorities" item="item"}
                  {if condition="$item.id = $priority"} 
                    <option value="{$item.id/}" selected>{$item.synopsis/}</option>
                  {/if}
                  {unless condition="$item.id = $priority"}
                    <option value="{$item.id/}">{$item.synopsis/}</option>
                  {/unless}
                {/foreach}  
               </select>
              </div>
              <div class="col-md-2">
                <label class="control-label" for="input01">Class</label>
                <select class="form-control"  data-style="btn-primary" name="class" form="report">
                {foreach from="$classes" item="item"}
                  {if condition="$item.id = $class"} 
                    <option value="{$item.id/}" selected>{$item.synopsis/}</option>
                  {/if}
                  {unless condition="$item.id = $class"}
                    <option value="{$item.id/}">{$item.synopsis/}</option>
                  {/unless}
                {/foreach}  
               </select>
              </div>
              <div class="col-md-2">
               <label class="control-label" for="input01">Confidential</label>
               <select class="form-control"  data-style="btn-primary" name="confidential" form="report">
                  {if condition="$confidential"} 
                    <option value="1" selected>Yes</option>
                    <option value="0">No</option>
                  {/if}
                  {unless condition="confidential"}
                    <option value="0" selected>No</option>
                    <option value="1">Yes</option>
                  {/unless}
                 </select>
              </div>
            </div>    
            <div class="control-group" has-error>
              <label class="control-label" for="input" has-success has-feedback>Release</label>
              <div class="controls">
               <input type="text" id="release" name="release" class="form-control" value="{$release/}" placeholder="14.05" required form="report">
              </div>
            </div>
            <div class="control-group" has-error>
              <label class="control-label" for="input"  has-success has-feedback>Synopsis</label>
              <div class="controls">
               <input type="text" id="synopsis" name="synopsis" class="form-control" value="{$synopsis/}" required>
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="textarea">Environment</label>
              <div class="controls">
                <textarea class="form-control input-xlarge" id="environment"  name="environment" rows="3"  placeholder="Windows XP SP2" required form="report">{$environment/}</textarea>
              </div>
            </div>

           {if isset="$temporary_files"}  
              <div class="control-group">
              <label class="control-label" for="fileInput">Temporary Attachments</label>
              {foreach from="temporary_files" item="item"}
                <div class="controls">
                     <input type="checkbox" name="temporary_files" value="{$item.name/}" checked />{$item.name/} <br />
                </div>
               {/foreach}
             </div> 
            {/if} 
            <div class="control-group">
              <label class="control-label" for="fileInput">Attachments</label>

              <div class="controls">
                <input class="form-control input-file" name="uploaded_file[]" id="fileInput" type="file" multiple>
              </div>
            </div>
            <div class="control-group" has-error>
              <label class="control-label" for="textarea">Description</label>
              <div class="controls">
                <textarea class="form-control input-xlarge" id="description" name="description"  rows="4" placeholder="Give a description of the problem" required form="report">{$description/}</textarea>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="textarea">To Reproduce</label>
              <div class="controls">
                <textarea class="form-control input-xlarge" id="to_reproduce" name="to_reproduce" rows="4" form="report">{$to_reproduce/}</textarea>
              </div>
            </div>
           <hr>
            <div class="form-actions">
              <button type="submit" class="btn btn-primary">Preview</button>
            </div>
          </fieldset>
        </form>
   
        </div>
     </div> 
    </div>   
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>
