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

  <div class="container">
    <div class="row">
      <div class="span12" itemscope itemtype="{$host/}/profile/esa_api.xml">
            <h1>Internal Server Error <small><font face="Tahoma" color="red">Error 500</font></small></h1>
            <br />
            <p>The page you requested could not be server because the server is down, either contact your webmaster or try again. Use your browsers <b>Back</b> button to navigate to the page you have prevously come from</p>
            <p><b>Or you could just press this neat little button:</b></p>
            <a href="{$host/}" class="btn btn-large btn-primary" itemprop="home" rel="home"><i class="glyphicon glyphicon-home"></i> Take Me Home</a>
        </div>
          <br />
    
    </div>
    </div>
   </div> 
    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>

