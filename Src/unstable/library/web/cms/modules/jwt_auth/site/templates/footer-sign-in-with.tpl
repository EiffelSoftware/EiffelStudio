<div class="help-sign-in-with">
You have been redirected from the application <em>{$info/}</em> to sign in.
<p>
{if isempty="$user"}First, you need to sign in with an existing account ...{/if}
{unless isempty="$user"}You can either use the current authenticated user <em>{$user_profile_name/}</em> or sign with a different account...{/unless}
</p>
<p>(Current request expires in {$remaining_minutes/} min and {$remaining_seconds/} s ...)</p>
</div>
