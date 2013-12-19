<div class="panel panel-default">
  <div class="panel-heading">
<a class="panel-title" href="/repository/{$package.version.value/}/package/{$package.id/}">
<h4>Package {$package.human_identifier/}
{if condition="$package.was_downloaded" }<span class="label label-success pull-right">{$package.download_count/} downloads</span>{/if}
</h4>
</a>
  </div>
  <div class="panel-body">
<p class="description">
{unless isempty="$package.description" }{$package.description/}{/unless}
{unless isempty="$package.tags" }
<div class="well well-sm"><strong>tags:</strong>
{foreach item="tag" from="$package.tags" }<span class="badge">{$tag/}</span> {/foreach}
</div>
{/unless}
{unless isempty="$package.links" }
<div class="well well-sm"><strong>Links:</strong>
{foreach key="lnk_name" item="lnk" from="$package.links" }<a href="{$lnk.url/}"><span class="label label-info">{htmlentities}{$lnk_name/}{/htmlentities}</span></a> {/foreach}
</div>
{/unless}
</p>

{if condition="$package.has_archive" }
<div class="well archive">
	{if isset="$archive_url"}<a href="{$archive_url/}">Archive
	<span class="glyphicon glyphicon-floppy-save"></span>
	</a>{/if}
	({$package.archive_file_size/} octets -- {$package.archive_last_modified/})
</div>
<div class="well">
<strong>Associated URIs
{if isset="$edit_uri_url"}<a href="{$edit_uri_url/}"> (manage)</a>{/if}
</strong>
<ul class="uri-list">
{foreach key="uri" item="url" from="$uris" }<li class="uri"><a href="{$url/}">/{$package.version.value/}{$uri/}</a></li>
{/foreach}
</ul>
</div>
<p class="howto"><span class="glyphicon glyphicon-cog"></span> iron install {$package.human_identifier/}</p>
{/if}
<br/>

<p class="text-muted text-right">
  <span>{$package.text_last_modified/}</span>
  <span class="packagetooltip text-right" data-toggle="tooltip" data-placement="right" data-delay="{{show:1000, hide:100}}" title data-original-title="id={$package.id/}"><span class="glyphicon glyphicon-info-sign"></span></span>
</p>
  </div>
</div>
