{if isset="$user"}
Dear {$profile_name/},

{/if}
You have a new EiffelStudio license {$license_key/}.

{if isset="$user"}
The license is associated with your account "{$user_name/}" (email "{$user_email/}").
Please visit {$site_url/} .
{/if}
{unless isset="$user"}
The license is associated with the email address "{$user_email/}".
Please register a new account with that email at {$site_url/} .
{/unless}


--
This email is generated automatically, and the address is not monitored for responses. If you try contacting us by using "reply", you will not receive an answer.
