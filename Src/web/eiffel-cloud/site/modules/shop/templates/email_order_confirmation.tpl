{unless isempty="$customer_name"}Dear {htmlentities}{$customer_name/}{/htmlentities},{/unless}
<p>Thank you for your order at <a href="{$site_url/}">{unless isempty="$business_name"}{$business_name/}{/unless}{if isempty="$business_name"}{$site_url/}{/if}</a>.</p>

{unless isempty="$products"}<p>Item(s):
<ul>
{foreach item="i" from="$products"}<li>{htmlentities}{$i/}{/htmlentities}</li>{/foreach}
</ul>
{/unless}
{if isset="$amount_paid"}<p>Amount paid: {$amount_paid/} {$currency/}{/if}

{if isset="$invoice_url"}<p>See your invoice at <a href="{$invoice_url/}">{$invoice_url/}</a>.</p> {/if}
{if isset="$receipt_or_invoice_urls"}<p>Associated document(s):
<ul>
{foreach key="k" item="i" from="$receipt_or_invoice_urls"}<li><a href="{$i/}">{$k/}</a></li>{/foreach}
</ul>
{/if}
<p>We are honored to welcome you as a customer and happy to be of service to you.</p>
<p>Please feel free to contact us at <a href="{$site_url/}">{$site_url/}</a> for any questions you may have.</p>
<br/>
<p>Thank You</p>
{unless isempty="$account_name"}<p>{htmlentities}{$account_name/}{/htmlentities}.</p>{/unless}
<p>
--
This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using "reply", you will not receive an answer.
</p>
