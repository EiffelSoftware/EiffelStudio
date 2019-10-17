<div class="contact-box">
{if condition="$has_error"}
<div class="message error">
		<strong>Internal Server Error <small>Error 500</small></strong>
		<p>The page you requested could not be served because the server is down,
		either contact the webmaster or try again. 
		Use your browser's <strong>Back</strong> button to navigate to the page you came from.</p>
		<p><strong>Or you could just press this link:</strong> <a href="{$site_url/}" itemprop="home" rel="home">Take Me Home</a></p> 
</div>
{/if}
{unless condition="$has_error"}
<p class="message success">Thank you for contacting the Eiffel Programming Language community.<br/>
We will get back to you promptly on your contact request.</p>	
{/unless}
</div>
