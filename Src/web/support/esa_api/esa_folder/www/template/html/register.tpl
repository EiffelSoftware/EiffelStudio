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
           </ul> 
         </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <form class="form-horizontal" id="registerHere" method='POST' action='{$host/}/register'>
            <fieldset>

              <legend>Registration</legend>

              <div class="control-group">
                <label class="control-label">First Name</label>
                <div class="controls">
                  <input type="text" class="input-xlarge" id="first_name" name="first_name" rel="popover" data-content="Enter your first" data-original-title="First Name" value="{$form.first_name/}">
                </div>
              </div>

              <div class="control-group">
                <label class="control-label">Last Name</label>
                <div class="controls">
                  <input type="text" class="input-xlarge" id="last_name" name="last_name" rel="popover" data-content="Enter your last name" data-original-title="Last Name" value="{$form.last_name/}">
                </div>
              </div>

              <div class="control-group">
                <label class="control-label">Email</label>
                <div class="controls">
                  <input type="text" class="input-xlarge" id="user_email" name="user_email" rel="popover" data-content="What’s your email address?" data-original-title="Email" value="{$form.email/}">
                </div>
              </div>

              <div class="control-group">
                <label class="control-label">User Name</label>
                <div class="controls">
                  <input type="text" class="input-xlarge" id="user_name" name="user_name" rel="popover" data-content="Enter your user_name" data-original-title="User Name" value="{$form.user_name/}">
                </div>
              </div>

              <div class="control-group">
                <label class="control-label">Password</label>
                <div class="controls">
                  <input type="password" class="input-xlarge" id="password" name="password" rel="popover" data-content="Enter your password" data-original-title="Password">
                </div>
              </div>


              <div class="control-group">
                <label class="control-label">Re-type Password</label>
                <div class="controls">
                  <input type="password" class="input-xlarge" id="check_password" name="check_password" rel="popover" data-content="Re-type your password" data-original-title="Re-type Password">
                </div>
              </div>

               <div class="control-group">
                 <label class="control-label" for="input01">Choose a security question</label>
                 <select class="form-control"  data-style="btn-primary" name="question" >
                  {foreach from="$questions" item="item"}
                    {if condition="$item.id = $view.selected_question"} 
                      <option value="{$item.id/}" selected>{$item.question/}</option>
                    {/if}
                    {unless condition="$item.id = $view.selected_question"}
                      <option value="{$item.id/}">{$item.question/}</option>
                    {/unless}
                  {/foreach}  
                </select>
               </div>

              <div class="control-group">
                <label class="control-label">Answer security question</label>
                <div class="controls">
                  <input type="text" class="input-xlarge" id="answer_question" name="answer_question" rel="popover" data-content="Answer security question" data-original-title="Answer question" value="{$form.answer/}">
                </div>
              </div>

              <div class="control-group">
                <label class="control-label"></label>
                <div class="controls">
                  <button type="submit" class="btn btn-success" >Create My Account</button>
                </div>
              </div>

              {if isset="$has_error"} 
                <div class="control-group">
                  <label class="control-label">Errors</label>
                    {foreach from="$form.errors" item="item"}
                        {$item/} <br>
                     {/foreach}
                 </div>    
               {/if}     
              
          </fieldset>
          </form>
        </div>
      </div>
    </div>
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>