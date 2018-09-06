<!DOCTYPE html>
<html>
    {include file="head.tpl"/}   
    <body>

      <div class="site-content">

        {include file="site_header.tpl"/}         
        <h2>Messages</h2>
        
        <p>
          Enter your message below:
        </p>
        
        <form action="{$host/}/messages" method="post">
            <input type="text" name="message" value="" required="true"/>
            <input type="submit" />
        </form>

        <div>
          <p>
            Here are some other messages, too:
          </p>
              <table border="1">
                 <thead>
                    <tr>
                      <th>#</th>
                      <th>Message</th>
                      <th>Date</th>
                      <th>Username</th>
                    </tr>
                  </thead>
                  <tbody>
                  {foreach from="$messages" item="item"}
                    <tr>
                      <th><a href="{$host/}/messages/{$item.id/}">{$item.id/}</a></th>
                      <td>{$item.message/}</td>
                      <td>{$item.date/}</td>
                      <td>{$item.user/}</td>
                    </tr>
                    <tr>
                  {/foreach}
           </tbody>
          </table>

 
        </div>

      </div>
    </body>
    <!-- optional enhancement -->
   {include file="optional_enhancement_js.tpl"/}   
</html>