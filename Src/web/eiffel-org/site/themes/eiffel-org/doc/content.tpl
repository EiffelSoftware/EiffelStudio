{if isset="$page.region_content"}
			  <header class="head">
			  <div id="breadcumb">
			  		{if isset="$wiki_book_name"}
						<span class="ico"><img src="/theme/images/ico-documnet.png" width="21" height="21" alt="Image Description"></span>
						<a href="{$site_url/}/book/{$wiki_book_name/}">{$wiki_book_name/}</a>
						{if isset="$wiki_page_name"}:: {$wiki_page_name/}{/if}
					{/if}
			  </div>
			  </header>
			  <div class="wikipage">{$page.region_content/}
				{if isset="$wiki_uuid"}<div class="uuid">{$wiki_uuid/}</div>{/if}
			  </div>
{/if}
{unless isset="$page.region_content"}
				<header class="head">
					<h1><span class="ico"><img src="/theme/images/ico-documnet.png" width="21" height="21" alt="Image Description"></span>Document Name</h1>
					<p>Detailed definitions behind all aspects of the Eiffel Language and Development Environment.</p>
				</header>
{/unless}
