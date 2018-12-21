{if isset="$page.region_content"}
			{if isset="$wiki_book_name"}
			  <header class="head">
			  <div id="breadcrumb">
					<span class="ico"><img src="{$theme_path/}images/ico-document.png" width="21" height="21" alt="Documentation"></span>
					<a href="{$site_url/}doc/{$wiki_book_name/}">{$wiki_book_name/}</a>
					{if isset="$wiki_link_title"}:: {$wiki_link_title/}{/if}
					{if isset="$breadcrumb"}:: {$breadcrumb/}{/if}
			  </div>
			  </header>
			{/if}
			  <div>{$page.region_content/}</div>
{include file="3rd/doc-comments.tpl"/}			  
{/if}
{unless isset="$page.region_content"}
				<header class="head">
				  <div id="breadcrumb">
					  <span class="ico"><img src="{$theme_path/}images/ico-document.png" width="21" height="21" alt="Documentation"></span>Documentation</h1>
				</header>
{/unless}
