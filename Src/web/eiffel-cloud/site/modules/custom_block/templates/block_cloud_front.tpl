{unless isset="$user"}
{include file="block_cloud_front_any.tpl" /}
{/unless}
{if isset="$user"}
{include file="block_cloud_front_user.tpl" /}
{/if}
