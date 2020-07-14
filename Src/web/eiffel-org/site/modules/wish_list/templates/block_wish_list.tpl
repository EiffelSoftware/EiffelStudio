<h1>EiffelStudio tomorrow: wish lists for new developments</h1>
<div class="row">
	<p>
	Eiffel technology continues to develop in many directions. User input is essential. On this part of the eiffel.org site you will find wish lists for different areas of the technology: compiler, wrapping of existing libraries (typically in C), new Eiffel libraries and so on.
	Your contributions are needed! Feel free to add your own dreams of where Eiffel technology should go
	</p>
</div>

{include file="search_by_wish_id.tpl"/}

<div class="row">
      <form action="{$site_url/}{$resource_path/}/{$module_name/}" id="search" method="GET" itemprop="search">
      		<input type="hidden" name="size" value="{$size/}"/>
              <label class="class-form-2 tooltip" itemprop="category" title="The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.">Category</label>
	          <select id="wish_category" class="class-form-4" data-style="btn-primary" name="category" form="search" itemprop="search">
	             <option value="0">ALL</option>
	                {foreach from="$categories" item="item"}
	                  {if condition="$item.is_selected"} 
	                    <option value="{$item.id/}" selected>{htmlentities}{$item.synopsis/}{/htmlentities}</option>
	                  {/if}
	                  {unless condition="$item.is_selected"}
	                    <option value="{$item.id/}">{htmlentities}{$item.synopsis/}{/htmlentities}</option>
	                  {/unless}
	                {/foreach}
	            </select>

		      <label class="class-form-4 tooltip" itemprop="status" title="<small><p>The status of a problem can be one of the following:</p>
                <ul>
                  <li><b>Open</b> The initial state of a Problem Report. This means the PR has been filed and the responsible person(s) notified.</li>
                  <li><b>Analyzed</b> The responsible person has analyzed the problem. The analysis should contain a preliminary evaluation of the problem and an estimate of the amount of time and {$resource_path/} necessary to solve the problem. It should also suggest possible workarounds.</li>
                  <li><b>Closed</b> A Problem Report is closed only when any changes have been integrated, documented, and tested, and the submitter has confirmed the solution </li>
                  <li><b>Suspended</b> Work on the problem has been postponed. This happens if a timely solution is not possible or is not cost-effective at the present time. The PR continues to exist, though a solution is not being actively sought. If the problem cannot be solved at all, it should be closed rather than suspended.</li>
                  <li><b>Won't fix</b> Won't fix problem report.</li>
                </ul></small>">Status
              </label>
      		    <input type="hidden" name="status" value="0" />
              {foreach from="$status" item="item"}
                {if condition="$item.is_selected"}
              <input type="checkbox" id="checkbox-status-{$item.id/}" name="status" value="{$item.id/}" checked/>
                {/if}
                {unless condition="$item.is_selected"}
                  <input type="checkbox" id="checkbox-status-{$item.id/}" name="status" value="{$item.id/}"/>
                {/unless}
              <label class="class-form-2" for="checkbox-status-{$item.id/}">
                <img src="{$site_url/}module/{$module_name/}/files/images/status_{$item.id/}.gif" class="img-rounded tooltip" title="{htmlentities}{$item.synopsis/}{/htmlentities}"/>
              </label>
              {/foreach}
          <label class="class-form-4 tooltip" title="To retrieve wish list items filtered by default synopsis or Content, Descriptions, Interactions Content" itemprop="filter" data-original-title="<p>Filter problem Report</p>">Filter</label>
         {if isset="$filter"}
            <input type="text" name="filter" class="form-control" placeholder="" value="{htmlentities}{$filter/}{/htmlentities}">
          {/if}
          {unless isset="$filter"}
            <input type="text" name="filter" class="form-control" placeholder="">
          {/unless}
          {if isset="$filter_content"}
            <input type="checkbox" id="checkbox-filter-content" name="filter_content" value="1" checked />
          {/if}
          {unless isset="$filter_content"}
            <input type="checkbox" id="checkbox-filter-content" name="filter_content" value="1"/>
          {/unless}
          <label class="checkbox" for="checkbox-filter-content">Content</label>
          <button type="submit" class="btn btn-default">Search</button>
    </form>
  </div>


	<small>
		<div class="row">
			
			<div>
				<input type="hidden" name="pages" id="pages_pe" value="{$pages/}"/>
				<input type="hidden" name="size" id="size_pe" value="{$size/}"/>

				<form action="{$site_url/}{$resource_path/}/{$module_name/}" id="wish_list" method="GET" itemprop="size">
					<input type="hidden" name="page" id="page_pe" value="{$index/}"/>
					<input type="hidden" name="category" id="category_pe" value="{$selected_category/}"/>
					<input type="hidden" name="orderBy" id="orderBy_pe" value="{$orderBy/}"/>
					<input type="hidden" name="dir"  id="dir_pe" value="{$dir/}"/>
					<input type="hidden" name="status" id="status_pe" value="{htmlentities}{$status_query/}{/htmlentities}"/>
					<input type="hidden" name="filter" id="filter_pe" value="{$view.filter/}"/>
					<input type="hidden" name="filter_content" id="filter_content_pe" value="{$view.filter_content/}"/>
						<label class="class-header-form-2 tooltip">List: </label>
						<label class="class-form-4" itemprop="report_number" title="The number of reports you want to see.">Current page {$index/} of {$pages/}
						</label>	
						<label class="class-form-2 tooltip" itemprop="report_number" title="The number of reports you want to see.">Size</label>
						<input type="number" class="class-form-2" min="1" name="size" value="{$size/}"/>
						<button type="submit" class="btn btn-default">Resize</button>
				</form>
			</div>			
		</div>
  </small>		

