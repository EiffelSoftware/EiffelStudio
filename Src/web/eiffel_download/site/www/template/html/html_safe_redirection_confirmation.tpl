<!DOCTYPE html>
<html lang="en-US">
	<head>
		<title>Eiffel Software - Downloading EiffelStudio</title>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
		<style>
		{literal}
			section { padding: 1em 3em 1em 3em; }
			p.link { padding-left: 3em; }
			ul.link { padding-left: 3em; }
		{/literal}
		</style>
	</head>
	<body style="background: #ececf0; font-family: Arial, Tahoma, sans-serif; font-size: 10pt; max-width:640px;">
		<header>
			<a href="https://www.eiffel.com">
				<img src="https://www.eiffel.com/wp-content/themes/eiffeldesign/images/logo.png" alt="Eiffel Software Logo"/></a>
		</header>
		<section>
			<h2>You are about to download EiffelStudio:</h2>
			<p class="link">
				<a class="btn btn-lg btn-primary" role="button" href="{$new_download_location/}" target="_dl_es">Click here to download EiffelStudio.</a>
			</p>
			<br/>
			<h4>Your web browser will ask you for Username and Password, please use the following values</h4>
			<ul class="link">
				<li><strong>Username</strong>: {$username/}</li>
				<li><strong>Password</strong>: {$password/}</li>
			</ul>
		</section>
		<footer>
			<br/>
			<p style="text-align: center;margin-top:50px;">Copyright &copy; 2020 Eiffel Software - 
				<a title="Privacy policy" href="https://www.eiffel.com/privacy-policy/">Privacy Policy</a>
			</p>
		</footer>

	</body>
</html>
