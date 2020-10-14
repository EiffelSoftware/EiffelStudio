{assign name="stable_channel" value="stable"/}
<div class="download-channel">
{if isset="$last_release"}
	<div class="promo-area download-now-box download-{$download_channel/}">
		<div class="row"><span class="release">{$last_release/}<!-- - {$platform/}--></span></div>
		<a class="btn-download" href="{$download_link/}">Download {unless condition="$download_channel ~ $stable_channel"}{$download_channel/}{/unless} Now</a>
	</div>
{/if}
	<h2>{$product.name/}
	{unless isset="$products"} - {$download_channel/} Releases: not available{/unless}
	{if isset="$products"} - {$download_channel/} Releases{/if}
	</h2>
	<p class="intro"> After downloading a release suitable for your system, please follow the <a href="htps://www.eiffel.org/doc/eiffelstudio/Setup and installation">installation instructions</a> and <a href="https://www.youtube.com/channel/UCT6IcRZAfa-uFD0k3Dbi_7A">installation videos</a>.
		If you are new to Eiffel, please check the <a href="https://www.eiffel.org/doc/eiffelstudio/EiffelStudio tutorials">tutorials </a> and <a href="https://www.youtube.com/playlist?list=PLhVybat45jE9TObIY8nkkA5OejGnW5yby" target="_blank">videos</a>.
	</p>
	{foreach item="ic" from="$products"}
      <div class="product">
		<h2 class="title ">{$ic.name/} {$ic.number/}</h2> 
		<div class="details" data-item="{unless isset="is_first_product"}{assign name="is_first_product" value="false"/}first{/unless}">
{if condition="$download_channel ~ $stable_channel"}
			<h4><a href="{$site_url/}doc/eiffelstudio/Release_notes_for_{$ic.name/}_{$ic.number/}">Release Notes</a></h4>
{/if}
        	<table class="download_decorator">
				<thead>
					<tr>
					  <th>File name</th>
					  <th>Platform</th>
					  <th>Size</th>
					  <th>SHA-256</th>
					</tr>
				</thead>
				<tbody>
					{foreach item="item" from="$ic.downloads"}
					<tr>
						<td class="filename">
							{assign name="itemlink" expression="$item.link" /}
							{unless isempty="$itemlink"}
							<a id="link" class="download_link" href="{$itemlink/}" target="_blank">
							{/unless}
							{if isempty="$itemlink"}
							{if isempty="$ic.default_mirror"}
							{assign name="prod_mirror" expression="$ic.default_mirror"/}
							{/if}
							{unless isempty="$ic.default_mirror"}
							{assign name="prod_mirror" expression="$mirror"/}
							{/unless}
							<a id="link" class="download_link" href="{$prod_mirror/}{$ic.name/} {$ic.number/}/{$ic.build/}/{$item.filename/}/download" target="_blank">
							{/if}
							{$item.filename/}</a>
						</td>
						<td class="platform">{$item.platform/}</td>
						<td class="size">{$item.size/}</td>
						<td class="hash"><samp>{$item.hash/}</samp></td>
					</tr>
					{/foreach}
				</tbody>	
			</table>
	    </div>
	  </div>
  	{/foreach}
	</div>
{if condition="$download_channel ~ $stable_channel"}
    <h3>Go to <a href="{$site_url/}downloads/channel/beta">Beta Releases</a></h3>	
{/if}
{unless condition="$download_channel ~ $stable_channel"}
    <h3>Go to <a href="{$site_url/}downloads/channel/stable">Stable Releases</a></h3>
{/unless}
</div>
