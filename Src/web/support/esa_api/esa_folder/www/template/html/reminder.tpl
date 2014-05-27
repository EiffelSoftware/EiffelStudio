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

    <div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
      <div class="row">
         <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li><a href="{$host/}/reports" itemprop="all" rel="all">Reports</a></li>
           </ul> 
         </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
          <form class="form-horizontal" id="reminder" method='POST' action='{$host/}/reminder' itemprop="create">
            <fieldset>

              <legend>Username/ Password Reminder</legend>
              <p>If you've forgotten your Username or Password, simply fill in your e-mail address below, then answer your security question. We will assign you a new random password and remind you of your Username via email. Once you log back in you may choose your own password by editing your member profile. </p>

              <div class="control-group">
                <label class="control-label" itemprop="email">Email</label>
                <div class="controls">
                  <input type="text" class="input-xlarge" id="email" name="email" rel="popover" data-content="Enter your email" data-original-title="Email" value="{$form.email/}">
                </div>
              </div>  
            
              <div class="control-group">
                <label class="control-label"></label>
                <div class="controls">
                  <button type="submit" class="btn btn-success" >Check e-mail</button>
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
    </div>
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>