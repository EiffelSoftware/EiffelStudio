<div class="row">
	<div class="col-xs-12">
		<form class="form-inline well" action="{$host/}/report_detail/" id="reports" method="GET" itemprop="search">
			<div class="row">	
				<div class="col-xs-1">
					<label class="control-label-api" itemprop="report_number" data-original-title="Problem report number you need to see.">View Problem Report #:</label>
				</div>
				<div class="col-xs-1">
					<input type="number" class="form-control form-bug-number-entry" min="1" name="search" placeholder="Report #..." form="reports"/>
				</div>
				<div class="col-xs-1">
					<button type="submit" class="btn btn-default">Go</button>
				</div>
			</div>
		</form>
		{if condition="$view.has_closed_reports"}
		<form class="form-inline well" action="{$host/}/closed_reports" id="reports" method="GET" itemprop="search">
			<div class="row">		
				<div class="col-xs-1">
					<label class="control-label-api" itemprop="report_number" data-original-title="Problem report number you need to see.">View Recently Closed Reports</label>
				</div>
				<div class="col-xs-1">
					<button type="submit" class="btn btn-default">Go</button>
				</div>
			<div>	
		</form>
		{/if}
	</div>
</div>
