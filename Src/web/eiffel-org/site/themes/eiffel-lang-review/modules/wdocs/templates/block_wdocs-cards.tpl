{if isset="$root_pages_by_url"}
<ul class="bookcards">
{foreach key="bookurl" item="root_page" from="$root_pages_by_url"}
<li><a href="{$bookurl/}">{$root_page.title/}</a>
	{unless isempty="$root_page.metadata_table.description"}
	<ul>{$root_page.metadata_table.description/}</ul>
	{/unless}
</li>
{/foreach}
</ul>
{/if}
