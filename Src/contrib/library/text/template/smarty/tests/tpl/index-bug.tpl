Template test
{assign name="offset" value="  " /}
 Tree name = {$TheData.name /}

{unless isempty="$TheData.nodes_table" }
*** Table of Nodes ***
{foreach item="inode" key="knode" from="$TheData.nodes_table" }
  [{$knode /}] id={$inode.id /} name={$inode.name /}
{/foreach}
{/unless}
