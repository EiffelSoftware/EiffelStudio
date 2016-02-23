{include file="modules/search_by_report_id.tpl"/}

<div class="row">
	<div class="col-xs-12">
	{if isset="$user"}
		<form class="form-inline well" action="{$host/}/reports" id="search" method="GET" itemprop="search">
	{/if}
			<input type="hidden" name="size" value="{$size/}"/>
			<div class="row">
				<div class="col-xs-6">
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" for="input01" itemprop="category" data-original-title="<p>The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.</p>">Category</label>
						</div>
						<div class="col-xs-8">
							<select class="form-control" data-style="btn-primary" name="category" form="search">
								<option value="0">ALL</option>
								{foreach from="$categories" item="item"}
									{if condition="$item.id = $view.selected_category"}
										<option value="{$item.id/}" selected>{$item.synopsis/}</option>
									{/if}
									{unless condition="$item.id = $view.selected_category"}
										<option value="{$item.id/}">{$item.synopsis/}</option>
									{/unless}
								{/foreach}
							</select>
						</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" for="input01" title="To retrieve problem reports using the submitter's username: enter the username" itemprop="submitter" data-original-title="<p>Person reporting a problem</p>">Submitter</label>
						</div>
						<div class="col-xs-8">
							{if isset="$submitter"}
								<input type="text" name="submitter" class="form-control" placeholder="John.H" value="{$submitter/}">
							{/if}
							{unless isset="$submitter"}
								<input type="text" name="submitter" class="form-control" placeholder="John.H">
							{/unless}
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6">
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" for="input01" itemprop="priority" data-original-title="<small><p>How soon the solution is required. Accepted values include:</p>
								<UL>
								<LI><B>High</B>: A solution is needed as soon as possible.</LI>
								<LI><B>Medium</B>: The problem should be solved in the next release.</LI>
								<LI><B>Low</B>: The problem should be solved in a future release.</LI>
								</UL></small>">Priority</label>
						</div>
						<div class="col-xs-8">
							<select class="form-control" data-style="btn-primary" name="priority" form="search">
								<option value="0">ALL</option>
								{foreach from="$priorities" item="item"}
									{if condition="$item.id = $view.selected_priority"}
										<option value="{$item.id/}" selected>{$item.synopsis/}</option>
									{/if}
									{unless condition="$item.id = $view.selected_priority"}
										<option value="{$item.id/}">{$item.synopsis/}</option>
									{/unless}
								{/foreach}
							</select>
						</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" for="input01" itemprop="responsible" data-original-title="<p>Person having an obligation to do analized a given report problem.</p>">Responsibles</label>
						</div>
						<div class="col-xs-8">
							<select class="form-control" data-style="btn-primary" name="responsible" form="search">
								<option value="0">Any</option>
								{foreach from="$responsibles" item="item"}
									{if condition="$item.id = $view.selected_responsible"}
										<option value="{$item.id/}" selected>{$item.synopsis/}</option>
									{/if}
									{unless condition="$item.id = $view.selected_responsible"}
										<option value="{$item.id/}">{$item.synopsis/}</option>
									{/unless}
								{/foreach}
							</select>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-6">
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" for="input01" itemprop="severity" data-original-title="<small><p>The severity of the problem. Accepted values include:</p>
								<UL>
									<LI><B>Critical</B>: The product, component or concept is completely non operational. No workaround is known.</LI>
									<LI><B>Serious</B>: The product, component or concept is not working properly. Problems that would otherwise be considered critical are rated serious when a workaround is known.</LI>
									<LI><B>Non-critical</B>: The product, component or concept is working in general, but lacks features, has irritating behavior, does something wrong, or doesn't match its documentation.</LI>
								</UL></small>">Severity</label>
						</div>
						<div class="col-xs-8">
							<select class="form-control" data-style="btn-primary" name="severity" form="search">
								<option value="0">ALL</option>
								{foreach from="$severities" item="item"}
									{if condition="$item.id = $view.selected_severity"}
										<option value="{$item.id/}" selected>	{$item.synopsis/}</option>
									{/if}
									{unless condition="$item.id = $view.selected_severity"}
										<option value="{$item.id/}"> {$item.synopsis/} </option>
									{/unless}
								{/foreach}
							</select>
						</div>
					</div>
				</div>
				<div class="col-xs-6">
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" for="input01" itemprop="status" data-original-title="<small><p>The status of a problem can be one of the following:</p>
								<ul>
									<li><b>Open</b>	The initial state of a Problem Report. This means the PR has been filed and the responsible person(s) notified.</li>
									<li><b>Analyzed</b>	The responsible person has analyzed the problem. The analysis should contain a preliminary evaluation of the problem and an estimate of the amount of time and resources necessary to solve the problem. It should also suggest possible workarounds.</li>
									<li><b>Closed</b> A Problem Report is closed only when any changes have been integrated, documented, and tested, and the submitter has confirmed the solution </li>
									<li><b>Suspended</b> Work on the problem has been postponed. This happens if a timely solution is not possible or is not cost-effective at the present time. The PR continues to exist, though a solution is not being actively sought. If the problem cannot be solved at all, it should be closed rather than suspended.</li>
									<li><b>Won't fix</b> Won't fix problem report.</li>
								</ul></small>">Status</label>
						</div>
						<div class="col-xs-8">
							<input type="hidden" name="status" value="0" />
							{foreach from="$status" item="item"}
								{if condition="$item.is_selected"}
									<input type="checkbox" id="checkbox-status-{$item.id/}" name="status" value="{$item.id/}" checked/>
								{/if}
								{unless condition="$item.is_selected"}
									<input type="checkbox" id="checkbox-status-{$item.id/}" name="status" value="{$item.id/}"/>
								{/unless}
								<label class="checkbox" for="checkbox-status-{$item.id/}">
									<img src="{$host/}/static/images/status_{$item.id/}.gif" class="img-rounded" data-original-title="{$item.synopsis/}"/>
								</label>
							{/foreach}
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-xs-1">
					<label class="control-label-api" for="input01" title="To retrieve problem reports filtered by default synopsis or Content, Descriptions, To Reproduce and Interactions Content" itemprop="filter" data-original-title="<p>Filter problem Report</p>">Filter</label>
				</div>
				<div class="col-xs-8">
					{if isset="$filter"}
						<input type="text" name="filter" class="form-control" placeholder="Filter" value="{$filter/}">
					{/if}
					{unless isset="$filter"}
						<input type="text" name="filter" class="form-control" placeholder="Filter">
					{/unless}
				</div>
				<div class="col-xs-2">
					{if isset="$filter_content"}
						<input type="checkbox" id="checkbox-filter-content" name="filter_content" value="1" checked />
					{/if}
					{unless isset="$filter_content"}
						<input type="checkbox" id="checkbox-filter-content" name="filter_content" value="1"/>
					{/unless}
					<label class="checkbox" for="checkbox-filter-content">Content</label>
				</div>
			</div>
			<p></p>
			<div class="row">
				<div class="col-xs-6">
					<button type="submit" class="btn btn-default">Search</button>
				</div>
			</div>
		</form>
	</div>
