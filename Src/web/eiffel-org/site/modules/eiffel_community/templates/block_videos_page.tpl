<div id="breadcrumb">
	<span class="ico"><img src="{$site_url/}theme/images/ico-document.png" width="21" height="21" alt="Image Description"></span>
			  		<a href="{$site_url/}resourses/videos">Videos Page</a>
</div>

 {if isset="$user"}
 	Add <a href="{$site_url/}node/add/page">new video</a>
 {/if}

<h2>Eiffel <small>Videos</small></h2>

<div>
	<section class="">
		<div>	
			{foreach item="ic" from="$videos"}
				{$ic/}
			{/foreach}
		</div>	
	</section>
</div>

</br>