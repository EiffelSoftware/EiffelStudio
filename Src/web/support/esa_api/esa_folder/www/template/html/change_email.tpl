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
          <form class="form-horizontal well" id="changeEmail" method='POST' action='{$host/}/email' itemprop="create" >
            <legend>Change Email</legend>
            <p>Use this form to update your email:</p>
            <div class="form-group">
                <label class="control-label col-xs-2" for="inputEmail" itemprop="email">Email:</label>
                <div class="col-xs-9">
                    <input type="email" class="form-control" id="inputEmail" name="email" placeholder="Email">
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-xs-2" for="confirmEmail" itemprop="check_password">Confirm Email:</label>
                <div class="col-xs-9">
                    <input type="email" class="form-control" id="confirmEmail" name="check_email" placeholder="Confirm Email">
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
          {if isset="$email_changed"} 
             <div class="control-group">
                  Your new email was successfully added, please confirm it to make it your default account email.
             </div>    
          {/if}
          </form>         
       </div>
      </div> 

       <!-- Placed at the end of the document so the pages load faster -->
   
    
    {include file="optional_enhancement_js.tpl"/} 
  </body>
</html>