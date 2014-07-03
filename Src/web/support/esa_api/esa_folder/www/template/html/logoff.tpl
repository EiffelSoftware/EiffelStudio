<!DOCTYPE html>
<html lang="en">
 
  {include file="head.tpl"/}     

  <body>

  <div class="container">
    <div class="row">
      <div class="span12">
        <div class="hero-unit center" itemscope itemtype="{$host/}/profile/esa_api.xml">
            <h1>You have successfully Logged out</h1>
            <br />
            <p>You may want to return</p>
            <p><b>press this neat little button:</b></p>
            <a href="{$host/}" class="btn btn-large btn-primary" itemprop="home" rel="home"><i class="glyphicon glyphicon-home"></i> Take Me Home</a>
          </div>
          <br />
    
    </div>
  </div>
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>

