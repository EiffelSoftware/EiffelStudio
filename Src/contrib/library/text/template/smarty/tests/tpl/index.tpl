{assign name="offset" value="" /}{assign name="offset_step" value="  " /}
 Offset = {$offset/}

Template test
 Tree name = {$TheData.name /}

{unless isempty="$TheData.nodes" }*** List of Nodes ***
{foreach item="node" from="$TheData.nodes" }{include file="node.tpl" }{assign name="NodeData" expression="$node" /}{/include}
{/foreach}{/unless}
