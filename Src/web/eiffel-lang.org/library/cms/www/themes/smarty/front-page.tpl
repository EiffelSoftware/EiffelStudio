{include file="tpl/page-header.tpl"/}
		<div id="main-wrapper">
			<div id="main">
				<div id="first_sidebar" class="sidebar {if isset="$first_sidebar_css_class"}{$first_sidebar_css_class/}{/if}">{if isset="$first_sidebar"}{$first_sidebar/}{/if}</div>
				<div id="content" class="{if isset="$content_css_class"}{$content_css_class/}{/if}">
					Welcome ... this is the front page
					{if isset="$content"}{$content/}{/if}
				</div>
				<div id="second_sidebar" class="sidebar {if isset="$second_sidebar_css_class"}{$second_sidebar_css_class/}{/if}">{if isset="$second_sidebar"}{$second_sidebar/}{/if}</div>
			</div>
		</div>
{include file="tpl/page-footer.tpl"/}
