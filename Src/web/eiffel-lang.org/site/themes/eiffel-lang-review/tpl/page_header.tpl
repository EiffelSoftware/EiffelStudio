  <div class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
      </button>
      <a class="navbar-brand" href="{$site_url/}" itemprop="home" rel="home">{unless isset="$site_name"}Eiffel CMS{/unless}{if isset="$site_name"}{$site_name/}{/if}</a>

    </div>
    
    <div class="navbar-collapse collapse">
     
      {if isset="$primary_nav"}
        <ul class="nav navbar-nav navbar-left">
             {foreach item="item" from="$primary_nav.items"}
                <!-- TODO check if a menu item is active or not -->
                <li class="active"><a href="{$item.location/}">{$item.title/}</a></li>
             {/foreach}
        </ul>
      {/if}

      {if isset="$secondary_nav"}
        <ul class="nav navbar-nav navbar-right">
              {foreach item="item" from="$secondary_nav.items"}
                <!-- TODO check if a menu item is active or not -->
                <li class="active"><a href="{$item.location/}">{$item.title/}</a></li>
             {/foreach}
        </ul>
      {/if}  
    </div>

  </div>
</div>

