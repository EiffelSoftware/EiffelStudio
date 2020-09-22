<h2>Thank you for your order at {$site_url/}.</h2>

{if isset="$invoice_url"}<p>See your invoice at {$invoice_url/}.</p> {/if}
{if isset="$receipt_or_invoice_urls"}<p>See document(s):
<ul>
{foreach key="k" item="i" from="$receipt_or_invoice_urls"}<li> {$k/} at {$i/}</li>{/foreach}
</ul>
{/if}


<br/>
<p>
--
This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using "reply", you will not receive an answer.
</p>
