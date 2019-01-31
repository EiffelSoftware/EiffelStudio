	  
	<p> After downloading a release suitable for your system, please follow the <a href="{$site_url/}doc/eiffelstudio/Setup and installation">installation instructions</a> and <a href="https://www.youtube.com/channel/UCT6IcRZAfa-uFD0k3Dbi_7A">installation videos</a>.
		If you are new to Eiffel, please check the <a href="{$site_url/}doc/eiffelstudio/EiffelStudio tutorials">tutorials </a> and <a href="https://www.youtube.com/playlist?list=PLhVybat45jE9TObIY8nkkA5OejGnW5yby" target="_blank">videos</a>.
	</p>

	  <div class="promo-area">
		<div class="holder">
			<div class="btn-holder">
				<div class="row">
					<span class="release">{$last_release/} - {$platform/}</span>
				</div>
				<a class="btn-download" href="{$site_url/}download">Download Now</a>
			</div>
		</div>
	  </div>
	<br/>  
	<h2>{$product.name/}</h2>

	<h3>Stable versions</h3>

	{foreach item="ic" from="$products"}
	  <div class="toggle">
        <div class="less">
	        <a class="button-read-more button-read" href="#read">{$ic.name/} {$ic.number/} ▹</a>
	        <a class="button-read-less button-read" href="#read">{$ic.name/} {$ic.number/} ▾</a>
	    </div>
		
		<div class="more">
			<h2> {$ic.name/} {$ic.number/}</h2>   <h4><a class="" href="{$site_url/}doc/eiffelstudio/Release_notes_for_{$ic.name/}_{$ic.number/}">Release Notes</a></h4>
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
					  <td class="filename"><a id="link" class="download_link" href="{$mirror/}{$ic.name/} {$ic.number/}/{$ic.build/}/{$item.filename/}/download" target="_blank">{$item.filename/}</a></td>
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


	<h3>Beta Releases <a class="" href="{$site_url/}downloads/channel/beta">channel beta</a></h3>
