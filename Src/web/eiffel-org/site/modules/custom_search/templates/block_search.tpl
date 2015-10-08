<section>
  <header>
    <h2>Results for <kbd>{$result.current_page.search_terms/}</kbd></h2>
  </header>
  
  <!-- list of results -->
  <ol>
  
    <!-- Item result -->
    {foreach from="$result.items" item="item"}
    <li>
      <article>
        <header>
          <h3>
            <cite>
              <a href="{$item.link/}">{$item.title/}</a>
            </cite>
          </h3>
        </header>
        <blockquote cite="{$item.link/}">
          <p>{$item.snippet_2/}</p>
          <footer>
            <p><abbr title="Uniform Resource Locator">Source</abbr> <a href="{$item.link/}">{$item.display_link/}</a></p>
          </footer>
        </blockquote>
      </article>
    </li>
    {/foreach} 

    
  </ol>  
  <ul class="cms-links">
      {if isset="$result.previous_page"}
        <li><a href="{$site_url/}gcse/?q={$result.previous_page.search_terms/}&amp;start={$result.previous_page.start_index/}&amp;num={$result.previous_page.count/}">Previous</a></li>
      {/if}
      {if isset="$result.next_page"}
        <li><a href="{$site_url/}gcse/?q={$result.next_page.search_terms/}&amp;start={$result.next_page.start_index/}&amp;num={$result.next_page.count/}">Next</a></li>
      {/if}
  </ul>
</section>