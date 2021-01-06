<!DOCTYPE html>
<html lang="en">
	{include file="master/head.tpl"/}
	<body>
		{include file="master/navbar.tpl"/}
		<div class="container-fluid" itemscope itemtype="{$host/}/static/profile/esa_api.xml">
			<div class="main">
				{include file="guest_closed_reports.tpl"/}
			</div>
		</div>
		{include file="master/footer.tpl"/}
	</body>
</html>
