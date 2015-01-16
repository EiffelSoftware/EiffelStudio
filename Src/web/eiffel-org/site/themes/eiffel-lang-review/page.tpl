<!DOCTYPE html>
<html lang="en">
  {include file="head.tpl"/}
<body>
<body>
  <!-- Body -->
  <div class='container-fluid'>
    
    <!-- Page Header -->
    <div id="header">
		  {include file="header.tpl"/}      
   </div> 
    
    <!-- General Page Content -->
    <div id='content' class='row-fluid'>
		  <!-- Left Sidebar sidebar_first -->
  		{if isset="$page.region_sidebar_first"}
  		<div style="float: left;">
  		  {$page.region_sidebar_first/}
  		</div>
  		{/if}


        <!-- Highlighted, Help, Content -->      
        <div class='span8 main'>
            {if condition="$page.is_front"}
              {include file="front/container-main.tpl"/}
              {assign name="empty" value=""/}
              {unless condition="$page.region_header ~ $empty"}
                      {$page.region_header/}
              {/unless} 

            {/if}
            {unless condition="$page.is_front"}
              {if condition="$page.type ~ $doc_page_type"}
                {include file="doc/content.tpl"/}
              {/if}
              {unless condition="$page.type ~ $doc_page_type"}
                 {if isset="$page.region_content"}{$page.region_content/}{/if}
              {/unless}
             {/unless} 
	      </div>

		<!-- Right Sidebar sidebar_second-->
		{if isset="$page.region_sidebar_second"}
		<div style="float: right;">
  		{$page.region_sidebar_second/}
  	</div>
		{/if}

    </div>
   </div>

  <!--Page footer -->
  {include file="footer.tpl"/}
  <!-- Page Bottom -->
  {$page.region_bottom/}
</body>
{include file="optional_enhancement_js.tpl"/}
</html>
