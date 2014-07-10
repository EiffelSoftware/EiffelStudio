
<div class="row">
   <div class="col-sm-12">
     <form  class="form-inline well" action="{$host/}/report_detail/" id="reports" method="GET" itemprop="search">
        <input type="number" class="form-control" min="1" name="search" placeholder="Search by Report #..." form="reports">
         <button type="submit" class="btn btn-default">View Problem Report</button>
     </form>
  </div>  
</div>



<div class="row">
   <div class="col-sm-12">
     {if isset="$user"}
        <form  class="form-inline well" action="{$host/}/reports" id="search" method="GET" itemprop="search">
      {/if}    
        <div class="row">
          <div class="col-sm-12">
            <div class="row">
       
             <div class="col-sm-4">
                 <label class="control-label-api" for="input01" itemprop="category" data-original-title="<p>The name of the product, component or concept where the problem lies. In order to get the best possible support, please select the category carefully.</p>">Category</label>
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

             <div class="col-sm-4">
             <label class="control-label-api" for="input01" title="To retrieve problem reports using the submitter's username: enter the username" itemprop="submitter" data-original-title="<p>Person reporting a problem</p>">Submitter</label>
                  {if isset="$submitter"}
                    <input type="text"  name="submitter" class="form-control" placeholder="John.H" value="{$submitter/}">
                  {/if}
                  {unless isset="$submitter"}
                    <input type="text"  name="submitter" class="form-control" placeholder="John.H">
                  {/unless}
            </div>
          </div>
         </div> 
        </div> 
      <div class="row">
          <div class="col-sm-12">
            <div class="row">
             
             <div class="col-sm-4">
              <label class="control-label-api" for="input01" itemprop="priority"  data-original-title="<small><p>How soon the solution is required. Accepted values include:</p>
                  <UL>
                  <LI><B>High</B>: A solution is needed as soon as possible.</LI>
                  <LI><B>Medium</B>: The problem should be solved in the next release.</LI>
                  <LI><B>Low</B>: The problem should be solved in a future release.</LI>
                  </UL></small>">Priority</label>
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

           <div class="col-sm-4">
             <label class="control-label-api" for="input01" itemprop="responsible" data-original-title="<p>Person having an obligation to do analized a given report problem.</p>">Responsibles</label>
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
          
          </div>
        </div>
      </div>    

     
      <div class="row">
          <div class="col-sm-12">
            <div class="row"> 
             <div class="col-sm-4">
               <label class="control-label-api" for="input01" itemprop="severity" data-original-title="<small><p>The severity of the problem. Accepted values include:</p>
                        <UL>
                          <LI><B>Critical</B>: The product, component or concept is completely non operational. No workaround is known.</LI>
                          <LI><B>Serious</B>: The product, component or concept is not working properly. Problems that would otherwise be considered critical are rated serious when a workaround is known.</LI>
                          <LI><B>Non-critical</B>: The product, component or concept is working in general, but lacks features, has irritating behavior, does something wrong, or doesn't match its documentation.</LI>
                        </UL></small>
         ">Severity</label>
               <select class="form-control" data-style="btn-primary" name="severity" form="search">
                <option value="0">ALL</option>
                {foreach from="$severities" item="item"}
                  {if condition="$item.id = $view.selected_severity"}
                    <option value="{$item.id/}" selected>  {$item.synopsis/}</option>
                  {/if}
                  {unless condition="$item.id = $view.selected_severity"}
                    <option value="{$item.id/}"> {$item.synopsis/} </option>
                  {/unless}
                {/foreach}  
              </select>
          </div>
          <div class="col-sm-8">
             <label class="control-label-api" for="input01" itemprop="status" data-original-title="<small><p>The status of a problem can be one of the following:</p>
            <ul>
              <li><b>Open</b>  The initial state of a Problem Report. This means the PR has been filed and the responsible person(s) notified.</li>
              <li><b>Analyzed</b>  The responsible person has analyzed the problem. The analysis should contain a preliminary evaluation of the problem and an estimate of the amount of time and resources necessary to solve the problem. It should also suggest possible workarounds.</li>
              <li><b>Closed</b> A Problem Report is closed only when any changes have been integrated, documented, and tested, and the submitter has confirmed the solution </li>
              <li><b>Suspended</b> Work on the problem has been postponed. This happens if a timely solution is not possible or is not cost-effective at the present time. The PR continues to exist, though a solution is not being actively sought. If the problem cannot be solved at all, it should be closed rather than suspended.</li>
              <li><b>Won't fix</b> Won't fix problem report.</li>
            </ul></small>">Status</label>
              <input type="hidden" name="status" value="0">
              {foreach from="$status" item="item"}
                    {if condition="$item.is_selected"}
                      <label class="checkbox inline" for="checkboxes-{$item.id/}">
                         <input type="checkbox" name="status" value="{$item.id/}" checked /><img src="{$host/}/static/images/status_{$item.id/}.gif" class="img-rounded" data-original-title="{$item.synopsis/}" > 
                      </label>    
                    {/if}
                    {unless condition="$item.is_selected"}
                              <label class="checkbox inline" for="checkboxes-{$item.id/}">
                                 <input type="checkbox" name="status" value="{$item.id/}"/><img src="{$host/}/static/images/status_{$item.id/}.gif" class="img-rounded" data-original-title="{$item.synopsis/}"  >
                              </label>
                    {/unless}
                {/foreach}
             </div>
     

        </div>
       </div>
      </div> 

      <div class="row">
          <div class="col-sm-12">
            <div class="row"> 
             <div class="col-sm-12">
             <label class="control-label-api" for="input01" title="To retrieve problem reports filtered by synopsis or description" itemprop="filter" data-original-title="<p>Filter problem Report</p>">Filter</label>
                  {if isset="$filter"}
                    <input type="text"  name="filter" class="form-control" placeholder="Filter" value="{$filter/}">
                  {/if}
                  {unless isset="$filter"}
                    <input type="text"  name="filter" class="form-control" placeholder="Filter">
                  {/unless}

                  {if isset="$filter_synopsis"}
                      <label class="checkbox inline" for="checkboxes-synopsis">
                         <input type="checkbox" name="filter_synopsis" value="1" checked /> Synopsis 
                      </label>    
                  {/if}
                  {unless isset="$filter_synopsis"}
                      <label class="checkbox inline" for="checkboxes-synopsis">
                         <input type="checkbox" name="filter_synopsis" value="1"/> Synopsis 
                      </label>    
                  {/unless}
                  {if isset="$filter_description"}
                      <label class="checkbox inline" for="checkboxes-description">
                         <input type="checkbox" name="filter_description" value="1" checked /> Description 
                      </label>    
                  {/if}
                  {unless isset="$filter_description"}
                      <label class="checkbox inline" for="checkboxes-description">
                         <input type="checkbox" name="filter_description" value="1"/> Description 
                      </label>    
                  {/unless}
            </div>
 

        </div>
       </div>
      </div>   
       <div class="row">
          <div class="col-sm-12">
            <div class="row"> 
             <div class="col-sm-4">
              <button type="submit" class="btn btn-default">Search</button>
             </div>
            </div>
          </div>
       </div>        

   </form>
  </div>  
