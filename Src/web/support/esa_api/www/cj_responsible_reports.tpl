<"collection": <
    "version": "1.0", 
    "href": "{$host/}/reports", 
    "links": [
            <
                "href": "{$host/}",
                "rel": "home",
                "prompt": "Home"
            >,
             <
                "href": "{$host/}/reports",
                "rel": "collection",
                "prompt": "Reports"
            >,
            <
                "href": "{$host/}/reports",
                "rel": "first",
                "prompt": "First"
            >
            {if isset="$prev"}
                ,
            <
                "href": "{$host/}/reports/{$prev/}",
                "rel": "previous",
                "prompt": "Previous"
            >
            {/if}
            {if isset="$next"}
              ,
            <
                "href": "{$host/}/reports/{$next/}",
                "rel": "next",
                "prompt": "Next"
            >     
            {/if}
            ,
            <
                "href": "{$host/}/reports/{$last/}",
                "rel": "last",
                "prompt": "Last"
            >,
            <
                "href": "http://alps.io/iana/relations.xml",
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
                        "value": "{$item.status.id/}"
                    >,
                    <
                        "name": "priority",
                        "prompt": "Priority",
                        "value": "{$item.priority.id/}"
                    >,
                    <
                        "name": "severity",
                        "prompt": "Severity",
                        "value": "{$item.severity.id/}"
                    >,
                     <
                        "name": "Synopsis",
                        "prompt": "synopsis",
                        "value": "{$item.synopsis/}"
                    >,
                    <
                        "name": "submitter",
                        "prompt": "Submitter",
                        "value": "{$item.contact.name/}"
                    >,

                    <
                        "name": "submission date",
                        "prompt": "Submission date",
                        "value": "{$item.submission_date/}"
                    >,
                    <
                        "name": "responsible",
                         {foreach from="$responsibles" item="val"}
                              {if condition="$val.id = $item.assigned.id"}
                                        "value": "{$val.synopsis/}",                                                 
                              {/if}
                         {/foreach}
                         "prompt": "responsible"     
                    > ,         
                    <
                        "name": "Category",
                        "prompt": "category",
                        "value": "{$item.category.synopsis/}"
                    >,
                    <
                        "name": "Release",
                        "prompt": "release",
                        "value": "{$item.release/}"
                    >
                  ],
                  "links" : [
                    <"rel" : "item", "href" : "{$host/}/reports/{$item.number/}", "prompt" : "Update Responsible">
                    ]
                >,{/foreach}
                {foreach from="$categories" item="item"}
                <
                "href": "{$host/}/categories/{$item.id/}",
                "data": [
                   <
                        "name": "Group",
                        "prompt": "Categories",
                        "value": "category"
                    >,
                    <
                        "name": "Id",
                        "prompt": "Category Item",
                        "value": "{$item.id/}"
                    >,
                    <
                        "name": "Synopsis",
                        "prompt": "Category Item",
                        "value": "{$item.synopsis/}"
                    >
                   ] 
                >,{/foreach}
                {foreach from="$status" item="item"}
                <
                "href": "{$host/}/status/{$item.id/}",
                "data": [
                   <
                        "name": "Group",
                        "prompt": "Status",
                        "value": "status"
                    >,
                    <
                        "name": "Id",
                        "prompt": "Status Item",
                        "value": "{$item.id/}"
                    >,
                    <
                        "name": "Synopsis",
                        "prompt": "Status Item",
                        "value": "{$item.synopsis/}"
                    >
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
          "href" : "{$host/}/reports/",
          "rel" : "search",
          "prompt" : "Filter by Category / Status / Priority / Responsible / Severity / Submitter",
          "data" :
            [
                <"name" : "category", "value" : "">,
                <"name" : "status", "value" : "">,
                <"name" : "priority", "value" : "">,
                <"name" : "responsible", "value" : "">,
                <"name" : "severity", "value" : "">,
                <"name" : "submitter", "value" : "">
            ]
        >,
        <
          "href" : "{$host/}/reports/{$index/}/",
          "rel" : "search",
          "prompt" : "Sorting",
          "data" :
            [
                <"name" : "orderBy", "value" : "">,
                <"name" : "dir", "value" : "">,
                <"name" : "category", "value" : "">,
                <"name" : "status", "value" : "">,
                <"name" : "priority", "value" : "">,
                <"name" : "responsible", "value" : "">,
                <"name" : "severity", "value" : "">,
                <"name" : "submitter", "value" : "">
        
            ]
        >
    ]                      
  >
>