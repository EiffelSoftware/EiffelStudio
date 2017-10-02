{assign name="debug_enabled" value="True"/}
{if condition="$debug_enabled"}
<!-- start debug -->
{literal}
	<style>
		div.cms-debug>span {
			position: absolute;
			bottom: 5px;
			right: 5px;
			color: #ccc;
			padding: 5px;
		}
		div.cms-debug:hover>span {
			color: red;
		}
		div.cms-debug>span+ul {
			display: none;
			border: solid 2px red;
			background-color: #ccc;
			white-space: pre-wrap;
		}
		div.cms-debug:hover>span+ul {
			display: block;
			position: relative;
			bottom: 5px;
			left: 1%; right: 1%;
			width: 98%;
		}
	</style>
{/literal}
<div class="cms-debug"><span>Show debug</span>
<ul>
{assign name="kpage" value="page"/}{assign name="kregions" value="regions"/}{foreach key="k" item="i" from="$page.variables"}{unless condition="$k ~ $kpage"}{unless condition="$k ~ $kregions"}<li><strong>{$k/}</strong>={htmlentities}{$i/}{/htmlentities}</li>{/unless}{/unless}
{/foreach}
</ul>
</div>
<!-- end debug -->
{/if}
