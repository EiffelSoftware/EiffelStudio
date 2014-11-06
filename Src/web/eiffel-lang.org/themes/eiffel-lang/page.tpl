<!doctype html>
<html>
{include file="head.tpl"/}
<body class="page">
	<div id="wrapper">
		<div class="w1">
			<div class="w2">
				<header id="header">
					<div class="header-block">
							{include file="header.tpl"/}
							{if condition="$is_front"}
								{include file="blocks/promo-area.tpl"/}
							{/if}
					</div>
				</header>
				<main id="main" role="main">
					{if condition="$is_front"}
						{include file="front/container-main.tpl"/}
					{/if}
					{unless condition="$is_front"}
					{assign name="doc_page_type" expression="doc"/}
					<div class="container">
						{if condition="$page.type ~ $doc_page_type"}
							{include file="doc/content.tpl"/}
						{/if}
						{unless condition="$page.type ~ $doc_page_type"}
						<div id="content" class="{if isset="$content_css_class"}{$content_css_class/}{/if}{if isset="$page.type"} {$page.type/}{/if}">
							{if isset="$content"}{$content/}{/if}
						</div>
						{/unless}
						<aside id="sidebar">
							{if isset="$page.region_sidebar_first"}
							<div class="holder">{$page.region_sidebar_first/}</div>
							{/if}
							{if isset="$page.region_sidebar_second"}
							<div class="holder">{$page.region_sidebar_second/}</div>
							{/if}
						</aside>
					</div>
					{/unless}
				</main>
			  {include file="footer.tpl"/}
			</div>
		</div>
	</div>
{include file="optional_enhancement_js.tpl"/}

</body>
</html>
