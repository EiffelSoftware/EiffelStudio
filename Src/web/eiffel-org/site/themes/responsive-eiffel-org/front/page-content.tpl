{include file="front/jumbotron.tpl"/}
{include file="page-content.tpl"/}

<!-- Feeds ... -->
<section class="rss-block">
<div class="container">
	<ul>
		<li><h2>News</h2><div class="roccms-load" data-href="/feed_aggregation/news?view=embedded&size=7"></div></li>
		<li><h2>Forum</h2><div class="roccms-load" data-href="/feed_aggregation/forum?view=embedded&size=7"></div></li>
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
</div>
</section><!-- Feeds -->

<!-- Built-with-Eiffel -->
{include file="built-with-eiffel.tpl"/}

