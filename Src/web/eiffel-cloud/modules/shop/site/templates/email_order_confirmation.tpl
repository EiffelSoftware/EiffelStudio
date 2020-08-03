Thank you for your order at {$site_url/}.

{if isset="$invoice_url"}See your invoice at {$invoice_url/}. {/if}
{if isset="$receipt_or_invoice_urls"}See document(s):
{foreach key="k" item="i"}- {$k/} at {$i/}.{/foreach}
{/if}
