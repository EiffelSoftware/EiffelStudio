{assign name="doc_page_type" value="doc"/}
{assign name="blog_page_type" value="blog"/}
{assign name="true_value" value="true"/}

<section id="content" class="{$l_css_classes/}" itemtype="http://schema.org/Article" itemscope="">
	<div class="container grid has-gutter">

	{unless isempty="$page.region_sidebar_first"}
		<aside id="sidebar">
			{if isset="$page.region_sidebar_first"}
			<div class="holder">{$page.region_sidebar_first/}</div>
			{/if}
		</aside>
	{/unless}

	<div class="content">
	{unless isempty="$page_title"}<h1 id="page-title" class="title">{$page_title/}</h1>{/unless}
		{if condition="$page.type ~ $doc_page_type"}
			{include file="doc/content.tpl"/}
		{/if}
		{unless condition="$page.type ~ $doc_page_type"}
			{if isset="$page.region_content"}{$page.region_content/}{/if}
		{/unless}
		{if condition="$page.type ~ $blog_page_type"}
			{include file="3rd/node-comments.tpl"/}
		{/if}
		{assign name="myprojectsname" value="myprojects"/}
		{if condition="$node.link.location ~ $myprojectsname"}{include file="3rd/node-comments.tpl"/}{/if}
	</div>

	{if value="False"}
	{unless isempty="$page.region_sidebar_second"}
		<aside>	
			<div class="holder">{$page.region_sidebar_second/}</div>
		</aside>
	{/unless} 
	{/if}
	</div>
</section>
