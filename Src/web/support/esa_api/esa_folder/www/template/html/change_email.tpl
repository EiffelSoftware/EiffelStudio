<!DOCTYPE html>
<html lang="en">

  {include file="head.tpl"/}     

  <body>
     {include file="navbar.tpl"/}  

    <div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
       <div class="col-lg-12">    
          <form class="form-inline well" id="changeEmail" method='POST' action='{$host/}/email' itemprop="create" >
            <legend><h1>Change Email</h1></legend>
            <p>Use this form to update your email:</p>
           
            <div class="row">
               <div class="col-md-12">
                    <label class="form-label" for="inputEmail" itemprop="email">Email</label>
                     <input type="email" class="form-control form-entry" id="inputEmail" name="email" placeholder="Email">
              </div>
            </div>   

            <div class="row">
              <div class="col-md-12">
                    <label class="form-label" for="confirmEmail" itemprop="check_password">Confirm Email</label>
                    <input type="email" class="form-control form-entry" id="confirmEmail" name="check_email" placeholder="Confirm Email">
              </div>
            </div>  

          <div class="row">
               <div class="col-md-4">
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