</div>

<h2 class="sub-header">Problem Reports
	<small>
		<div class="row" id="responsible_reports_page_size">
			<div class="col-xs-12">
				<input type="hidden" name="pages" id="pages_pe" value="{$pages/}"/>
				<input type="hidden" name="size" id="size_pe" value="{$size/}"/>

				<form class="form-inline" action="{$host/}/reports" id="reports" method="GET" itemprop="size">
					<input type="hidden" name="page" id="page_pe" value="{$index/}"/>
					<input type="hidden" name="category" id="category_pe" value="{$view.selected_category/}"/>
					<input type="hidden" name="submitter" id="submitter_pe" value="{$view.submitter/}"/>
					<input type="hidden" name="severity" id="severity_pe" value="{$view.selected_severity/}"/>
					<input type="hidden" name="priority" id="priority_pe" value="{$view.selected_priority/}"/>
					<input type="hidden" name="responsible" id="responsible_pe" value="{$view.selected_responsible/}"/>
					<input type="hidden" name="orderBy" id="orderBy_pe" value="{$view.order_by/}"/>
					<input type="hidden" name="dir"  id="dir_pe" value="{$view.dir/}"/>
					<input type="hidden" name="status" id="status_pe" value="{$status_query/}"/>
					<input type="hidden" name="filter" id="filter_pe" value="{$view.filter/}"/>
					<input type="hidden" name="filter_content" id="filter_content_pe" value="{$view.filter_content/}"/>
					<input type="hidden" name="count_bugs" id="count_bugs_pe" value="{$view.count_bugs/}"/>
						<div class="col-xs-2">
							<label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see.">Current page {$index/} of {$pages/}
							</label>	
						</div>
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="report_number" data-original-title="The number of reports you want to see.">Size</label>
						</div>
						<div class="col-xs-1">
							<input type="number" class="form-control form-bug-number-entry" min="1" name="size" value="{$size/}"/>
						</div>
						<div class="col-xs-1">
							<button type="submit" class="btn btn-default">Resize</button>
						</div>
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="count_bugs" data-original-title="Total number of bugs reports"># of Bugs</label>
						</div>
						<div class="col-xs-1">
							{$view.count_bugs/}
						</div>

				</form>
			</div>			
		</div>
  </small>		
