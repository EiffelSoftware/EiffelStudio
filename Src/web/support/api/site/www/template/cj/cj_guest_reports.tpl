<"collection": <
    "version": "1.0",
    "href": "{$host/}/reports?page=1&size={$size/}&category={$view.selected_category/}&status={$status_query/}&orderBy={$orderBy/}&dir={$dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}",
    {include file="cj_metadata.tpl"/}                
    "links": [
            <
                "href": "{$host/}/",
                "rel": "home",
                "prompt": "Home"
            >,
             <
                "href": "{$host/}/reports",
                "rel": "all",
                "prompt": "Reports"
            >,
            <
               "href": "{$host/}/reports?page=1&size={$size/}&category={$view.selected_category/}&status={$status_query/}&orderBy={$orderBy/}&dir={$dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}",
                "rel": "first",
                "prompt": "First"
            >
                {if isset="$prev"}
                ,
                <
                    "href": "{$host/}/reports?page={$prev/}&size={$size/}&category={$view.selected_category/}&status={$status_query/}&orderBy={$orderBy/}&dir={$dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}",
                    "rel": "previous",
                    "prompt": "Previous"
                >
                {/if}
                {if isset="$next"}
                  ,
                <
                    "href": "{$host/}/reports?page={$next/}&size={$size/}&category={$view.selected_category/}&status={$status_query/}&orderBy={$orderBy/}&dir={$dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}",
                    "rel": "next",
                    "prompt": "Next"
                >     
                {/if}
                ,
            <
              "href": "{$host/}/reports?page={$last/}&size={$size/}&category={$view.selected_category/}&status={$status_query/}&orderBy={$orderBy/}&dir={$dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}",
              "rel": "last",
              "prompt": "Last"
            >,
            <
              "href": "{$host/}/login",
              "rel": "login",
              "prompt": "Login"
            >,
            <
              "href": "{$host/}/register",
              "rel": "register",
              "prompt": "Register"
            >,
            <
                "href": "{$host/}/static/profile/esa_api.xml",
                "rel": "profile"
            >
          ],
     "items": [
               {foreach from="$reports" item="item"}
               <
                "href": "{$host/}/report_detail/{$item.number/}",
                "data": [
                    <
                        "name": "Group",
                        "prompt": "Reports",
                        "value": "report"
                    >,
                    <
                        "name": "status",
                        "prompt": "Status",
                        "value": "{$item.status.synopsis/}"
                    >,
                    <
                        "name": "Synopsis",
                        "prompt": "synopsis",
                        "value": "{$item.synopsis_encode/}"
                    >,
                    <
                        "name": "submission date",
                        "prompt": "Submission date",
                        "value": "{$item.submission_date/}"
                    >,
                      <
                        "name": "Category",
                        "prompt": "category",
                        "value": "{$item.category.synopsis/}"
                    >
                  ]
                , 
                "links" : [
                    <"rel" : "report_interaction", "href" : "{$host/}/report_detail/{$item.number/}", "prompt" : "Report Details and Interactions">
                    ]
                >,{/foreach}]
        ,
       "queries" :
        [
         <
          "href" : "{$host/}/report_detail/",
          "rel" : "search",
          "prompt" : "Search by Report #...",
          "data" :
            [
                <"name" : "search", "value" : "">
            ]
        >,
        <
          "href" : "{$host/}/reports?page={$index/}",
          "rel" : "search",
          "prompt" : "Sorting/Filter",
          "data" :
            [
                <"name" : "orderBy", "acceptableValues":[{foreach from="$columns" item="item"} "{$item/}",{/foreach}], "value" :"{$orderBy/}">,
                {assign name="ldir" value="1"/}
                <"name" : "dir", "acceptableValues":["ASC","DESC"], "value" : "{$view.direction/}" >,
                <"name" : "category", "acceptableValues":[{foreach from="$categories" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach} <"name": "0", "value": "ALL">], "value" :"{$view.selected_category/}">,
                <"name" : "status", "acceptableValues":[{foreach from="$status" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], 
                "array": [{foreach from="$checked_status" item="item"} "{$item.synopsis/}",{/foreach}]>,
                <"name" : "filter", "value" : "{$view.filter/}">,
                <"name" : "filter_content", "acceptableValues":[<"name":"1","value":"True">,<"name":"0","value":"False">], "value" : "{$view.filter_content/}">,
                <"name" : "size", "value":"{$size/}">
            ]
        >
    ]                      
  >
>