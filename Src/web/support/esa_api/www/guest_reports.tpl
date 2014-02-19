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
                <li><a href="{$host/}/reports">First</a></li>
                <li><a href="{$host/}/reports/{$prev/}">Previous</a></li>
                <li><a href="{$host/}/reports/{$next/}">Next</a></li>
                <li><a href="{$host/}/reports/{$last/}">Last</a></li>
              </ul>
          </div>
       </div>

</div>