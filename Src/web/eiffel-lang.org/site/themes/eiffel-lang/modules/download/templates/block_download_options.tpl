<h1>Downloads</h1>


<div id="EiffelStudio">
	<div class="toggle2">
		<h2 title="Click to show downloads for this version">{$product.name/} ▹</h2>
	</div>
	<div class="toggle2" style="display:none;">
		<h2 title="Click to hide downloads for this version">{$product.name/} ▾</h2>

		<h3>Stable versions</h3>

		<h2 class"toggleDownload">{$product.name/} {$product.number/}</h2>
		<table class="download_decorator">
			<thead>
				<tr class="first">
				  <th>File name</th>
				  <th>Platform</th>
				  <th>Size</th>
				  <th>Md5</th>
				</tr>
			</thead>
			<tbody>

				{foreach item="item" from="$product.downloads"}
		    	<tr>
				  <td class="filename"><a id="link" class="download_link" href="{$mirror/}{$product.name/} {$product.number/}/{$product.build/}/{$item.filename/}/download" target="_blank">{$item.filename/}</a></td>
				  <td>{$item.platform/}</td>
				  <td>{$item.size/}</td>
				  <td><tt>{$item.md5/}</tt></td>
				</tr>
				{/foreach}
			</tbody>	
		</table>
    </div>
</div>    
