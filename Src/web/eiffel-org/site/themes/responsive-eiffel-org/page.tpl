<!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<title>{if isset="$site_title"}{$site_title/}{/if}</title>
<link media="all" rel="stylesheet" href="{$theme_path/}css/all.css" />
<link rel="shortcut icon" href="{$site_url/}favicon.ico"/>
<link href="https://fonts.googleapis.com/css?family=Inconsolata|Open+Sans:400,700|Titillium+Web" rel="stylesheet" type="text/css" />

<!--[if IE]><script src="{$theme_path/}js/ie.js"></script><![endif]-->

{if isset="$head"}{$head/}{/if}
{if isset="$styles"}{$styles/}{/if}

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script> 

{if isset="$scripts"}{$scripts/}{/if}
{if isset="$head_lines"}{$head_lines/}{/if}
</head>
<body class="page">
<div id="page">
<!-- Header -->
	{include file="header.tpl"/}
<!-- Main part -->
<main id="main">
	{assign name="true_value" value="true"/}
	{assign name="space_value" value=" "/}
	{assign name="l_css_classes" value=""/}
	{if isset="$content_css_class"}{assign name="l_css_classes" expression="$l_css_classes:$space_value:$content_css_class"/}{/if}
	{if isset="$page.type"}{assign name="l_css_classes" expression="$l_css_classes:$space_value:$page.type"/}{/if}
	<a id="main-content"><!-- Internal anchor to top content --></a>
	{if condition="$page.is_front"}
		{include file="front/page-content.tpl"/}
	{/if}
	{unless condition="$page.is_front"}
		{include file="page-content.tpl"/}
	{/unless}
</main>
<!-- Footer -->
{include file="footer.tpl"/}

	<script src="{$theme_path/}js/wdownloads.js"></script>
	<script src="{$theme_path/}js/home.js"></script>

	<link href="{$theme_path/}js/google-code-prettify-eiffel/styles/lang-eiffel.css" type="text/css" rel="stylesheet" />
	<script src="https://cdn.jsdelivr.net/gh/google/code-prettify@master/loader/run_prettify.js"></script>
    <script src="{$theme_path/}js/google-code-prettify-eiffel/src/lang-eiffel.js"></script>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>

</div>
</body>

</html>
