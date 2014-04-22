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
                       <td>{$item.number/}</td>
                       <td>{$item.status.id/}</td>
                       <td>{$item.synopsis/}</td>
                       <td>{$item.submission_date/}</td>
                       <td>{$item.category.synopsis/}</td>
                </tr>
              {/foreach}
              
              </tbody>
            </table>
      
           <div class="col-lg-12">
                <ul class="pager">
                <li><a href="#">Previous</a></li>
                <li><a href="#">Next</a></li>
              </ul>
          </div>
       </div>

</div>