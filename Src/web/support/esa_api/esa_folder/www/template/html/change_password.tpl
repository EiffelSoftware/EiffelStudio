<!DOCTYPE html>
<html lang="en">

  {include file="head.tpl"/}     

  <body>
     {include file="navbar.tpl"/}  

    <div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
       <div class="col-lg-12">    
            <form class="form-inline well" id="changePassword" method='POST' action='{$host/}/password' itemprop="update" >
            <legend><h1>Change Password</h1></legend>
            <p>Use this form to update your password:<p>
            
            <div class="row">
               <div class="col-md-12">
                <div class="row">
                  <div class="col-md-4">  
                  <label class="control-label-api" for="inputPassword" itemprop="password">Password</label>
                  <input type="password" class="form-control" id="inputPassword" name="password" placeholder="Password">
                </div>
              </div>
             </div>
            </div>

            <div class="row">
               <div class="col-md-12">
                <div class="row">
                  <div class="col-md-4">  
                    <label class="control-label-api" for="confirmPassword" itemprop="check_password">Confirm Password</label>
                   <input type="password" class="form-control" id="confirmPassword" name="check_password" placeholder="Confirm Password">
                  </div>
                </div>
               </div>
            </div>

            </br>  
            <div class="row">
               <div class="col-md-12">
                <div class="row">
                  <div class="col-md-4">  
                    <input type="submit" class="btn btn-primary" value="Submit">
                    <input type="reset" class="btn btn-default" value="Reset">
                </div>
            </div>
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