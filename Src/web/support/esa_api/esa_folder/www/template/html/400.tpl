<!DOCTYPE html>
<html lang="en">
  
  {include file="head.tpl"/}     

  <body>

  <div class="container">
    <div class="row">
      <div class="span12">
        <div class="hero-unit center" itemscope itemtype="{$host/}/profile/esa_api.xml">
            <h1>Bad Request <small><font face="Tahoma" color="red">Error 400</font></small></h1>
            <br />
            <p>The page you requested could not be server because it's not well formed, either contact your webmaster or try again. Use your browsers <b>Back</b> button to navigate to the page you have prevously come from</p>
            <p><b>Or you could just press this neat little button:</b></p>
            <a href="{$host/}" class="btn btn-large btn-primary" itemprop="home" rel="home"><i class="glyphicon glyphicon-home"></i> Take Me Home</a>
          </div>
          <br/>
    
    </div>
  </div>
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>

