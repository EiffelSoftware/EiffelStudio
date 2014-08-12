					<div class="container">
						<div id="content">
							<div class="holder">
{if isset="$content"}
			  <h1>
			  		{if isset="$wiki_book_name"}{$wiki_book_name/}{/if}
			  		{if isset="$wiki_page_name"}:: {$wiki_page_name/}{/if}</h1>
			  <div class="wikipage">{$content/}</div>
{/if}
							</div>
						</div>
					</div>
