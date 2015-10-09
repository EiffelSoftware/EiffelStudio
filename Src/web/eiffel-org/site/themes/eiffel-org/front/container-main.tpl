{if isset="$page.region_content"}{$page.region_content/}{/if}
<section class="rss-block">
	<ul>
{unless isempty="$page.region_feed_eiffel"}<li><h2>What's New</h2>{$page.region_feed_eiffel/}</li>{/unless}
{unless isempty="$page.region_feed_forum"}<li><h2>Forum</h2>{$page.region_feed_forum/}</li>{/unless}
{unless isempty="$page.region_feed_updates"}<li><h2>Recent Updates</h2>{$page.region_feed_updates/}</li>{/unless}

		<!--
		<li>
			<h2>What's New</h2>
			<script type="text/javascript" src="https://feed.informer.com/widgets/A8SKSXEDBU.js"></script>
			<noscript><a href="https://feed.informer.com/widgets/A8SKSXEDBU.html">"What's New"</a>		
			Powered by <a href="https://feed.informer.com/">RSS Feed Informer</a></noscript>
			<a href="{$site_url/}news">See more ...</a>
   		</li>
		<li>
    		<h2>Recent Updates</h2>
    		<script type="text/javascript" src="https://feed.informer.com/widgets/EQWCGOOQEZ.js"></script>
			<noscript><a href="https://feed.informer.com/widgets/EQWCGOOQEZ.html">"Recent Updates"</a>
			Powered by <a href="https://feed.informer.com/">RSS Feed Informer</a></noscript>
			<a href="{$site_url/}updates">See more ...</a>
    	</li>	
		-->
	</ul>	
</section>		
