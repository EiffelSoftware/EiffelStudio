Thank you for your order at {$site_url/}.<br/>

{if isset="$invoice_url"}See your invoice at {$invoice_url/}. {/if}
{if isset="$receipt_or_invoice_urls"}See document(s):
{foreach key="k" item="i" from="$receipt_or_invoice_urls"}- {$k/} at {$i/}.{/foreach}
{/if}


--
This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using "reply", you will not receive an answer.
