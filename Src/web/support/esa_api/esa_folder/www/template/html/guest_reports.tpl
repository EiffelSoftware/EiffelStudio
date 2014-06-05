
<div class="row">
   <div class="col-lg-8">
     <form  class="form-inline well" action="{$host/}/report_detail/" id="reports" method="GET" itemprop="search">
        <input type="search" class="form-control" name="search" placeholder="Search by Report #..." form="reports">
         <button type="submit" class="btn btn-default">View Problem Report</button>
     </form>
  </div>  
</div>


<div class="row">
   <div class="col-lg-12">
    {if isset="$user"}
     <form  class="form-inline well" action="{$host/}/user_reports/{$user/}" id="search" method="GET" itemprop="search">
    {/if}
    {unless isset="$user"}
     <form  class="form-inline well" action="{$host/}/reports" id="search" method="GET" itemprop="search">
    {/unless} 
      <div class="col-md-4">
       <label class="control-label" for="input01" itemprop="category" data-original-title="The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.">Category</label>
       <select class="form-control"  data-style="btn-primary" name="category" form="search" itemprop="search">
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
     <div class="col-md-4">
       <label class="control-label" for="input01" itemprop="status"  data-original-title="The status of a problem can be one of the following: Open - Analyzed - Closed - Suspended - Won't Fix">Status</label>
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
         <button type="submit" class="btn btn-default">Search</button>
   </form>
  </div>  
</div>

<h2 class="sub-header">Problem Reports</h2>
          <div class="table-responsive">
            <table class="table table-bordered">
              <thead>
                <tr>
                  <th>#
                     {if isset="$user"}
                       <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=number&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                       <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=number&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                     {/if}
                     {unless isset="$user"}
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=number&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=number&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                     {/unless}
                  </th>
                  <th>Status
                     {if isset="$user"}
                        <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=statusID&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=statusID&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                     {/if}
                     {unless isset="$user"}
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=statusID&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=statusID&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                     {/unless}   
                  </th>
                  <th>Synopsis
                      {if isset="$user"}
                        <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=synopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=synopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                      {/if}
                      {unless isset="$user"}
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=synopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=synopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                      {/unless}  
                  </th>
                  <th>Date
                      {if isset="$user"}
                        <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=synopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=synopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                      {/if}
                      {unless isset="$user"}
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=submissionDate&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=submissionDate&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                      {/unless}
                  </th>
                  <th>Category
                      {if isset="$user"}
                        <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=categorySynopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&orderBy=categorySynopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                      {/if}
                      {unless isset="$user"}
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=categorySynopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=categorySynopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                      {/unless}  
                  </th>
                </tr>
              </thead>
              <tbody>

               {foreach from="$reports" item="item"}
                  <tr>
                       <td itemprop="report_number"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report_interaction" rel="report-interaction">{$item.number/}</a></td>
                       <td itemprop="status">{$item.status.id/}</td>
                       <td itemprop="synopsis">{$item.synopsis/}</td>
                       <td itemprop="submission_date">{$item.submission_date/}</td>
                       <td itemprop="category">{$item.category.synopsis/}</td>
                </tr>
              {/foreach}
              
              </tbody>
            </table>
      
           <div class="col-lg-12">
                <ul class="pager">
                  {if isset="$user"}
                    <li><a href="{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" itemprop="first" rel="first">First</a></li>
                    {if isset="$prev"}
                      <li><a href="{$host/}/user_reports/{$user/}?page={$prev/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" itemprop="previous" rel="previous">Previous</a></li>
                    {/if}
                    {if isset="$next"}
                    <li><a href="{$host/}/user_reports/{$user/}?page={$next/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}"  itemprop="next" rel="next">Next</a></li>
                    {/if}
                    <li><a href="{$host/}/user_reports/{$user/}?page={$last/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}"  itemprop="last" rel="last">Last</a></li>
                  {/if}
                  {unless isset="$user"}
                    <li><a href="{$host/}/reports?page={$index/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" itemprop="first" rel="first">First</a></li>
                    {if isset="$prev"}
                      <li><a href="{$host/}/reports?page={$prev/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" itemprop="previous" rel="previous">Previous</a></li>
                    {/if}
                    {if isset="$next"}
                    <li><a href="{$host/}/reports?page={$next/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" itemprop="next" rel="next">Next</a></li>
                    {/if}
                    <li><a href="{$host/}/reports?page={$last/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" itemprop="last" rel="last">Last</a></li>
                  {/unless}
                </ul>
          </div>
       </div>

  </div>
</div>