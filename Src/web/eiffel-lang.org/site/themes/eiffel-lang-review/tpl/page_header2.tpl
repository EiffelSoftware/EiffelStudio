 {if isset="$default_nav"}
  <div class="navbar navbar-default" role="navigation">
    <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
        <span class="sr-only">Toggle navigation</span>
      </button>
      <a class="navbar-brand" href="${site_url/}" itemprop="home" rel="home">{$page_title/}</a>
    </div>
    
    <div class="navbar-collapse collapse">      
  {/if}    

      {if isset="$primary_nav"}
            {$primary_nav/}
      {/if}

      {if isset="$secondary_nav"}
          {$secondary_nav/}
      {/if}  
 
{if isset="$default_nav"}
  
     </div>

  </div>
</div>
{/if}  