<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>
        Support Site for Eiffel  Users
    </title>

     {include file="optional_styling_css.tpl"/}     
  </head>

  <body>
     {include file="navbar.tpl"/}  

    <div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
      <div class="main">
        {if isset="$id"}  
          <form class="form-horizontal well" action="{$host/}/report_form/{$id/}" id="report" method="POST" enctype="multipart/form-data" itemprop="update">
        {/if}
        {unless isset="$id"}
          <form class="form-horizontal well" action="{$host/}/report_form" id="report" method="POST" enctype="multipart/form-data" itemprop="create">
        {/unless}
          <fieldset>
            <legend>Problem Report Submission</legend>
             <p>Use this page to submit a problem report. If you haven't already we strongly suggest that you read the <a href="{$host/}/doc/howto.html" target="_blank" class="info" >instructions for submitting problem reports.</a></p> 
            <div class="row">
              <div class="col-md-2" itemprop="category">
                <label class="control-label" for="input01" data-original-title="The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.">Product/Category</label>
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
              <div class="col-md-2" itemprop="severity">
               <label class="control-label blue-tooltip" for="input01" data-original-title="<p>The severity of the problem. Accepted values include:</p>
                <UL>
                  <LI><B>Critical</B>: The product, component or concept is completely non operational. No workaround is known.</LI>
                  <LI><B>Serious</B>: The product, component or concept is not working properly. Problems that would otherwise be considered critical are rated serious when a workaround is known.</LI>
                  <LI><B>Non-critical</B>: The product, component or concept is working in general, but lacks features, has irritating behavior, does something wrong, or doesn't match its documentation.</LI>
                </UL>
 ">Severity</label>
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
              <div class="col-md-2" itemprop="priority">
                <label class="control-label" for="input01" data-original-title="<p>How soon the solution is required. Accepted values include:</p>
            <UL>
            <LI><B>High</B>: A solution is needed as soon as possible.</LI>
            <LI><B>Medium</B>: The problem should be solved in the next release.</LI>
            <LI><B>Low</B>: The problem should be solved in a future release.</LI>
            </UL>">Priority</label>
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
              <div class="col-md-2" itemprop="class">
                <label class="control-label" for="input01" data-original-title="<p>The class of a problem can be one of the following:</p>
        <UL>
        <LI><B>Bug</B>: A general product problem.</LI>
        <LI><B>Documentation</B>: A problem with documentation.</LI>
        <LI><B>Change Request</B>: A request for a change in behavior, etc.</LI>
        <LI><B>Support</B>: A support problem or question.</LI>
        <LI><B>Installation</B>: A problem with installing the product.</LI>
        </UL>
    ">Class</label>
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
              <div class="col-md-2" itemprop="confidential">
               <label class="control-label" for="input01" data-original-title="<p>Is the report considers confidential? If not, the material provided with the bug report can be published. For example, sample code can be used when helping other customers.</p>">Confidential</label>
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
              <label class="control-label" for="input" has-success has-feedback itemprop="release" data-original-title="<p>Release or version number of the Eiffel product. Please be as specific as possible. For example, 5.6.0919 is better than 5.6.</p>">Release</label>
              <div class="controls">
               <input type="text" id="release" name="release" class="form-control" value="{$release/}" placeholder="14.05" required form="report">
              </div>
            </div>
            <div class="control-group" has-error>
              <label class="control-label" for="input"  has-success has-feedback itemprop="synopsis" data-original-title="<p>One-line summary of the problem. This information will be used as the subject of the problem and it should be short, but still descriptive enough to be different from other problem report subjects.</p>">Synopsis</label>
              <div class="controls">
               <input type="text" id="synopsis" name="synopsis" class="form-control" value="{$synopsis/}" required>
              </div>
            </div>

            <div class="control-group">
              <label class="control-label" for="textarea" itemprop="environment" data-original-title="<p>Description of the environment where the problem occured: machine architecture, operating system, host and target types, libraries, pathnames, etc. On Unix, in addition to other information, execute the command uname -a and copy the result here.</p>
   ">Environment</label>
              <div class="controls">
                <textarea class="form-control input-xlarge" id="environment"  name="environment" rows="3"  placeholder="Windows 8.1" required form="report">{$environment/}</textarea>
              </div>
            </div>

           {if isset="$temporary_files"}  
              <div class="control-group">
              <label class="control-label" for="fileInput" itemprop="attachments">Temporary Attachments</label>
              {foreach from="temporary_files" item="item"}
                <div class="controls">
                     <input type="checkbox" name="temporary_files" value="{$item.name/}" checked />{$item.name/} <br />
                </div>
               {/foreach}
             </div> 
            {/if} 
            <div class="control-group">
              <label class="control-label" for="fileInput" itemprop="attachment" data-original-title="<p>List of files that will be stored together with the description of the problem</p>">Attachments</label>

              <div class="controls">
                <input class="form-control input-file" name="uploaded_file[]" id="fileInput" type="file" multiple>
              </div>
            </div>
            <div class="control-group" has-error>
              <label class="control-label" for="textarea" itemprop="description" data-original-title="<p>Precise description of the problem.</p>">Description</label>
              <div class="controls">
                <textarea class="form-control input-xlarge" id="description" name="description"  rows="4" placeholder="Give a description of the problem" required form="report">{$description/}</textarea>
              </div>
            </div>
            <div class="control-group">
              <label class="control-label" for="textarea" itemprop="to_reproduce" data-original-title="  <p>Example code, input, or activities to reproduce the problem. Eiffel Software uses the example code both to reproduce the problem and to test whether the problem is fixed. Include all precondition, inputs, outputs, conditions after the problem, and symptoms. Any additional important information should be included. Include all the details that would be necessary for someone else to recreate the problem reported, however obvious. Sometimes seemingly arbitrary or obvious information can point the way toward a solution.</p>">To Reproduce</label>
              <div class="controls">
                <textarea class="form-control input-xlarge" id="to_reproduce" name="to_reproduce" rows="4" form="report">{$to_reproduce/}</textarea>
              </div>
            </div>
           <hr>
            <div class="form-actions">
              <button type="submit" class="btn btn-primary">Preview</button>
              <input type="reset" class="btn btn-default" value="Reset"></p>
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
