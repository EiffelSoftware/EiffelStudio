<!DOCTYPE html>
<html lang="en">
  
   {include file="master/head.tpl"/}     


  <body>

    {include file="navbar.tpl"/}  
 
    <div class="container-fluid" itemscope itemtype="{$host/}/profile/esa_api.xml">
        <div class="main">

          {include file="guest_reports.tpl"/}     
          
        </div>
      </div>

    <!-- Placed at the end of the document so the pages load faster -->
    {include file="optional_enhancement_js.tpl"/} 
  </body>
</html>
