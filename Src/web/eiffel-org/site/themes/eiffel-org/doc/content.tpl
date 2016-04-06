{if isset="$page.region_content"}
			{if isset="$wiki_book_name"}
			  <header class="head">
			  <div id="breadcrumb">
					<span class="ico"><img src="{$site_url/}theme/images/ico-document.png" width="21" height="21" alt="Documentation"></span>
					<a href="{$site_url/}doc/{$wiki_book_name/}">{$wiki_book_name/}</a>
					{if isset="$wiki_page_name"}:: {$wiki_page_name/}{/if}
			  </div>
			  </header>
			{/if}
			  <div class="wikipage">{$page.region_content/}
				{if isset="$wiki_uuid"}<div class="uuid">{$wiki_uuid/}</div>{/if}
			  </div>
{include file="doc/disqus.tpl"/}			  
{/if}
{unless isset="$page.region_content"}
				<header class="head">
				  <div id="breadcrumb">
					  <span class="ico"><img src="{$site_url/}theme/images/ico-document.png" width="21" height="21" alt="Documentation"></span>Documentation</h1>
				</header>
{/unless}
