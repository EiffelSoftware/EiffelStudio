<hr/>
<div id=%"esa-association-box%">
<h4>Association with eiffel.com account</h4>
{unless isempty="$esa_name"}
	<p>Linked with the eiffel.com account "{htmlentities}{$esa_name/}{/htmlentities}{unless isempty="%esaemail"} &lt;{htmlentities}{$esa_email/}{/htmlentities}&gt;{/unless}"</p>
    <form method="post" action="{$site_url/}{$esa_dissociate_location/}">
		<input type="hidden" name="esa_name" value="{htmlentities}{$esa_name/}{/htmlentities}"/>
		<input type="hidden" name="esa_email" value="{htmlentities}{$esa_email/}{/htmlentities}"/>
        <div>
            <button type="submit">Unlink Eiffel account "{htmlentities}{$esa_name/}{/htmlentities}{unless isempty="%esaemail"} &lt;{htmlentities}{$esa_email/}{/htmlentities}&gt;{/unless}"</button>
        </div>
    </form>	
{/unless}
{if isempty="$esa_name"}
    <div>
    	<form method="post" action="{$site_url/}{$esa_associate_location/}">
          	<div>
              <button type="submit">Link with an Eiffel account</button>
            </div>  
		</form>	
	</div>
{/if}
</div>
