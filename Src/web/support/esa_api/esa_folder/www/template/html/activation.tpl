<!DOCTYPE html>
<html lang="en">

  {include file="master/head.tpl"/}     

  <body>
     {include file="master/navbar.tpl"/}  

    <div class="container" itemscope itemtype="{$host/}/profile/esa_api.xml">
        <div class="main">
          <form class="form-horizontal well" id="registerHere" method='POST' action='{$host/}/activation' itemprop="create">
            <fieldset>

              <legend><h1>Account Activation</h1></legend>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="email">Email</label>
                <div class="col-xs-9">
                   <input type="email" class="input-xlarge" id="email" name="email" rel="popover" data-content="Enter your email" data-original-title="Email" placeholder="Email" value="{$form.email/}">
                </div>
              </div>

              <div class="form-group">
                <label class="control-label col-xs-2" itemprop="token">Token</label>
                <div class="col-xs-9">
                  <input type="text" class="input-xlarge" id="token" name="token" rel="popover" data-content="Enter your roken" data-original-title="Token" placeholder="Token" value="{$form.token/}">
                </div>
              </div>

              <div class="form-group">
                <div class="col-xs-offset-2 col-xs-9">
                  <input type="submit" class="btn btn-primary"Activate>
                  <input type="reset" class="btn btn-default" value="Reset">
                </div>
              </div>

              {if isset="$error"}
                  <div class="control-group">
                    <label class="control-label">Error</label>
                      {$error/}
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