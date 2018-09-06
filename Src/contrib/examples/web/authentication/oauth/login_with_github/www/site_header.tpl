     <header class="site-header">
        <div class="container">
          <a href="{$host/}" class="logo"><img src="{$host/}/images/logo_2.png" alt="EiffelWeb"></a>
          
          <!-- Default snippet for navigation -->
          <div class="main-navigation">
            <button type="button" class="menu-toggle"><i class="fa fa-bars"></i></button>
            <ul class="menu">
              <li class="menu-item current-menu-item"><a href="{$host/}">Home</a></li>
              <li class="menu-item"><a href="{$host/}/about">About</a></li>
              <li class="menu-item"><a href="{$host/}/messages">Messages</a></li>
              {if isset="$user"}
                  <li class="menu-item"><a>User:{$user/}</a></li>
              {/if}
              {include file="block_login.tpl"/}           
            </ul> <!-- .menu -->
          </div> <!-- .main-navigation -->
          
          <div class="mobile-navigation"></div>
        </div> <!-- .container -->
      </header> <!-- .site-header -->
