<div id="breadcrumb">
	<span class="ico"><img src="/theme/images/ico-document.png" width="21" height="21" alt="Image Description"></span>
			  		<a href="{$site_url/}/about">About</a>::<a href="{$site_url/}/contact">Contact</a>::Post-Contact
</div>

{if condition="$has_error"}
		<h1>Internal Server Error <small><font face="Tahoma" color="red">Error 500</font></small></h1>
		<br />
		<p>The page you requested could not be served because the server is down, either contact your webmaster or try again. Use your browser's <b>Back</b> button to navigate to the page you came from.</p>
		<p><b>Or you could just press this link:</b><a href="{$site_url/}/" itemprop="home" rel="home"> Take Me Home</a></p> 
{/if}
{unless condition="$has_error"}
<p>
	Thank you for contacting the Eiffel Programming Language community. </br>We will get back to you promptly on your contact request.
</p>	
{/unless}
