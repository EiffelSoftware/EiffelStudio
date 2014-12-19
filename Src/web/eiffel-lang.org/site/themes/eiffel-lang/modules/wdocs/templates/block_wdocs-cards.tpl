{if isset="$root_pages_by_url"}
<div class="bookcards">
<ul>
{foreach key="bookurl" item="root_page" from="$root_pages_by_url"}
<li><a href="{$bookurl/}">
	<h2>{$root_page.title/}</h2>
	{unless isempty="$root_page.metadata_table.description"}
	<img src="/theme/images/small21.png" width="52" height="52" alt="Book">
	<p>
	{$root_page.metadata_table.description/}
	</p>
	{/unless}
	</a>
</li>
{/foreach}
</ul>
</div>
{/if}
