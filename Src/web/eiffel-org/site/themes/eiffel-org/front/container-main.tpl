{if isset="$page.region_content"}{$page.region_content/}{/if}
<section class="rss-block">
	<ul>
{unless isempty="$page.region_feed_news"}<li><h2>News</h2>{$page.region_feed_news/}</li>{/unless}
{unless isempty="$page.region_feed_forum"}<li><h2>Forum</h2>{$page.region_feed_forum/}</li>{/unless}
{unless isempty="$page.region_feed_updates"}<li><h2>Recent Updates</h2>{$page.region_feed_updates/}</li>{/unless}
<li><h2>Facebook</h2>{literal}
<div id="fb-root"></div>
<script>
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.5";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
</script>
<div class="fb-page" data-href="https://www.facebook.com/Eiffel-Programming-Language-235981463124887/" data-tabs="timeline" data-small-header="true" data-adapt-container-width="true" data-hide-cover="true" data-show-facepile="false"></div>
{/literal}
</li>
	</ul>	
</section>		
