{include file="modules/search_by_report_id.tpl"/}

<div class="row">
	<div class="col-xs-12">
		<form class="form-inline well" action="{$host/}/reports" id="search" method="GET" itemprop="search">
			<input type="hidden" name="size" value="{$size/}"/>
			<div class="row">
				<div class="col-xs-6">
					<div class="row">
						<div class="col-xs-2">
							<label class="control-label-api" itemprop="category" data-original-title="The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.">Category</label>
						</div>
						<div class="col-xs-8">
							<select class="form-control" data-style="btn-primary" name="category" form="search" itemprop="search">
								<option value="0">ALL</option>
								{foreach from="$categories" item="item"}
									{if condition="$item.is_selected"} 
										<option value="{$item.id/}" selected>{$item.synopsis/}</option>
									{/if}
									{unless condition="$item.is_selected"}
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
									<input type="checkbox" name="status" value="{$item.id/}" checked /><img src="{$host/}/static/images/status_{$item.id/}.gif" class="img-rounded" data-original-title="{$item.synopsis/}" >
								{/if}
								{unless condition="$item.is_selected"}
									<input type="checkbox" name="status" value="{$item.id/}"/><img src="{$host/}/static/images/status_{$item.id/}.gif" class="img-rounded" data-original-title="{$item.synopsis/}"	>
								{/unless}
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
					<label class="checkbox inline" for="checkboxes-description">
						{if isset="$filter_content"}
							<input type="checkbox" name="filter_content" value="1" checked /> Content
						{/if}
						{unless isset="$filter_content"}
							<input type="checkbox" name="filter_content" value="1"/> Content
						{/unless}
					</label>
				</div>
			</div>
			<p/>
			<div class="row">
				<div class="col-xs-6">
					<button type="submit" class="btn btn-default">Search</button>
				</div>
			</div>			
				
		</form>
	</div>
</div>

<h2 class="sub-header">Problem Reports: 
	<small>
		<ul class="pagination">
			<li class="info">Current page {$index/} of {$pages/} - </li>
			<li><label class="control-label-api" itemprop="size" data-original-title="The status of a problem can be one of the following: Open - Analyzed - Closed - Suspended - Won't Fix">Size</label> 
				<input type="number" name="quantity" min="1" max="9999" value="{$size/}" id="changesize"/>
			</li>
			<li><img src="{$host/}/static/images/ajax-loader.gif" alt="Loading..." style="display: none;" id="pageLoad" />
				<input type="hidden" name="current" value="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;category={$selected_category/}&amp;orderBy={$orderBy/}&amp;dir={$dir/}&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}" id="currentPage"/>
			</li>
		</ul>
	</small>
</h2>
<div class="row">
	{include file="paging_reports.tpl"/}
</div> 
<div class="table table-responsive">
	<table class="table table-bordered" id="table">
		<thead>
			<tr>
				<th>
					{assign name="column" value="number"/}
					{assign name="ldir" value="ASC"/}
				
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"># <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"># <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"># </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="statusID"/}
					{assign name="ldir" value="ASC"/}
					
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if}	
						{unless condition="$view.order_by ~ $column"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> </a>
						{/unless}
				</th>
				<th>
					{assign name="column" value="synopsis"/}
					{assign name="ldir" value="ASC"/}
				
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Synopsis <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Synopsis <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Synopsis </a>
					{/unless}
				</th>
				<th> 
					{assign name="column" value="submissionDate"/}
					{assign name="ldir" value="ASC"/}
				
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Date <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Date <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Date </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="categorySynopsis"/}
					{assign name="ldir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Category <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Category <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/reports?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;{$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Category </a>
					{/unless}
				</th>
			</tr>
		</thead>
		<tbody>
			{foreach from="$reports" item="item"}
				<tr>
					<td itemprop="report_number"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report_interaction" rel="report_interaction">{$item.number/}</a></td>
					<td class="text-center" itemprop="status">
							<a href="{$host/}/reports?category=0&amp;status={$item.status.id/}" rel="filter"><img src="{$host/}/static/images/status_{$item.status.id/}.gif" class="img-rounded" data-original-title="{$item.status.synopsis/}"/></a>
					</td>

					<td itemprop="synopsis">{$item.synopsis/}</td>
					<td itemprop="submission_date">{$item.submission_date_output/}</td>
					<td itemprop="category"> {$item.category.synopsis/}</td> 
				</tr>
			{/foreach}
						
		</tbody>
	</table>
	{include file="paging_reports.tpl"/}
</div>
