<div class="download-box">
{if condition="$has_error"}
<div class="message error">
		<strong>Bad Request <small>Error 400</small></strong>
		<p>The file you uploaded could not be saved because the file is not valid,
		either contact the webmaster or try again. 
		Check the template 
		<textarea>
{literal}
{
	"location":"/home/ftp/pub/download/15.01",
	"files":[
		{
			"name":"Eiffel_15.01_gpl_96535-solaris-sparc-64.tar.bz2", 
			"size":102729822, 
			"sha256":"5805182a5eadcc3b91049a3ddbe13937bb3ac25991ce9619c76ac0a3e94c3f1a",
			"major":15, 
			"minor":01, 
			"revision":96535, 
			"platform":"solaris-sparc-64"
		}
	]
}
{/literal}			
		</textarea>
		Use your browser's <strong>Back</strong> button to navigate to the page you came from.</p>
		<p><strong>Or you could just press this link:</strong> <a href="{$site_url/}" itemprop="home" rel="home">Take Me Home</a></p> 
</div>
{/if}
{unless condition="$has_error"}
<p class="message success">Your uploaded data was saved <br/>
{/unless}
</div>
