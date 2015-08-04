<div id="breadcrumb">
	<span class="ico"><img src="{$site_url/}theme/images/ico-document.png" width="21" height="21" alt="Image Description"></span>
			  		<a href="{$site_url/}resourses/videos">Videos Page</a>
</div>

<h2>Eiffel <small>Videos:</small></h2> For a complete listing, see <a href="https://www.youtube.com/user/EiffelLanguage/videos" target="_blank">Eiffel Language Youtube channel.</a>
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