<!DOCTYPE html>
<html>
    {include file="head.tpl"/}   
    <body>
     <div class="site-content">

        {include file="site_header.tpl"/}         
     
        <h2>Message</h2>
         <tr>
            <td>{$msg.id/}</td><br/>
            <td>{$msg.message/}</td><br/>
            <td>{$msg.date/}</td><br/>
        </tr>
      </div>
      
    </body>
    <!-- optional enhancement -->
    {include file="optional_enhancement_js.tpl"/}   
</html>