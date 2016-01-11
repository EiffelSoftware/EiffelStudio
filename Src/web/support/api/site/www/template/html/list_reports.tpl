<h2 class="sub-header">Problem Reports</h2>
<div class="table-responsive">
	<table class="table table-striped">
		<thead>
			<tr>
				<th>#</th>
				<th>Status</th>
				<th>Synopsis</th>
				<th>Date</th>
				<th>Category</th>
			</tr>
		</thead>
		<tbody>
			{foreach from="$reports" item="item"}
				<tr>
					<td itemprop="report_number">{$item.number/}</td>
					<td itemprop="status">{$item.status.id/}</td>
					<td itemprop="synopsis">{htmlentities}{$item.synopsis/}{/htmlentities}</td>
					<td itemprop="submission_date">{$item.submission_date/}</td>
					<td itemprop="catgeory">{$item.category.synopsis/}</td>
				</tr>
			{/foreach}

		</tbody>
	</table>

	<div class="col-xs-12">
		<ul class="pager">
			<li><a href="#" rel="previous">Previous</a></li>
			<li><a href="#" rel="next">Next</a></li>
		</ul>
	</div>
</div>
