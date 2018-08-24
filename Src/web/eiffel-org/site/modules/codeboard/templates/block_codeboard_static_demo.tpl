<div class="holder-play">
<div class="btn-holder"><a class="btn-play" href="{$site_url/}launch_codeboard">Play with Eiffel</a></div>
<div class="slider-wrapper">
  <div class="slider">
{foreach  from="$snippets" item="snippet"}
    <input type="radio" name="slider" class="trigger" id="slide{$snippet.id/}" {if isempty="$snippet_curr"}checked="checked"{/if}{assign name="snippet_curr" value="{$snippet.id/}"/} />
    <div class="slide">
      <figure class="slide-figure">
        <pre class="slide-item prettyprint {unless isempty="$snippet.lang"}lang-{$snippet.lang/}{/unless}">
{$snippet.text/}
        </pre>
{unless isempty="$snippet.description"}		<figcaption class="slide-caption"><p>{$snippet.description/}</p></figcaption>{/unless}
      </figure><!-- .slide-figure -->
    </div><!-- .slide -->
{/foreach}	
  <ul class="slider-nav">
  {foreach  from="$snippets" item="snippet"}
    <li class="slider-nav__item"><label class="slider-nav__label" for="slide{$snippet.id/}">{$snippet.id/}</label></li>
  {/foreach}
  </ul><!-- .slider-nav -->
</div><!-- .slider-wrapper -->
</div>
