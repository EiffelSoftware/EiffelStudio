<li class="list-group-item">
<a href="/repository/{$package.version.value/}/package/{$package.id/}">
<h4>{$package.human_identifier/}
{if condition="$package.was_downloaded" }<span class="badge pull-right">{$package.download_count/}</span>{/if}
</h4>
</a>
{unless isempty="$package.description" }
<p class="list-group-item-text">{$package.description/}</p>
{/unless}
<p class="text-muted text-right">
  <span>{$package.text_last_modified/}</span>
  <span class="packagetooltip text-right" data-toggle="tooltip" data-placement="right" data-delay="{{show:1000, hide:100}}" title data-original-title="id={$package.id/}"><span class="glyphicon glyphicon-info-sign"></span></span>
</p>
</li>
