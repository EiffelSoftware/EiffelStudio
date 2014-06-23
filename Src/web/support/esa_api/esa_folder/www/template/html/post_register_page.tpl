<!DOCTYPE html>
<html lang="en">

  {include file="head.tpl"/}     

  <body>
     {include file="navbar.tpl"/}  

    <div class="container" itemscope itemtype="{$host/}/profile/esa_api.xml">
                <div class="hero-unit center">
                  <h1>Eiffel Support Activation <small>
                  <br />
                  <p > An e-mail with an activation code was sent to your account.<br/>
                   Please check your email and use the provided link to <a href="{$host/}/activation" itemprop="activation" rel="activation">activate</a> your account.</p>
                </div>
    </div>
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>
