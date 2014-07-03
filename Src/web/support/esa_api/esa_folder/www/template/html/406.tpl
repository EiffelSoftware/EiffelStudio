<!DOCTYPE html>
<html lang="en">

  {include file="head.tpl"/}     

  <body>

    <div class="container">
      <div class="row">
         <div class="span12" itemscope itemtype="{$host/}/profile/esa_api.xml">
           <h1 class="page-header">Error</h1>
            <p>An appropriate representation of the requested resource <span class="label label-success">{$resource/}</span> using the following <span class="label label-default">Accept</span> header <span class="label label-danger">{$accept/}</span> could not be found.

            Use one of the following media types.</br>  
            <span class="label label-info">text/html</span> 
            <span class="label label-info">application/vnd.collection+json</span> 
            <a href="{$host/}" class="btn btn-large btn-primary" itemprop="home" rel="home"><i class="glyphicon glyphicon-home"></i> Take Me Home</a>
        </div>
      </div>
    </div>

    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/}     
  </body>
</html>
