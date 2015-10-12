{if isset="$page.region_content"}{$page.region_content/}{/if}
<section class="rss-block">
	<ul>
{unless isempty="$page.region_feed_news"}<li><h2>News</h2>{$page.region_feed_news/}</li>{/unless}
{unless isempty="$page.region_feed_forum"}<li><h2>Forum</h2>{$page.region_feed_forum/}</li>{/unless}
{unless isempty="$page.region_feed_updates"}<li><h2>Recent Updates</h2>{$page.region_feed_updates/}</li>{/unless}
	</ul>	
</section>		
