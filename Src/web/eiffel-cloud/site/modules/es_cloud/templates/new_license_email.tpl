{if isset="$user"}
<h2>Dear {$profile_name/},</h2>

{/if}
<p>You have a new EiffelStudio license <strong>{$license_key/}</strong>.</p>

{if isset="$user"}
<p>
The license is associated with your account "{$user_name/}" (email "{$user_email/}").<br/>
Please visit {$site_url/} .
</p>
{/if}
{unless isset="$user"}
<p>
The license is associated with the email address "{$user_email/}".<br/>
Please register a new account with that email at {$site_url/} .
</p>
{/unless}


<br/>
<p>
--
This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using "reply", you will not receive an answer.
</p>
