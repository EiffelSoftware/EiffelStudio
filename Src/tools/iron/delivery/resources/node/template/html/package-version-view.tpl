<div class="panel panel-default">
  <div class="panel-heading">
<a class="panel-title" href="/repository/{$package.version.value/}/package/{$package.id/}">
<h4>{$package.human_identifier/}
{if condition="$package.was_downloaded" }<span class="label label-success pull-right">{$package.download_count/} downloads</span>{/if}
</h4>
</a>
  </div>
  <div class="panel-body">
{unless isempty="$package.description" }<pre class="description">{$package.description/}</pre>{/unless}

<div class="well well-sm">
{unless isempty="$package.tags"}
<p><strong>tags:</strong>
{foreach item="tag" from="$package.tags" }<span class="badge"><a href="/repository/{$package.version.value/}/package/?query=tag%3A{$tag/}">{$tag/}</a></span> {/foreach}</p>
{/unless}

{unless isempty="$package.links" }
<p><strong>Links:</strong>
{foreach key="lnk_name" item="lnk" from="$package.links" }<a href="{$lnk.url/}"><span class="label label-info">{htmlentities}{if isempty="$lnk.title"}{$lnk_name/}{/if}{unless isempty-"$lnk.title"}{$lnk.title/}{/unless}{/htmlentities}</span></a> {/foreach}</p>
{/unless}

{unless isempty="$package.notes" }
<p>{foreach key="note_name" item="note_text" from="$package.notes" }<strong>{htmlentities}{$note_name/}{/htmlentities}</strong>: {htmlentities}{$note_text/}{/htmlentities}<br/>{/foreach}</p>
{/unless}

</div>

</p>

{if condition="$package.has_archive" }
<div class="well archive">
	{if isset="$archive_url"}<a href="{$archive_url/}">Archive
	<span class="glyphicon glyphicon-floppy-save"></span>
	</a>{/if}
	({$package.archive_file_size/} octets -- {$package.archive_last_modified/} {$package.archive_hash/})
</div>
<div class="well">
<strong>Associated URIs</strong>
<ul class="uri-list">
{foreach key="uri" item="url" from="$uris" }<li class="uri">/{$package.version.value/}{$uri/}</li>
{/foreach}
</ul>
</div>
{/if}
<br/>

{if condition="$package.has_archive" }
<p class="howto"><span class="glyphicon glyphicon-cog"></span> iron install {$package.identifier/}</p>
{/if}


<p class="text-muted text-right">
  <span>{$package.text_last_modified/}</span>
  <span class="packagetooltip text-right" data-toggle="tooltip" data-placement="right" data-delay="{{show:1000, hide:100}}" title data-original-title="id={$package.id/}"><span class="glyphicon glyphicon-info-sign"></span></span>
</p>
  </div>
</div>
