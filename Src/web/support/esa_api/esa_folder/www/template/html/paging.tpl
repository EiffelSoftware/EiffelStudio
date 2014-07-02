 <div class="col-lg-12">
      <ul class="pager">
           {if isset="$user"}
              <li><a href="{$host/}/user_reports/{$user/}?page=1&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" itemprop="first" rel="first">First</a></li>
              {if isset="$prev"}
                  <li><a href="{$host/}/user_reports/{$user/}?page={$prev/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" itemprop="previous" rel="previous">Previous</a></li>
              {/if}
              {if isset="$next"}
                  <li><a href="{$host/}/user_reports/{$user/}?page={$next/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}"  itemprop="next" rel="next">Next</a></li>
              {/if}
                  <li><a href="{$host/}/user_reports/{$user/}?page={$last/}&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}"  itemprop="last" rel="last">Last</a></li>
              {/if}
            {unless isset="$user"}
                 <li><a href="{$host/}/reports?page=1&size={$size/}&category={$selected_category/}&status={$selected_status/}&orderBy={$orderBy/}&dir={$dir/}" itemprop="first" rel="first">First</a></li>
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