</div>

   <h2 class="sub-header">Problem Reports
            <small>
              <ul class="pagination">
               <li class="info">Current page {$index/} of {$pages/} - </li>
               <li><label class="control-label" for="input01" itemprop="size"  data-original-title="The status of a problem can be one of the following: Open - Analyzed - Closed - Suspended - Won't Fix">Size</label> 
                <input type="number" name="quantity" min="1" max="9999" value="{$size/}" id="changesize"> </li> <img src="{$host/}/static/images/ajax-loader.gif" style="display: none;" id="pageLoad" />
                <input type="hidden" name="current" value="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}" id="currentPage">
               </ul>
           </small>  
   </h2>
         <div class="row">
           <div class="col-lg-12">
                <ul class="pager">
                  <li><a href="{$host/}/reports?page=1&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}" itemprop="first" rel="first">First</a></li>
                  {if isset="$prev"}
                    <li><a href="{$host/}/reports?page={$prev/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}" itemprop="previous" rel="previous">Previous</a></li>
                  {/if}
                  {if isset="$next"}
                  <li><a href="{$host/}/reports?page={$next/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}" itemprop="next" rel="next">Next</a></li>
                  {/if}
                  <li><a href="{$host/}/reports?page={$last/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}" itemprop="last" rel="last">Last</a></li>
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
                                  <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}"># <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
                            {/if}
                            {unless condition="$view.direction ~ $dir"}
                                 <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}"># <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
                            {/unless}

                       {/if} 
                       {unless condition="$view.order_by ~ $column"}
                             <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}"># </a>
                       {/unless}       
                  </th>
                  <th>
                       {assign name="column" value="statusID"/}
                       {assign name="dir" value="ASC"/}
                       {if condition="$view.order_by ~ $column"}
                            {if condition="$view.direction ~ $dir"}
                                 <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                                  <img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
                            {/if}
                            {unless condition="$view.direction ~ $dir"}
                             <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                                <img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
                            {/unless}

                       {/if} 
                       {unless condition="$view.order_by ~ $column"}

                               <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                               <img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> </a>
                       {/unless}       
        
                  </th>
                  <th>
                       {assign name="column" value="priorityID"/}
                       {assign name="dir" value="ASC"/}
                       {if condition="$view.order_by ~ $column"}
                            {if condition="$view.direction ~ $dir"}
                                  <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">  
                                  <img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
                            {/if}
                            {unless condition="$view.direction ~ $dir"}
                                 <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}"><img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
                            {/unless}

                       {/if} 
                       {unless condition="$view.order_by ~ $column"}
                             <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                            <img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> </a>
                       {/unless}       
                  </th>
                  <th>
                       {assign name="column" value="severityID"/}
                       {assign name="dir" value="ASC"/}
                       {if condition="$view.order_by ~ $column"}
                            {if condition="$view.direction ~ $dir"}
                               <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                               <img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
                            {/if}
                            {unless condition="$view.direction ~ $dir"}
                             <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                                <img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
                            {/unless}

                       {/if} 
                       {unless condition="$view.order_by ~ $column"}
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                            <img src="{$host/}/static/images/grid_header.gif" class="img-rounded" alt="{$item.status.synopsis/}"> </a>
                       {/unless}
                  </th>
                  <th>
                       {assign name="column" value="synopsis"/}
                       {assign name="dir" value="ASC"/}
                       {if condition="$view.order_by ~ $column"}
                            {if condition="$view.direction ~ $dir"}
                                  <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                                 Synopsis <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
                            {/if}
                            {unless condition="$view.direction ~ $dir"}
                                 <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                                Synopsis <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
                            {/unless}

                       {/if} 
                       {unless condition="$view.order_by ~ $column"}
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                            Synopsis </a>
                       {/unless}       
                  </th>
                  <th>
                       {assign name="column" value="username"/}
                       {assign name="dir" value="ASC"/}
                       {if condition="$view.order_by ~ $column"}
                            {if condition="$view.direction ~ $dir"}
                                  <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">      
                                 Submitter <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
                            {/if}
                            {unless condition="$view.direction ~ $dir"}
                             <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                                Submitter <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
                            {/unless}

                       {/if} 
                       {unless condition="$view.order_by ~ $column"}
                             <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                            Submitter </a>
                       {/unless}                    
                  </th>
                  
                  <th>
                       {assign name="column" value="submissionDate"/}
                       {assign name="dir" value="ASC"/}
                       {if condition="$view.order_by ~ $column"}
                            {if condition="$view.direction ~ $dir"}
                             <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                                 Date <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>                            {/if}
                            {unless condition="$view.direction ~ $dir"}
                             <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                                Date <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
                            {/unless}

                       {/if} 
                       {unless condition="$view.order_by ~ $column"}
                        <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">Date </a>
                       {/unless}

                  </th>
                  <th>Responsible
                      <br>
                  </th>
                  <th>
                       {assign name="column" value="categorySynopsis"/}
                       {assign name="dir" value="ASC"/}
                       {if condition="$view.order_by ~ $column"}
                            {if condition="$view.direction ~ $dir"}
                                 <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">
                                 Category <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
                            {/if}
                            {unless condition="$view.direction ~ $dir"}
                            <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">                                Category <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
                            {/unless}

                       {/if} 
                       {unless condition="$view.order_by ~ $column"}

                            <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">Category </a>
                       {/unless}
                  </th>
                  <th>
                       {assign name="column" value="release"/}
                       {assign name="dir" value="ASC"/}
                       {if condition="$view.order_by ~ $column"}
                            {if condition="$view.direction ~ $dir"}

                            <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=DESC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">Release <img src="{$host/}/static/images/up.gif" class="img-rounded"></a>
                            {/if}
                            {unless condition="$view.direction ~ $dir"}
                            <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}"> Release <img src="{$host/}/static/images/down.gif" class="img-rounded"></a>
                            {/unless}

                       {/if} 
                       {unless condition="$view.order_by ~ $column"}
                            <a href="{$host/}/reports?page={$index/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$column/}&dir=ASC&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}">Release </a>
                       {/unless}
 
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
                       <td itemprop="report_number"><a href="{$host/}/report_detail/{$item.number/}" itemprop="report-interaction" rel="report-interaction">{$item.number/}</a></td>
                       <td  class="text-center" itemprop="status"><img src="{$host/}/static/images/status_{$item.status.id/}.gif" class="img-rounded"  data-original-title="{$item.status.synopsis/}"></td>
                       <td  class="text-center" itemprop="priority"><img src="{$host/}/static/images/priority_{$item.priority.synopsis/}.gif" class="img-rounded" data-original-title="{$item.priority.synopsis/}"></td>
                       <td  class="text-center" itemprop="severity"><img src="{$host/}/static/images/severity_{$item.severity.synopsis/}.gif" class="img-rounded" data-original-title="{$item.severity.synopsis/}"></td>
                       <td itemprop="synopsis">{$item.synopsis/}</td>
                       <td itemprop="submitter">{$item.contact.name/}</td>
                       <td itemprop="submission_date">{$item.submission_date_output/}</td>
                       <td itemprop="responsible">
                           <select class="selectpicker"  for="input_{$item.number/}" name="user_responsible" form="reports_{$item.number/}">
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
                  <li><a href="{$host/}/reports?page=1&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}" itemprop="first" rel="first">First</a></li>
                  {if isset="$prev"}
                    <li><a href="{$host/}/reports?page={$prev/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}" itemprop="previous" rel="previous">Previous</a></li>
                  {/if}
                  {if isset="$next"}
                  <li><a href="{$host/}/reports?page={$next/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}" itemprop="next" rel="next">Next</a></li>
                  {/if}
                  <li><a href="{$host/}/reports?page={$last/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&{$status_query/}orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_synopsis={$view.filter_synopsis/}&filter_description={$view.filter_description/}" itemprop="last" rel="last">Last</a></li>
                </ul>
          </div>
       </div>

</div>