</h2>

<div class="row">
	<div class="col-xs-12">
		<ul class="pager">
			<li><a href="{$host/}/reports?page=1&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.order_by/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}" itemprop="first" rel="first">First</a></li>
			{if isset="$prev"}
				<li><a href="{$host/}/reports?page={$prev/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.order_by/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}" itemprop="previous" rel="previous">Previous</a></li>
			{/if}
			{if isset="$next"}
				<li><a href="{$host/}/reports?page={$next/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.order_by/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}" itemprop="next" rel="next">Next</a></li>
			{/if}
				<li><a href="{$host/}/reports?page={$last/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.order_by/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}" itemprop="last" rel="last">Last</a></li>
		</ul>
	</div>
</div>

<div class="table table-responsive">
	<table class="table table-responsive table-bordered table-hover">
		<thead>
			<tr>
				<th>
					{assign name="column" value="number"/}
					{assign name="dir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_content={$view.filter_content/}"># <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
						{/if}
						{unless condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}"># <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
						{/unless}
					{/if}
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}"># </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="statusID"/}
					{assign name="dir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								<img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
						{/if}
						{unless condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								<img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
						{/unless}
					{/if}
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
							<img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="priorityID"/}
					{assign name="dir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								<img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
						{/if}
						{unless condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
						{/unless}
					{/if}
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
							<img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="severityID"/}
					{assign name="dir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								<img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
						{/if}
						{unless condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								<img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
						{/unless}
					{/if}
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
							<img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="synopsis"/}
					{assign name="dir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								Synopsis <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
						{/if}
						{unless condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								Synopsis <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
						{/unless}
					{/if}
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
							Synopsis </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="username"/}
					{assign name="dir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								Submitter <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
						{/if}
						{unless condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								Submitter <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
						{/unless}
					{/if}
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
							Submitter </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="submissionDate"/}
					{assign name="dir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								Date <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
						{/if}
						{unless condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								Date <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
						{/unless}
					{/if}
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">Date </a>
					{/unless}
				</th>
				<th>Responsible</th>
				<th>
					{assign name="column" value="categorySynopsis"/}
					{assign name="dir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_content={$view.filter_content/}">
								Category <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
						{/if}
						{unless condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">																Category <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
						{/unless}
					{/if}
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">Category </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="release"/}
					{assign name="dir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_content={$view.filter_content/}">Release <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
						{/if}
						{unless condition="$view.direction ~ $dir"}
							<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}"> Release <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
						{/unless}
					{/if}
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_content={$view.filter_content/}">Release </a>
					{/unless}
				</th>
			</tr>
		</thead>
		<tbody>
			{foreach from="$reports" item="item"}
				<form class="form-inline well" action="{$host/}/reports/{$item.number/}" id="reports_{$item.number/}" method="POST" itemprop="update">
					<input type="hidden" name="page" value="{$index/}"/>
					<input type="hidden" name="size" value="{$size/}"/>
					<input type="hidden" name="category" value="{$view.selected_category/}"/>
					<input type="hidden" name="severity" value="{$view.selected_severity/}"/>
					<input type="hidden" name="priority" value="{$view.selected_priority/}"/>
					<input type="hidden" name="responsible" value="{$view.selected_responsible/}"/>
					<input type="hidden" name="status" value="status={$status_query/}"/>
					<input type="hidden" name="orderBy" value="{$view.order_by/}"/>
					<input type="hidden" name="dir" value="{$view.dir/}"/>
					<input type="hidden" name="submitter" value="{$view.submitter/}"/>
					<input type="hidden" name="filter" value="{$view.filter/}"/>
					<input type="hidden" name="filter_content" value="{$view.filter_content/}"/>

					<tr>
						<td itemprop="report_number"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report-interaction" rel="report-interaction">{$item.number/}</a></td>
						<td class="text-center" itemprop="status"><img src="{$host/}/static/images/status_{$item.status.id/}.gif" class="img-rounded" data-original-title="{$item.status.synopsis/}"></td>
						<td class="text-center" itemprop="priority"><img src="{$host/}/static/images/priority_{$item.priority.synopsis/}.gif" class="img-rounded" data-original-title="{$item.priority.synopsis/}"></td>
						<td class="text-center" itemprop="severity"><img src="{$host/}/static/images/severity_{$item.severity.synopsis/}.gif" class="img-rounded" data-original-title="{$item.severity.synopsis/}"></td>
						<td itemprop="synopsis"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report-interaction" rel="report-interaction">{htmlentities}{$item.synopsis/}{/htmlentities}</a></td>
						<td itemprop="submitter">{$item.contact.name/}</td>
						<td itemprop="submission_date">{$item.submission_date_output/}</td>
						<td itemprop="responsible">
							<select class="selectpicker" for="input_{$item.number/}" name="user_responsible" form="reports_{$item.number/}">
								<option value="0">not assigned</option>
								{foreach from="$responsibles" item="val"}
									{if condition="$val.id = $item.assigned.id"}
										<option value="{$val.id/}" selected>{$val.synopsis/}</option>
									{/if}
									{unless condition="$val.id = $item.assigned.id"}
										<option value="{$val.id/}">{$val.synopsis/}</option>
									{/unless}
								{/foreach}
							</select>
						</td>
						<td itemprop="category">{$item.category.synopsis/}</td>
						<td itemprop="release">{$item.release/}</td>
						<td><button type="submit" class="btn btn-default">Update</button></td>
					</tr>
				</form>
			{/foreach}
		</tbody>
	</table>
</div>

<div class="row">
	<div class="col-xs-12">
		<ul class="pager">
			<li><a href="{$host/}/reports?page=1&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.order_by/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}" itemprop="first" rel="first">First</a></li>
			{if isset="$prev"}
				<li><a href="{$host/}/reports?page={$prev/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.order_by/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}" itemprop="previous" rel="previous">Previous</a></li>
			{/if}
			{if isset="$next"}
				<li><a href="{$host/}/reports?page={$next/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.order_by/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}" itemprop="next" rel="next">Next</a></li>
			{/if}
			<li><a href="{$host/}/reports?page={$last/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.order_by/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}" itemprop="last" rel="last">Last</a></li>
		</ul>
	</div>
</div>
