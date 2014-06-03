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
     <form  class="form-inline well" action="{$host/}/reports" id="search" method="GET" itemprop="search">
      <div class="col-md-4">
         <label class="control-label" for="input01" itemprop="category">Category</label>
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
       <label class="control-label" for="input01" itemprop="priority">Priority</label>
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
       <label class="control-label" for="input01" itemprop="responsible">Responsibles</label>
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
       <label class="control-label" for="input01" itemprop="severity">Severity</label>
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
       <label class="control-label" for="input01" title="To retrieve problem reports using the submitter's username: enter the username" itemprop="submitter">Submitter</label>
            <input type="text"  name="submitter" class="form-control" placeholder="John.H">
      </div>  
  
    <div class="row">
       <div class="col-md-4">
       <label class="control-label" for="input01" itemprop="status">Status</label>
       <div>
        <input type="hidden" name="status" value="0">
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
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=number&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=number&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  <th>Status
                        <br>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=statusID&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=statusID&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a> 
                  </th>
                  <th>Priority
                        <br>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=priorityID&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=priorityID&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a> 
                  </th>
                  <th>Severity
                        <br>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=severityID&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=severityID&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a> 
                  </th>
                  <th>Synopsis
                        <br>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=synopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=synopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  <th>Submitter
                        <br>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=username&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=username&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  
                  <th>Date
                        <br>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=submissionDate&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=submissionDate&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  <th>Responsible
                      <br>
                  </th>
                  <th>Category
                        <br> 
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=categorySynopsis&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=categorySynopsis&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                  <th>Release
                        <br>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=release&dir=ASC"><span class="glyphicon glyphicon-arrow-up"/></a>
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&orderBy=release&dir=DESC"><span class="glyphicon glyphicon-arrow-down"/></a>
                  </th>
                </tr>
              </thead>
              <tbody>

               {foreach from="$reports" item="item"}
                 <form  class="form-inline well" action="{$host/}/reports/{$item.number/}" id="reports_{$item.number/}" method="POST" itemprop="update">
                   <input type="hidden" name="page" value="{$index/}"/>
                   <input type="hidden" name="category" value="{$view.selected_category/}"/>
                   <input type="hidden" name="severity" value="{$view.selected_severity/}"/>
                   <input type="hidden" name="priority" value="{$view.selected_priority/}"/>
                   <input type="hidden" name="responsible" value="{$view.selected_responsible/}"/>
                   <input type="hidden" name="status_query" value="{$status_query/}"/>
                   <input type="hidden" name="orderBy" value="{$view.orderBy/}"/>
                   <input type="hidden" name="dir" value="{$view.dir/}"/>

                  <tr>
                       <td itemprop="report-number"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report-interaction" rel="report-interaction">{$item.number/}</a></td>
                       <td itemprop="status">{$item.status.id/}</td>
                       <td itemprop="priority">{$item.priority.id/}</td>
                       <td itemprop="severity">{$item.severity.id/}</td>
                       <td itemprop="synopsis">{$item.synopsis/}</td>
                       <td itemprop="submitter">{$item.contact.name/}</td>
                       <td itemprop="submission date">{$item.submission_date/}</td>
                       <td itemprop="responsible">
                           <select class="form-control" data-style="btn-primary"  for="input_{$item.number/}" name="user_responsible" form="reports_{$item.number/}">
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
      
           <div class="col-lg-12">
                <ul class="pager">
                  <li><a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}" itemprop="first" rel="first">First</a></li>
                  {if isset="$prev"}
                    <li><a href="{$host/}/reports?page={$prev/}&size={$size/}&category={$view.selected_category/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}" itemprop="previous" rel="previous">Previous</a></li>
                  {/if}
                  {if isset="$next"}
                  <li><a href="{$host/}/reports?page={$next/}&size={$size/}&category={$view.selected_category/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}" itemprop="next" rel="next">Next</a></li>
                  {/if}
                  <li><a href="{$host/}/reports?page={$last/}&size={$size/}&category={$view.selected_category/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}" itemprop="last" rel="last">Last</a></li>
                </ul>
          </div>
       </div>

</div>