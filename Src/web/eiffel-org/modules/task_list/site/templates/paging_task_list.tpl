	<ul class="cms-links">
		<li><a href="{$site_url/}{$resource_path/}/{$module_name/}?page=1&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$status_query/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}" itemprop="first" rel="first">First</a></li>
		{if isset="$prev"}
			<li><a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$prev/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$status_query/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}" itemprop="previous" rel="previous">Previous</a></li>
		{/if}
		{if isset="$next"}
			<li><a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$next/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$status_query/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}" itemprop="next" rel="next">Next</a></li>
		{/if}
		<li><a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$last/}&amp;size={$size/}&amp;category={$selected_category/}&amp;status={$status_query/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}" itemprop="last" rel="last">Last</a></li>
	</ul>
