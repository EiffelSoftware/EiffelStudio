<!DOCTYPE html>
<html lang="en">

  {include file="head.tpl"/}     

  <body>
     {include file="navbar.tpl"/}  

    <div class="container" itemscope itemtype="{$host/}/profile/esa_api.xml">
        <div class="main">
          <form class="form-horizontal well" id="registerHere" method='POST' action='{$host/}/confirm_email' itemprop="update">
            <legend><>Confirm Email</legend>
            {unless isset="$has_error"}
            <div class="form-group">
                <label class="control-label col-xs-2" for="inputToken" itemprop="token">Token:</label>
                <div class="col-xs-9">
                    <input type="text" class="form-control" id="inputToken" name="token" value="{$token/}" placeholder="Token">
                </div>
            </div>
          
            <div class="form-group">
                <label class="control-label col-xs-2" for="confirmEmail" itemprop="email">New Email:</label>
                <div class="col-xs-9">
                    <input type="email" class="form-control" id="confirmEmail" name="email" placeholder="Email" value="{$email/}" disabled>
                </div>
            </div>
              <div class="form-group">
                <div class="col-xs-offset-2 col-xs-9">
                    <input type="submit" class="btn btn-primary" value="Submit">
                    <input type="reset" class="btn btn-default" value="Reset">
                </div>
              </div>
            {/unless}
            {if isset="$has_error"} 
             <div class="control-group">
               <label class="col-sm-offset-1  label label-danger">Errors</label>
                 {foreach from="$form.errors" item="item"}
                   <br>  <span class="col-sm-offset-1 label label-warning">{$item/} </span> 
                 {/foreach}
               </div>    
          {/if}
          </form>         
       </div>
      </div> 

       <!-- Placed at the end of the document so the pages load faster -->
   
    
    {include file="optional_enhancement_js.tpl"/} 
  </body>
</html>