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
          <form class="form-horizontal well" id="registerHere" method='POST' action='{$host/}/account' itemprop="update">
            <fieldset>

              <legend>Account Information</legend>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="first_name">First Name</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="input01" name="first_name" rel="popover" data-content="Enter your first" data-original-title="First Name" value="{$account.first_name/}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="last_name">Last Name</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="input01" name="last_name" rel="popover" data-content="Enter your last name" data-original-title="Last Name" value="{$account.last_name/}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="email">Email</label>
                <div class="col-xs-9">
                  <input type="email" class="input-xlarge" id="input01" name="user_email" rel="popover" data-content="What’s your email address?" data-original-title="Email" value="{$account.email/}" disabled>
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="country">Country</label>
                   <div class="col-xs-9">
                     <select  id="input01"  data-style="btn-primary" name="country" >
                    {foreach from="$account.countries" item="item"}
                      {if condition="$item.id ~ $account.selected_country"} 
                        <option value="{$item.id/}" selected>{$item.name/}</option>
                      {/if}
                      {unless condition="$item.id ~ $account.selected_country"}
                        <option value="{$item.id/}">{$item.name/}</option>
                      {/unless}
                    {/foreach} 
                    </select>
                   </div>  
              </div>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="region">Region</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="input01" name="user_region" rel="popover" data-content="Enter your region" data-original-title="Region" value="{$account.region/}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="position">Position</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="input01" name="user_position" rel="popover" data-content="Enter your position" data-original-title="Position" value="{$account.position/}">
                </div>
              </div>

               <div class="form-group">
                <label class="control-label col-xs-2" itemprop="city">City</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="input01" name="user_city" rel="popover" data-content="Enter your city" data-original-title="city" value="{$account.city/}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="address">Address</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="input01" name="user_address" rel="popover" data-content="Enter your address" data-original-title="Address" value="{$account.address/}">
                </div>
              </div>


              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="postal_code">Postal Code</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="input01" name="user_postal_code" rel="popover" data-content="Enter your postal code" data-original-title="Postal Code" value="{$account.postal_code/}">
                </div>
              </div>

               <div class="form-group">
                <label class="control-label col-xs-2" itemprop="telephone">Telephone</label>
                <div class="col-xs-9">
                  <input type="tel" class="input-xlarge" id="input01" name="user_phone" rel="popover" data-content="Enter your phone" data-original-title="phone" value="{$account.phone/}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="fax">Fax</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="input01" name="user_fax" rel="popover" data-content="Enter your fax" data-original-title="Address" value="{$account.fax/}">
                </div>
              </div>

            
              <input type="hidden" class="input-xlarge" id="input01" name="user_name" rel="popover"  value="{$account.username/}">
              
               
              <div class="form-group">
                 <div class="col-xs-offset-2 col-xs-9">
                  <button type="submit" class="btn btn-info" id="input01">Update My Account</button>
                  <input type="reset" class="btn btn-default" value="Reset">
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
    <!-- Placed at the end of the document so the pages load faster -->


    
    {include file="optional_enhancement_js.tpl"/} 
  </body>
</html>