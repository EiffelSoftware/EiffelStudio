<div class="row">
   <div class="col-lg-8">
     <form  class="form-inline well" action="{$host/}/report_detail/" id="reports" method="GET">
        <input type="search" class="form-control" name="search" placeholder="Search by Report #..." form="reports">
         <button type="submit" class="btn btn-default">View Problem Report</button>
     </form>
  </div>  
</div>



<div class="row">
   <div class="col-lg-8">
    {if isset="$user"}
     <form  class="form-inline well" action="{$host/}/user_reports/{$user/}" id="search" method="GET">
    {/if}
    {unless isset="$user"}
     <form  class="form-inline well" action="{$host/}/reports" id="search" method="GET">
    {/unless} 
      <div class="col-md-4">
       <label class="control-label" for="input01">Category</label>
       <select class="form-control"  data-style="btn-primary" name="category" form="search">
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
       <label class="control-label" for="input01">Status</label>
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
                       <td><a href="{$host/}/report_detail/{$item.number/}">{$item.number/}</a></td>
                       <td>{$item.status.synopsis/}</td>
                       <td>{$item.synopsis/}</td>
                       <td>{$item.submission_date/}</td>
                       <td>{$item.category.synopsis/}</td>
                </tr>
              {/foreach}
              
              </tbody>
            </table>
      
           <div class="col-lg-12">
                <ul class="pager">
                <li><a href="{$host/}/reports?category={$selected_category/}&status={$selected_status/}">First</a></li>
                <li><a href="{$host/}/reports/{$prev/}?category={$selected_category/}&status={$selected_status/}">Previous</a></li>
                <li><a href="{$host/}/reports/{$next/}?category={$selected_category/}&status={$selected_status/}">Next</a></li>
                <li><a href="{$host/}/reports/{$last/}?category={$selected_category/}&status={$selected_status/}">Last</a></li>
              </ul>
          </div>
       </div>

</div>