<li class="list-group-item">
<a href="/repository/{$package.version.value/}/package/{$package.id/}">
<h4>{$package.human_identifier/}
{if condition="$package.was_downloaded" }<span class="badge pull-right">{$package.download_count/}</span>{/if}
</h4>
</a>
{unless isempty="$package.description" }
<p class="list-group-item-text">{$package.description/}</p>
{/unless}
{unless isempty="$package.tags" }
<p>
{foreach item="tag" from="$package.tags" }<span class="badge"><a href="/repository/{$package.version.value/}/package/?query=tag%3A{$tag/}">{$tag/}</a></span> {/foreach}
</p>
{/unless}
<p class="text-muted text-right">
  <span>{$package.text_last_modified/}</span>
  <span class="packagetooltip text-right" data-toggle="popover" data-placement="right" data-content="id={$package.id/}"><span class="glyphicon glyphicon-info-sign"></span></span>
</p>
</li>
