<div class="row">
	<div class="col-xs-12">
		<form class="form-inline well" action="{$host/}/report_detail/" id="reports" method="GET" itemprop="search">
			<div class="row">
				<div class="col-xs-2">
					<label class="control-label-api" for="input01" itemprop="report_number" data-original-title="Problem report number you need to see.">View Problem Report #:</label>
				</div>
				<div class="col-xs-1">
					<input type="number" class="form-control form-bug-number-entry" min="1" name="search" placeholder="Report #..." form="reports">
				</div>
				<button type="submit" class="btn btn-default">Go</button>
			</div>
		</form>
	</div>
</div>


<div class="row">
	<div class="col-xs-12">
		{if isset="$user"}
		<form class="form-inline well" action="{$host/}/user_reports/{$user/}" id="search" method="GET" itemprop="search">
		{/if}
		{unless isset="$user"}
		<form class="form-inline well" action="{$host/}/reports" id="search" method="GET" itemprop="search">
		{/unless} 
			<input type="hidden" name="size" value="{$size/}">    
			<div class="row">
				<div class="col-xs-1">
					<label class="control-label-api" for="input01" itemprop="category" data-original-title="The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.">Category</label>
				</div>
				<div class="col-xs-4">
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
				<div class="col-xs-1">
					<label class="control-label-api" for="input01" itemprop="status" data-original-title="The status of a problem can be one of the following: Open - Analyzed - Closed - Suspended - Won't Fix">Status</label>
				</div>
				<div class="col-xs-4">
					<select class="form-control" data-style="btn-primary" name="status" form="search">
						<option value="0">ALL</option>
						{foreach from="$status" item="item"}
							{if condition="$item.is_selected"}
								<option value="{$item.id/}" selected>{$item.synopsis/}</option>
							{/if}
							{unless condition="$item.is_selected"}
								<option value="{$item.id/}">{$item.synopsis/}</option>
							{/unless}
						{/foreach}
					</select>
				</div>
				<div class="col-xs-2">
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
			<li><label class="control-label-api" for="input01" itemprop="size" data-original-title="The status of a problem can be one of the following: Open - Analyzed - Closed - Suspended - Won't Fix">Size</label> 
				<input type="number" name="quantity" min="1" max="9999" value="{$size/}" id="changesize"/>
			</li>
			<li><img src="{$host/}/static/images/ajax-loader.gif" style="display: none;" id="pageLoad" />
				{if isset="$user"}
					<input type="hidden" name="current" value="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" id="currentPage"/>
				{/if}
				{unless isset="$user"}
					<input type="hidden" name="current" value="{$host/}/reports?page={$index/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" id="currentPage"/>
				{/unless}
			</li>
		</ul>
	</small>
</h2>
	<div class="row">
		{include file="paging.tpl"/}
	</div> 
	<div class="table table-responsive">
		<table class="table table-bordered" id="table">
			<thead>
				<tr>
					<th>
						{assign name="column" value="number"/}
						{assign name="dir" value="ASC"/}
					
						{if isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC"># <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC"># <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC"># </a>
							{/unless}
						{/if}
						{unless isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC"># <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC"># <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
								<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC"># </a>
							{/unless}
						{/unless}
					</th>
					<th>
						{assign name="column" value="statusID"/}
						{assign name="dir" value="ASC"/}
						{if isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
								<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> </a>
							{/unless}
						{/if}
						{unless isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
								<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> </a>
							{/unless}
						{/unless}
					</th>
					<th>
						{assign name="column" value="synopsis"/}
						{assign name="dir" value="ASC"/}
						{if isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC">Synopsis <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Synopsis <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
								<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Synopsis </a>
							{/unless}
						{/if}
						{unless isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC">Synopsis <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Synopsis <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
								<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Synopsis </a>
							{/unless}
						{/unless}
					</th>
					<th> 
						{assign name="column" value="submissionDate"/}
						{assign name="dir" value="ASC"/}
						{if isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC">Date <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Date <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
								<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Date </a>
							{/unless}
						{/if}
						{unless isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC">Date <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Date <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
								<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Date </a>
							{/unless}
						{/unless}
					</th>
					<th>
						{assign name="column" value="categorySynopsis"/}
						{assign name="dir" value="ASC"/}
						{if isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC">Category <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Category <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
								<a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Category </a>
							{/unless}
						{/if}
						{unless isset="$user"}
							{if condition="$view.order_by ~ $column"}
								{if condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=DESC">Category <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
								{/if}
								{unless condition="$view.direction ~ $dir"}
									<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Category <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
								{/unless}
							{/if} 
							{unless condition="$view.order_by ~ $column"}
								<a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy={$column/}&dir=ASC">Category </a>
							{/unless}
						{/unless}
					</th>
					<th>Submitter</th>
				</tr>
			</thead>
			<tbody>
				{foreach from="$reports" item="item"}
					<tr>
						<td itemprop="report_number"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report_interaction" rel="report_interaction">{$item.number/}</a></td>
						<td class="text-center" itemprop="status">
							{if isset="$user"}
								<a href="{$host/}/user_reports/{$user/}?category=0&status={$item.status.id/}" rel="filter"><img src="{$host/}/static/images/status_{$item.status.id/}.gif" class="img-rounded" data-original-title="{$item.status.synopsis/}"></a>
							{/if}
							{unless isset="$user"}
								<a href="{$host/}/reports?category=0&status={$item.status.id/}" rel="filter"><img src="{$host/}/static/images/status_{$item.status.id/}.gif" class="img-rounded" data-original-title="{$item.status.synopsis/}"></a>
							{/unless}
						</td>
	
						<td itemprop="synopsis">{$item.synopsis/}</td>
						<td itemprop="submission_date">{$item.submission_date_output/}</td>
						<td itemprop="category"> {$item.category.synopsis/}</td> 
						<td itemprop="contact">{$item.contact.name/}</td>
					</tr>
				{/foreach}
							
			</tbody>
		</table>
		{include file="paging.tpl"/}
		</div>
	</div>
</div>
