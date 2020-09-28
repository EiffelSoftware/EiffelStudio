{unless isempty="$customer_name"}Dear {htmlentities}{$customer_name/}{/htmlentities},{/unless}
<p>You have a new {unless isempty="$license_plan_title"}"{htmlentities}{$license_plan_title/}{/htmlentities}" {/unless} EiffelStudio license <strong>{$license_key/}</strong>.</p>

{if isset="$user"}
<p>The license is associated with your account "{htmlentities}{$user_name/}{/htmlentities}" {unless isempty="$user_email"}(email "{$user_email/}"){/unless}.</p>
<p>Please visit <a href="{$site_url/}">{$site_url/}</a> .</p>
{/if}
{unless isset="$user"}{unless isempty="$user_email"}
<p>The license is associated with the email address "{$user_email/}".</p>
<p>Please register a new account with that email at <a href="{$site_url/}">{$site_url/}</a> .</p>
{/unless}{/unless}

<p><a href="https://www.eiffel.com/eiffelstudio/try/">Click here to download EiffelStudio.</a></p>

<p>You will find the many resources we offer to our users to make the most of the features of EiffelStudio at <a href="https://www.eiffel.com/resources/">https://www.eiffel.com/resources/</a>.</p>  

<p>For technical questions please join the EiffelStudio usergroup at <a href="https://groups.google.com/g/eiffel-users">https://groups.google.com/g/eiffel-users</a>.</p>

<p>For specific questions and to access the support level you selected at the time of your purchase please visit <a href="https://support.eiffel.com/">the support website</a>.</p>

<p>Best regards,<br/>
The Eiffel Software Team
</p>

<br/>
<p><a href="https://www.eiffel.com/resources/fan-zone/">Connect with us ...</a></p>
<p>Please feel free to contact us at <a href="{$site_url/}">{$site_url/}</a> for any questions you may have.</p>
<p>
--
This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using "reply", you will not receive an answer.
</p>