<div class="row">
	{include file="paging_wish_list.tpl"/}
</div> 
<div class="row">
	<table class="wish_nodes">
		<thead>
			<tr>
				<th>
					{assign name="column" value="wid"/}
					{assign name="ldir" value="ASC"/}
				
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"># <img src="{$site_url/}module/{$module_name/}/files/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"># <img src="{$site_url/}module/{$module_name/}/files/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"># </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="status"/}
					{assign name="ldir" value="ASC"/}
					
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"><img src="{$site_url/}module/{$module_name/}/files/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> <img src="{$site_url/}module/{$module_name/}/files/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"><img src="{$site_url/}module/{$module_name/}/files/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> <img src="{$site_url/}module/{$module_name/}/files/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if}	
						{unless condition="$view.order_by ~ $column"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}"><img src="{$site_url/}module/{$module_name/}/files/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"/> </a>
						{/unless}
				</th>
				<th>
					{assign name="column" value="synopsis"/}
					{assign name="ldir" value="ASC"/}
				
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Synopsis <img src="{$site_url/}module/{$module_name/}/files/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Synopsis <img src="{$site_url/}module/{$module_name/}/files/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Synopsis </a>
					{/unless}
				</th>
				<th> 
					{assign name="column" value="changed"/}
					{assign name="ldir" value="ASC"/}
				
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Date <img src="{$site_url/}module/{$module_name/}/files/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Date <img src="{$site_url/}module/{$module_name/}/files/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Date </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="category"/}
					{assign name="ldir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Category <img src="{$site_url/}module/{$module_name/}/files/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Category <img src="{$site_url/}module/{$module_name/}/files/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Category </a>
					{/unless}
				</th>
				<th>
					{assign name="column" value="votes"/}
					{assign name="ldir" value="ASC"/}
					{if condition="$view.order_by ~ $column"}
						{if condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=DESC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Votes <img src="{$site_url/}module/{$module_name/}/files/images/up.gif" class="img-rounded"/></a>
						{/if}
						{unless condition="$view.direction ~ $ldir"}
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Votes <img src="{$site_url/}module/{$module_name/}/files/images/down.gif" class="img-rounded"/></a>
						{/unless}
					{/if} 
					{unless condition="$view.order_by ~ $column"}
						<a href="{$site_url/}{$resource_path/}/{$module_name/}?page={$index/}&amp;size={$size/}&amp;orderBy={$column/}&amp;dir=ASC&amp;status={$status_query/}&amp;filter={$view.filter/}&amp;filter_content={$view.filter_content/}">Votes </a>
					{/unless}
				</th>
			</tr>
		</thead>
		<tbody>
			{foreach from="$wish_list" item="item"}
				<tr>
					<td itemprop="report_number"><a href="{$site_url/}{$resource_path/}/{$module_item/}/{$item.id/}/detail" itemprop="report_interaction" rel="report_interaction">{$item.id/}</a></td>
					<td class="text-center tooltip" itemprop="status">
							<a href="{$site_url/}{$resource_path/}/{$module_name/}?category=0&amp;status={$item.status.id/}" rel="filter"><img src="{$site_url/}module/{$module_name/}/files/images/status_{$item.status.id/}.gif" class="img-rounded" title="{$item.status.synopsis/}"/></a>
					</td>

					<td itemprop="synopsis"><a href="{$site_url/}{$resource_path/}/{$module_item/}/{$item.id/}/detail" itemprop="report_interaction" rel="report_interaction">{htmlentities}{$item.synopsis/}{/htmlentities}</a></td>
					<td itemprop="submission_date">{$item.submission_date_output/}</td>
					<td itemprop="category"> {$item.category.synopsis/}</td> 
					<td itemprop="category"> {$item.votes/}</td> 
				</tr>
			{/foreach}
						
		</tbody>
	</table>
	<div class="row">
		{include file="paging_wish_list.tpl"/}
	</div>
		
	{if isset="$user"}
		<div class="btn-add-wish">
			<a href="{$host/}{$resource_path/}/{$module_item/}/form" itemprop="create-wish-form" rel="create-wish-form">Add {$module_item/}</a>
		</div>
	{/if}

</div>
