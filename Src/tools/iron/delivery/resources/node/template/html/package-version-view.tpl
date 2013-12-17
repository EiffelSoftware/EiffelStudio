<div class="panel panel-default">
  <div class="panel-heading">
<a class="panel-title" href="/repository/{$package.version.value/}/package/{$package.id/}">
<h4>Package {$package.human_identifier/}
{if condition="$package.was_downloaded" }<span class="badge pull-right">{$package.download_count/} downloads</span>{/if}
</h4>
</a>
  </div>
  <div class="panel-body">
{unless isempty="$package.description" }
<p class="description">{$package.description/}</p>
{/unless}

{if condition="$package.has_archive" }
<p class="howto"><span class="glyphicon glyphicon-cog"></span> iron install {$package.human_identifier/}</p>
<p class="archive">
	{if isset="$archive_url"}<a href="{$archive_url/}">Archive
	<span class="glyphicon glyphicon-floppy-save"></span>
	</a>{/if}
	({$package.archive_file_size/} octets -- {$package.archive_last_modified/})
</p>
{/if}
<br/>
<div>
<strong>Associated URIs
{if isset="$edit_uri_url"}<a href="{$edit_uri_url/}"> (manage)</a>{/if}
</strong>
<ul class="uri-list">
{foreach key="uri" item="url" from="$uris" }<li class="uri"><a href="{$url/}">/{$package.version.value/}{$uri/}</a></li>
{/foreach}
</ul>
</div>
<p class="text-muted text-right">
  <span>{$package.text_last_modified/}</span>
  <span class="packagetooltip text-right" data-toggle="tooltip" data-placement="right" data-delay="{{show:1000, hide:100}}" title data-original-title="id={$package.id/}"><span class="glyphicon glyphicon-info-sign"></span></span>
</p>
  </div>
</div>
