						<div id="content" class="documentation">
							<div class="holder">
{if isset="$page.region_content"}
			  <div id="breadcrumb">
			  		<span class="ico"><img src="/theme/images/ico-documnet.png" width="21" height="21" alt="Image Description"></span>
			  		{if isset="$wiki_book_name"}<a href="{$site_url/}/book/{$wiki_book_name/}">{$wiki_book_name/}</a>{/if}
			  		{if isset="$wiki_page_name"}:: {$wiki_page_name/}{/if}
			  </div>
			  <div class="wikipage">{$page.region_content/}</div>
{/if}
{unless isset="$page.region_content"}
								<header class="head">
									<h1><span class="ico"><img src="/theme/images/ico-documnet.png" width="21" height="21" alt="Image Description"></span>Document Name</h1>
									<p>Detailed definitions behind all aspects of the Eiffel Language and Development Environment.</p>
								</header>
{/unless}
							</div>
						</div>
