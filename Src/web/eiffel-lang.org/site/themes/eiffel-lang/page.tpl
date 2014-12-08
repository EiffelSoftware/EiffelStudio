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
					</div>
				</header>
				<main id="main" role="main">
					{assign name="doc_page_type" value="doc"/}
					<div class="container">
						<aside id="sidebar">
							{if isset="$page.region_sidebar_first"}
							<div class="holder">{$page.region_sidebar_first/}</div>
							{/if}
						</aside>
						{if condition="$page.is_front"}
							{include file="front/container-main.tpl"/}
						{/if}
						{unless condition="$page.is_front"}
							{if condition="$page.type ~ $doc_page_type"}
								{include file="doc/content.tpl"/}
							{/if}
							{unless condition="$page.type ~ $doc_page_type"}
						<div id="content" class="{if isset="$content_css_class"}{$content_css_class/}{/if}{if isset="$page.type"} {$page.type/}{/if}">
							{if isset="$page.region_content"}{$page.region_content/}{/if}
						</div>
							{/unless}
						{if condition="False"}	
							<aside>	
								{if isset="$page.region_sidebar_second"}
								<div class="holder">{$page.region_sidebar_second/}</div>
								{/if}
							</aside>
                        {/if} 

						{/unless}
						
					</div>
				</main>
			  {include file="footer.tpl"/}
			</div>
		</div>
	</div>
{include file="optional_enhancement_js.tpl"/}

</body>
</html>
