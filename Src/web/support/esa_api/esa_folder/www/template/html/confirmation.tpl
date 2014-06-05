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
          <div class="hero-unit center">
              <h1>Eiffel Support Confirmation <small>
              <br/>
              <p class="text-success"> Thank you, your account was activated successfully.  You may now Login to your account using the username and password you chose during registration.</p>
          </div>
      </div>
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>
