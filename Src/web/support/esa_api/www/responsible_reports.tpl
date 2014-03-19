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
     <form  class="form-inline well" action="{$host/}/reports" id="search" method="GET">
      <div class="col-md-4">
         <label class="control-label" for="input01">Category</label>
         <select class="form-control"  data-style="btn-primary" name="category" form="search">
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
     <div class="col-md-4">
       <label class="control-label" for="input01">Priority</label>
       <select class="form-control"  data-style="btn-primary" name="priority" form="search">
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
     <div class="col-md-4">
       <label class="control-label" for="input01">Responsibles</label>
       <select class="form-control"  data-style="btn-primary" name="responsible" form="search">
        <option value="0">ALL</option>
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
     <div class="col-md-4">
       <label class="control-label" for="input01">Severity</label>
       <select class="form-control" data-style="btn-primary" name="severity" form="search">
        <option value="0">ALL</option>
        {foreach from="$severities" item="item"}
          {if condition="$item.id = $view.selected_severity"}
            <option value="{$item.id/}" selected>{$item.synopsis/}</option>
          {/if}
          {unless condition="$item.id = $view.selected_severity"}
            <option value="{$item.id/}">{$item.synopsis/}</option>
          {/unless}
        {/foreach}  
      </select>
     </div>
     <div class="col-md-4">
       <label class="control-label" for="input01" title="To retrieve problem reports using the submitter's username: enter the username">Submitter</label>
            <input type="text"  name="submitter" class="form-control" placeholder="John.H">
      </div>  
  
    <div class="row">
       <div class="col-md-4">
       <label class="control-label" for="input01">Status</label>
       <div>
        {foreach from="$status" item="item"}
              {if condition="$item.is_selected"}
                   <input type="checkbox" name="status" value="{$item.id/}" checked />{$item.synopsis/} <br />
              {/if}
              {unless condition="$item.is_selected"}
                           <input type="checkbox" name="status" value="{$item.id/}"/>{$item.synopsis/} <br />
              {/unless}
          {/foreach}
        </div> 
       </div>
    </div>

      <button type="submit" class="btn btn-default">Search</button>


   </form>
  </div>  
</div>

<h2 class="sub-header">Problem Reports</h2>
          <div class="table-responsive">
            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th># <br>
                        <a href="{$host/}/reports/{$index/}?orderBy=number&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports/{$index/}?orderBy=number&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  <th>Status
                        <br>
                        <a href="{$host/}/reports/{$index/}?orderBy=statusID&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports/{$index/}?orderBy=statusID&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a> 
                  </th>
                  <th>Priority
                        <br>
                        <a href="{$host/}/reports/{$index/}?orderBy=priorityID&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports/{$index/}?orderBy=priorityID&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a> 
                  </th>
                  <th>Severity
                        <br>
                        <a href="{$host/}/reports/{$index/}?orderBy=severityID&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports/{$index/}?orderBy=severityID&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a> 
                  </th>
                  <th>Synopsis
                        <br>
                        <a href="{$host/}/reports/{$index/}?orderBy=synopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports/{$index/}?orderBy=synopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  <th>Submitter
                        <br>
                        <a href="{$host/}/reports/{$index/}?orderBy=synopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports/{$index/}?orderBy=synopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  
                  <th>Date
                        <br>
                        <a href="{$host/}/reports/{$index/}?orderBy=submissionDate&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports/{$index/}?orderBy=submissionDate&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  <th>Responsible
                      <br>
                  </th>
                  <th>Category
                        <br> 
                        <a href="{$host/}/reports/{$index/}?orderBy=categorySynopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports/{$index/}?orderBy=categorySynopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  <th>Release
                        <br>
                        <a href="{$host/}/reports/{$index/}?orderBy=categorySynopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports/{$index/}?orderBy=categorySynopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                </tr>
              </thead>
              <tbody>

               {foreach from="$reports" item="item"}
                 <form  class="form-inline well" action="{$host/}/report_detail/" id="reports" method="POST">
                  <tr>
                      
                       <td><a href="{$host/}/report_detail/{$item.number/}">{$item.number/}</a></td>
                       <td>{$item.status.synopsis/}</td>
                       <td>{$item.priority.id/}</td>
                       <td>{$item.severity.id/}</td>
                       <td>{$item.synopsis/}</td>
                       <td>{$item.contact.name/}</td>
                       <td>{$item.submission_date/}</td>
                       <td>
                           <select class="form-control" data-style="btn-primary" name="status" form="search">
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
                       <td>{$item.category.synopsis/}</td>
                       <td>{$item.release/}</td>
                       <td><button type="submit" class="btn btn-default">Update</button></td>

                  </tr>
                <form>    
              {/foreach}
              
              </tbody>
            </table>
      
           <div class="col-lg-12">
                <ul class="pager">
                  <li><a href="{$host/}/reports?category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}">First</a></li>
                  {if isset="$prev"}
                    <li><a href="{$host/}/reports/{$prev/}?category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}">Previous</a></li>
                  {/if}
                  {if isset="$next"}
                  <li><a href="{$host/}/reports/{$next/}?category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}">Next</a></li>
                  {/if}
                  <li><a href="{$host/}/reports/{$last/}?category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}">Last</a></li>
                </ul>
          </div>
       </div>

</div>