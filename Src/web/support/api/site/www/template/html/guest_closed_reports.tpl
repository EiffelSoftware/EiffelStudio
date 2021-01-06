<h2 class="sub-header">Recently Closed Problem Reports: 
	<small>
		<div class="row" id="guest_closed_reports_page_size">
			<div class="col-xs-12">
				<input type="hidden" name="pages" id="pages_pe" value="{$pages/}"/>
				<input type="hidden" name="size" id="size_pe" value="{$size/}"/>

				<form class="form-inline" action="{$host/}/closed_reports" id="reports" method="GET" itemprop="size">
					<input type="hidden" name="page" id="page_pe" value="{$index/}"/>
				
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="report_number" data-original-title="The number of closed_reports you want to see.">Current page {$index/} of {$pages/}
							</label>	
						</div>
						<div class="col-xs-2">
							<label class="control-label-api" itemprop="report_number" data-original-title="The number of closed_reports you want to see.">Size</label>
						</div>
						<div class="col-xs-1">
							<input type="number" class="form-control form-bug-number-entry" min="1" name="size" value="{$size/}"/>
						</div>
						<div class="col-xs-1">
							<button type="submit" class="btn btn-default">Resize</button>
						</div>
						<div class="col-xs-1">
							<label class="control-label-api" itemprop="count_bugs" data-original-title="Total number of bugs closed_reports"># of Bugs</label>
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
	{include file="paging_closed_reports.tpl"/}
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
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}"># <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}"># <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}"># </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="statusID"/}
					{assign name="ldir" value="ASC"/}
					
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if}	
						{unless condition="$view.order_by ~ $column"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> </a>
						{/unless}
				</th>
				<th>
					{assign name="column" value="synopsis"/}
					{assign name="ldir" value="ASC"/}
				
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}">Synopsis <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}">Synopsis <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}">Synopsis </a>
					{/unless}
				</th>
				<th> 
					{assign name="column" value="submissionDate"/}
					
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}">Date <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}">Date <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}">Date </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="categorySynopsis"/}
					{assign name="ldir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}">Category <img src="{$host/}/static/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}">Category <img src="{$host/}/static/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$host/}/closed_reports?page={$index/}&amp;size={$size/}">Category </a>
					{/unless}
				</th>
			</tr>
		</thead>
		<tbody>
			{foreach from="$reports" item="item"}
				<tr>
					<td itemprop="report_number"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report_interaction" rel="report_interaction">{$item.number/}</a></td>
					<td class="text-center" itemprop="status">
							<a href="{$host/}/closed_reports?category=0&amp;status={$item.status.id/}" rel="filter"><img src="{$host/}/static/images/status_{$item.status.id/}.gif" class="img-rounded" data-original-title="{$item.status.synopsis/}"/></a>
					</td>

					<td itemprop="synopsis"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report_interaction" rel="report_interaction">{htmlentities}{$item.synopsis/}{/htmlentities}</a></td>
					<td itemprop="submission_date">{$item.submission_date_output/}</td>
					<td itemprop="category"> {$item.category.synopsis/}</td> 
				</tr>
			{/foreach}
						
		</tbody>
	</table>
	{include file="paging_closed_reports.tpl"/}
</div>
