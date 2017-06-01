{assign name="empty" value=""/}
{unless condition="$page.region_jumbotron1 ~ $empty"}
<section class="jumbotron">
<div class="container">
	<div class="grid-2">
	<div class="col">{$page.region_jumbotron1/}</div>
	<div class="col">{$page.region_jumbotron2/}</div>
	</div>
</div>
</section>
{/unless}	
