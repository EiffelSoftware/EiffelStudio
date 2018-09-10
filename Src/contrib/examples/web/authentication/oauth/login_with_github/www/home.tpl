<!DOCTYPE html>
<html>
    {include file="head.tpl"/}   
    <body>

      <div class="site-content">

      {include file="site_header.tpl"/}    
      
      <main class="main-content">
        <div class="hero">
          <div class="container">
            <img src="images/logo.jpg" alt="EiffelWeb" class="imac">
            <div class="hero-content">
              <span>EiffelWeb Login with Github </span> <br>
            </div>
            {if isset="$user"}
            <a href="{$host/}" class="button">{$user/}</a>
            {/if}
            {unless isset="$user"}
              <a href="{$host/}/login_with_github" class="button">Try it now</a>
            {/unless}
          </div>
        </div> <!-- .hero -->

       </main> <!-- .main-content -->

      <!-- .site-footer -->
     
    </div> <!-- .main-content -->
           
        <!--  <h1>Share your message <h1> {if isset="$user"}<strong>"{$user/}"</strong>{/if}
     
       
          <p class="links">
              {if isset="$user"}
                 <a href="{$host/}/messages">Get started</a> 
              {/if}
            <a href="{$host/}/about">About this site</a>
            {include file="block_login.tpl"/}    
          </p>
        </div> -->
    </body>
    <!-- optional enhancement -->
    {include file="optional_enhancement_js.tpl"/}    
</html>