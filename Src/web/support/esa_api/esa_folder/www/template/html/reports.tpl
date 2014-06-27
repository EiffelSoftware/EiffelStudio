<!DOCTYPE html>
<html lang="en" manifest="{$host/}/images/api.appcache">

   {include file="head.tpl"/}     


  <body>

    {include file="navbar.tpl"/}  
 
    <div class="container" itemscope itemtype="{$host/}/profile/esa_api.xml">
        <div class="main">
          {include file="guest_reports.tpl"/}     
        </div>
    </div>

    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/} 
  </body>
</html>
