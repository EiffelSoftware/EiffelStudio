<div class="col-xs-12">
	<ul class="pager">
		<li><a href="{$host/}/closed_reports?page=1&amp;size={$size/}&amporderBy={$orderBy/}&amp;dir={$dir/}&amp;filter={$view.filter/}" itemprop="first" rel="first">First</a></li>
		{if isset="$prev"}
			<li><a href="{$host/}/closed_reports?page={$prev/}&amp;size={$size/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}&amp;filter={$view.filter/}" itemprop="previous" rel="previous">Previous</a></li>
		{/if}
		{if isset="$next"}
			<li><a href="{$host/}/closed_reports?page={$next/}&amp;size={$size/}&amporderBy={$orderBy/}&amp;dir={$dir/}&amp;filter={$view.filter/}" itemprop="next" rel="next">Next</a></li>
		{/if}
		<li><a href="{$host/}/closed_reports?page={$last/}&amp;size={$size/}&amp:orderBy={$orderBy/}&amp;dir={$dir/}&amp;filter={$view.filter/}" itemprop="last" rel="last">Last</a></li>
	</ul>
</div>
