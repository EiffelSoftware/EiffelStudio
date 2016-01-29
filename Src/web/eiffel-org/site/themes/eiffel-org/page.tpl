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
				<main id="main">
					{assign name="doc_page_type" value="doc"/}
					{assign name="true_value" value="true"/}
					{assign name="space_value" value=" "/}
					{assign name="l_css_classes" value=""/}
					{if isset="$content_css_class"}{assign name="l_css_classes" expression="$l_css_classes:$space_value:$content_css_class"/}{/if}
					{if isset="$page.type"}{assign name="l_css_classes" expression="$l_css_classes:$space_value:$page.type"/}{/if}
					{assign name="has_first_sidebar" expression="false"/}

					<div class="container">
					{unless isempty="$page.region_sidebar_first"}
						{assign name="has_first_sidebar" expression="$true_value"/}
						<aside id="sidebar">
							{if isset="$page.region_sidebar_first"}
							<div class="holder">{$page.region_sidebar_first/}</div>
							{/if}
						</aside>
					{/unless}
					{assign name="has_second_sidebar" value="false"/}
					{if condition="False"}	
						{unless isempty="$page.region_sidebar_second"}{assign name="has_second_sidebar" expression="$true_value"/}{/unless}
					{/if}
					<div id="content" class="{$l_css_classes/}{if condition="$has_first_sidebar ~ $true_value"} with-first-sidebar{/if}{if condition="$has_second_sidebar ~ $true_value"} with-second-sidebar{/if}" itemtype="http://schema.org/Article" itemscope="">
						<a id="main-content"><!-- Internal anchor to top content --></a>
						<div class="holder">
						{unless isempty="$page_title"}<h1 id="page-title" class="title">{$page_title/}</h1>{/unless}
						{if condition="$page.is_front"}
							{include file="front/container-main.tpl"/}
						{/if}
						{unless condition="$page.is_front"}
							{if condition="$page.type ~ $doc_page_type"}
								{include file="doc/content.tpl"/}
							{/if}
							{unless condition="$page.type ~ $doc_page_type"}
								{if isset="$page.region_content"}{$page.region_content/}{/if}
							{/unless}
						{/unless}
						</div>
					</div>
					{if condition="$has_second_sidebar ~ $true_value"}	
						<aside>	
							<div class="holder">{$page.region_sidebar_second/}</div>
						</aside>
					{/if} 
					</div>
				</main>
			  {include file="footer.tpl"/}
			</div>
		</div>
	</div>
{include file="optional_enhancement_js.tpl"/}

</body>
</html>
