<div class="codeboard-demo">
<div class="btn-holder"><a class="btn-play" href="{$site_url/}codeboard">Try Eiffel online</a></div>
<div class="codeboard-player">
<link rel="stylesheet" property="stylesheet" href="{$site_url/}/module/codeboard/files/css/codeboard_static_demo.css"/>
<div class="slider-wrapper">
  <div class="slider" data-slider-delay="7000">
{foreach  from="$snippets" item="snippet"}
    <input type="radio" name="slider" class="trigger" id="slide{$snippet.id/}" {if isempty="$snippet_curr"}checked="checked"{/if}{assign name="snippet_curr" value="{$snippet.id/}"/} />
    <div class="slide">
	  <div class="slide-item">
        <pre class="prettyprint {unless isempty="$snippet.lang"}lang-{$snippet.lang/}{/unless}">{$snippet.text/}</pre>
	{unless isempty="$snippet.caption"}		<p class="slide-caption">
		{unless isempty="$snippet.link"}<a href="{$snippet.link/}">{/unless}
		{htmlentities}{$snippet.caption/}{/htmlentities}
		{unless isempty="$snippet.link"}</a>{/unless}
		</p>
	{/unless}
	{if isempty="$snippet.caption"}
		{unless isempty="$snippet.link"}<p class="slide-caption"><a href="{$snippet.link/}">{$snippet.link/}</a></p>{/unless}
	{/if}
	  </div>
    </div><!-- .slide -->
{/foreach}	
  </div>
  <ul class="slider-nav">
  {foreach  from="$snippets" item="snippet"}
    <li class="slider-nav__item"><label class="slider-nav__label" for="slide{$snippet.id/}">{$snippet.id/}</label></li>
  {/foreach}
  </ul><!-- .slider-nav -->
</div><!-- .slider-wrapper -->

<script type="text/javascript" src="{$site_url/}/module/codeboard/files/codeboard_static_demo.js"></script>
</div><!-- codeboard-player -->
</div>
