<h1>Downloads</h1>

	<p> After downloading a release suitable for your system, please follow the <a href="#">installation instructions</a> and <a href="#">installation videos</a>.

		If you are new to Eiffel, please check the <a href="#">tutorials </a> and <a href="#">videos</a>.
	</p>

	<h2>{$product.name/}</h2>

	<h3>Stable versions</h3>

	{foreach item="ic" from="$products"}
	  <div class="toggle">

	    <div class="less">
	        <a class="button-read-more button-read" href="#read">{$ic.name/} {$ic.number/} ▹</a>
	        <a class="button-read-less button-read" href="#read">{$ic.name/} {$ic.number/} ▾</a>
	    </div>
		
		<div class="more" style="display:none">
			<h2> {$ic.name/} {$ic.number/}</h2> 
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

					{foreach item="item" from="$ic.downloads"}
			    	<tr>
					  <td class="filename"><a id="link" class="download_link" href="{$mirror/}{$ic.name/} {$ic.number/}/{$ic.build/}/{$item.filename/}/download" target="_blank">{$item.filename/}</a></td>
					  <td>{$item.platform/}</td>
					  <td>{$item.size/}</td>
					  <td><tt>{$item.md5/}</tt></td>
					</tr>
					{/foreach}
				</tbody>	
			</table>
	    </div>
	</div>    
  	{/foreach}
