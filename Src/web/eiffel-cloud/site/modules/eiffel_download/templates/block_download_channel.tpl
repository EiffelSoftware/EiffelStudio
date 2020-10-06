{assign name="stable_channel" value="stable"/}
	<p> After downloading a release suitable for your system, please follow the <a href="https://www.eiffel.org/doc/eiffelstudio/Setup and installation">installation instructions</a> and <a href="https://www.youtube.com/channel/UCT6IcRZAfa-uFD0k3Dbi_7A">installation videos</a>.
		If you are new to Eiffel, please check the <a href="https://www.eiffel.org/doc/eiffelstudio/EiffelStudio tutorials">tutorials </a> and <a href="https://www.youtube.com/playlist?list=PLhVybat45jE9TObIY8nkkA5OejGnW5yby" target="_blank">videos</a>.
	</p>

  	 {if isset="$last_release"}
	  <div class="promo-area download-{$download_channel/}">
		<div class="holder">
			<div class="btn-holder">
				<div class="row">
					<span class="release">{$last_release/}<!-- - {$platform/}--></span>
				</div>
				<a class="btn-download" href="{$download_link/}">Download 
                    {unless condition="$download_channel ~ $stable_channel"}{$download_channel/}{/unless}
                    Now</a>
			</div>
		</div>
	  </div>
	<br/>  
	<h2>{$product.name/}</h2>
	{/if}
	{unless isset="$products"}
	<h3>{$download_channel/} Releases: not available </h3>
	{/unless}
	{if isset="$products"}
	<h3>{$download_channel/} Releases</h3>
	{/if}
	{foreach item="ic" from="$products"}
	  <div class="toggle">
        <div class="less">
	        <a class="button-read-more button-read" href="#read">{$ic.name/} {$ic.number/} ▹</a>
	        <a class="button-read-less button-read" href="#read">{$ic.name/} {$ic.number/} ▾</a>
	    </div>
		
		<div class="more">
			<h2> {$ic.name/} {$ic.number/}</h2> 
{if condition="$download_channel ~ $stable_channel"}
			<h4><a class="" href="{$site_url/}doc/eiffelstudio/Release_notes_for_{$ic.name/}_{$ic.number/}">Release Notes</a></h4>
{/if}
        	<table class="download_decorator">
				<thead>
					<tr class="first">
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
                      {$item.filename/}</a></td>                        
					  <td>{$item.platform/}</td>
					  <td>{$item.size/}</td>
					  <td><tt>{$item.hash/}</tt></td>
					</tr>
					{/foreach}
				</tbody>	
			</table>
	    </div>
	</div>
  	{/foreach}
{if condition="$download_channel ~ $stable_channel"}
    <h3>Go to <a class="" href="{$site_url/}downloads/channel/beta">Beta Releases</a></h3>	
{/if}
{unless condition="$download_channel ~ $stable_channel"}
    <h3>Go to <a class="" href="{$site_url/}downloads/channel/stable">Stable Releases</a></h3>
{/unless}
