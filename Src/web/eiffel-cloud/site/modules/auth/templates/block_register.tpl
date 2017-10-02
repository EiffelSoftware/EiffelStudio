<div>
	<form action="{$site_url/}account/roc-register" method="post">
		<fieldset>
			<legend>Registration</legend>
			<div>
				<input type="text" id="name" name="name"  value="{$name/}" required  autofocus />
				<label for="name">Name</label>
				{if isset="$error_name"}
				<span><i>{$error_name/}</i></span> <br>
				{/if}
			</div>
			<div>
				<input type="password" id="password" name="password" value="" required/>
				<label for="password">Password</label>
			</div>
			<div>
				<input type="email" id="email" name="email"  value="{$email/}"  required/>
				<label for="email">Email</label>
				{if isset="$error_email"}
				<span><i>{$error_email/}</i></span> <br/>
				{/if}
			</div>
			<div>
				<textarea rows="4" cols="50" name="personal_information" id="personal_information" required>{$personal_information/}</textarea>
				<label for="personal_information">Tell us why you want to register an account</label>
				{if isset="$error_application"}
				<span><i>{$error_application/}</i></span><br/>
				{/if}
				{if isset="$application_description"}
				<br/>
				<p class="description">{$application_description/}</p>
				{/if}
			</div>
			{unless isempty="$recaptcha_site_key"}<div class="g-recaptcha" data-sitekey="{$recaptcha_site_key/}"></div><br/>{/unless}
			<button type="submit">Register</button>
		</fieldset>
	</form>
</div>
