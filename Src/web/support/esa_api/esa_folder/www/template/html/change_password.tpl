<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
     {include file="optional_styling_css.tpl"/}   
  </head>

  <body>
     {include file="navbar.tpl"/}  

    <div class="container" itemscope itemtype="{$host/}/profile/esa_api.xml">
        <div class="main">
          <form class="form-horizontal well" id="changePassword" method='POST' action='{$host/}/password' itemprop="update" >
            <legend>Change Password</legend>
            <p>Use this form to update your password:<p>
            <div class="form-group">
                <label class="control-label col-xs-2" for="inputPassword" itemprop="password">Password:</label>
                <div class="col-xs-9">
                    <input type="password" class="form-control" id="inputPassword" name="password" placeholder="Password">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-2" for="confirmPassword" itemprop="check_password">Confirm Password:</label>
                <div class="col-xs-9">
                    <input type="password" class="form-control" id="confirmPassword" name="check_password" placeholder="Confirm Password">
                </div>
            </div>
            <div class="form-group">
                <div class="col-xs-offset-2 col-xs-9">
                    <input type="submit" class="btn btn-primary" value="Submit">
                    <input type="reset" class="btn btn-default" value="Reset">
                </div>
            </div>
           {if isset="$has_error"} 
             <div class="control-group">
               <label class="col-sm-offset-1  label label-danger">Errors</label>
                 {foreach from="$form.errors" item="item"}
                   <br>  <span class="col-sm-offset-1 label label-warning">{$item/} </span> 
                 {/foreach}
               </div>    
          {/if}
          {if isset="$password_changed"} 
             <div class="control-group">
                  Your password was successfully changed, please Loggin again.
             </div>    
          {/if}
          </form>         
       </div>
      </div> 

       <!-- Placed at the end of the document so the pages load faster -->
   
    
    {include file="optional_enhancement_js.tpl"/} 
  </body>
</html>