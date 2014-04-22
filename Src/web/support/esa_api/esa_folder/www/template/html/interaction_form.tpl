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
          <form class="form-horizontal well" action="{$host/}/report_detail/{$form.report.number/}/interaction_form/{$id/}" id="report" method="POST" enctype="multipart/form-data">
        {/if}
        {unless isset="$id"}
          <form class="form-horizontal well" action="{$host/}/report_detail/{$form.report.number/}/interaction_form" id="report" method="POST" enctype="multipart/form-data">
        {/unless}
          <fieldset>
            <legend>Problem Report Interaction Submission</legend>
            <p> Fill in the description for the new interaction for the <strong>{$form.report.status.synopsis/}</strong> problem report {$form.report.number/}.</p>
            <div class="control-group" has-error>
              <label class="control-label" for="textarea">Description</label>
              <div class="controls">
                <textarea class="form-control input-xlarge" id="description" name="description"  rows="4" placeholder="Give a description of the problem" required form="report">{$form.description/}</textarea>
              </div>
            </div>
             <div class="row">
                <div class="col-md-4">
                  <label class="control-label" for="input01">Change Category from {$form.report.category.synopsis/} to </label>
                  <select class="form-control"  data-style="btn-primary" name="category" form="report">
                  <option value="0">ALL</option>  
                  {foreach from="$categories" item="item"}
                    {if condition="$item.id = $form.category"} 
                      <option value="{$item.id/}" selected>{$item.synopsis/}</option>
                    {/if}
                    {unless condition="$item.id = $form.category"}
                      <option value="{$item.id/}">{$item.synopsis/}</option>
                    {/unless}
                  {/foreach}  
                 </select>
                </div>
            </div>
            <div class="row">
              <div class="col-md-4">
               <label class="control-label" for="input01">Change status from {$form.report.status.synopsis/} to </label>
               <select class="form-control"  data-style="btn-primary" name="status" form="report">
                <option value="0">ALL</option>
                {foreach from="$status" item="item"}
                  {if condition="$item.id = $form.selected_status"} 
                    <option value="{$item.id/}" selected>{$item.synopsis/}</option>
                  {/if}
                  {unless condition="$item.id = $form.selected_status"}
                    <option value="{$item.id/}">{$item.synopsis/}</option>
                  {/unless}
                {/foreach}  
              </select>
              </div>
             </div> 
             <div class="checkbox">
               {if condition="$form.private"}
                 <label>
                    <input type="checkbox" name="private" value="True" checked> Private
                 </label>
               {/if}
               {unless condition="$form.private"}
                 <label>
                    <input type="checkbox" name="private" value="True"> Private
                 </label>
               {/unless} 
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
