{assign name="debug_enabled" value="True"/}
{if condition="$debug_enabled"}
<ul>
{assign name="kpage" value="page"/}
{assign name="kregions" value="regions"/}
{foreach key="k" item="i" from="$page.variables"}
	{unless condition="$k ~ $kpage"}
	{unless condition="$k ~ $kregions"}
	<li><strong>{$k/}</strong>={$i/}</li>
	{/unless}
	{/unless}
{/foreach}
</ul>
{/if}
