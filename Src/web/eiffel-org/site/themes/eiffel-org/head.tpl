<head>
	<meta charset="utf-8">
	<title>{if isset="$site_title"}{$site_title/}{/if}</title>
{include file="optional_styling_css.tpl"/}
{if isset="$head"}{$head/}{/if}
{if isset="$styles"}{$styles/}{/if}

	<script type="text/javascript" src="{$site_url/}theme/js/jquery-1.8.3.min.js"></script>
{if isset="$scripts"}{$scripts/}{/if}
{if isset="$head_lines"}{$head_lines/}{/if}

</head>
