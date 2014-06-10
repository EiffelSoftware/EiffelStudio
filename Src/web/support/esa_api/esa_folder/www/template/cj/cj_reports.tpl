<"collection": <
    "version": "1.0",
    {if isset="$user"} 
        "href": "{$host/}/user_reports/{$user/}", 
    {/if}
    {unless isset="$user"} 
        "href": "{$host/}/reports", 
    {/unless}
    "links": [
            <
                "href": "{$host/}",
                "rel": "home",
                "prompt": "Home"
            >,
             <
                "href": "{$host/}/reports",
                "rel": "all",
                "prompt": "Reports"
            >,
            {if isset="$user"}
               <
                "href": "{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}",
                "rel": "first",
                "prompt": "First"
                >
                {if isset="$prev"}
                ,
                <
                    "href": "{$host/}/user_reports/{$user/}?page={$prev/}&size={$size/}",
                    "rel": "previous",
                    "prompt": "Previous"
                >
                {/if}
                {if isset="$next"}
                  ,
                <
                    "href": "{$host/}/user_reports/{$user/}?page={$next/}&size={$size/}",
                    "rel": "next",
                    "prompt": "Next"
                >     
                {/if}
                ,
                <
                    "href": "{$host/}/user_reports/{$user/}?page={$last/}&size={$size/}",
                    "rel": "last",
                    "prompt": "Last"
                >,
                <
                    "href": "{$host/}/user_reports/{$user/}",
                    "rel": "all_user",
                    "prompt": "My Reports"
                >,
                 <
                    "href": "{$host/}/report_form",
                    "rel": "create_report_form",
                    "prompt": "Report a Problem"
                >,
                <
                    "href": "{$host/}/logoff",
                    "rel": "logoff",
                    "prompt": "Logoff"
                >,
            {/if}
            {unless isset="$user"}
                <
                "href": "{$host/}/reports?page={$index/}&size={$size/}",
                "rel": "first",
                "prompt": "First"
                >
                {if isset="$prev"}
                ,
                <
                    "href": "{$host/}/reports?page={$prev/}&size={$size/}",
                    "rel": "previous",
                    "prompt": "Previous"
                >
                {/if}
                {if isset="$next"}
                  ,
                <
                    "href": "{$host/}/reports?page={$next/}&size={$size/}",
                    "rel": "next",
                    "prompt": "Next"
                >     
                {/if}
                ,
                <
                    "href": "{$host/}/reports?page={$last/}&size={$size/}",
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
            {/unless}    
            <
                "href": "{$host/}/profile/esa_api.xml",
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
                        "value": "{$item.synopsis/}"
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
           {if isset="$user"}   
            "href" : "{$host/}/user_reports/{$user/}",
           {/if}
           {unless isset="$user"}
           "href" : "{$host/}/reports/", 
           {/unless}
          "rel" : "search",
          "prompt" : "Filter by Category / Status...",
          "data" :
            [
                <"name" : "category", "value" : "">,
                <"name" : "status", "value" : "">
            ]
        >,
        <
          {if isset="$user"}
          "href" : "{$host/}/user_reports/{$user/}?page={$index/}&size={$size/}",
          {/if}
          {unless isset="$user"}
          "href" : "{$host/}/reports?page={$index/}&size={$size/}",
          {/unless}
          "rel" : "search",
          "prompt" : "Sorting",
          "data" :
            [
                <"name" : "orderBy", "value" : "">,
                <"name" : "dir", "value" : "">,
                <"name" : "category", "value" : "">,
                <"name" : "status", "value" : "">
            ]
        >
    ]                      
  >
>