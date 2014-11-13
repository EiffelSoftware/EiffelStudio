<"collection": <
    "version": "1.0", 
     {if isset="$id"}
        "href": "{$host/}/reports/{$id/}", 
     {/if}
     {unless isset="$id"}
        "href": "{$host/}/reports", 
     {/unless}
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
                "href": "{$host/}/reports?page=1&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}",
                "rel": "first",
                "prompt": "First"
            >
            {if isset="$prev"}
                ,
            <
                "href": "{$host/}/reports?page={$prev/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}",
                "rel": "previous",
                "prompt": "Previous"
            >
            {/if}
            {if isset="$next"}
              ,
            <
                "href": "{$host/}/reports?page={$next/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}",
                "rel": "next",
                "prompt": "Next"
            >     
            {/if}
            ,
            <
                "href": "{$host/}/reports?page={$last/}&size={$size/}&category={$view.selected_category/}&submitter={$view.submitter/}&severity={$view.selected_severity/}&priority={$view.selected_priority/}&responsible={$view.selected_responsible/}&status={$status_query/}&orderBy={$view.orderBy/}&dir={$view.dir/}&filter={$view.filter/}&filter_content={$view.filter_content/}",
                "rel": "last",
                "prompt": "Last"
            >,
            <
               "href": "{$host/}/account",
               "rel": "account",
               "prompt": "Account information"
            >,
            <
               "href": "{$host/}/password",
               "rel": "change_password",
               "prompt": "Change password"
            >,
            <
               "href": "{$host/}/email",
               "rel": "change_email",
               "prompt": "Change Email"
            >,
            <
             "href": "{$host/}/logoff",
             "rel": "logoff",
             "prompt": "Logoff"
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
                        "value": "{$item.synopsis_encode/}"
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
       {if isset="$id"}
       "template": <
       "data": [
               <"name" : "responsible",  "prompt": "Responsible", "acceptableValues":[{foreach from="$responsibles" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach} <"name": "0", "value": "ALL">], "value" :"{$view.selected_responsible/}">   

            ] 
        >,
       {/if}
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
          "href" : "{$host/}/reports?page={$last/}&size={$size/}",
          "rel" : "search",
          "prompt" : "Sorting",
          "data" :
            [
               <"name" : "orderBy", "acceptableValues":[{foreach from="$columns" item="item"} "{$item/}",{/foreach}], "value" :"{$orderBy/}">,
               <"name" : "dir", "acceptableValues":["ASC","DESC"], "value" : "{$view.direction/}" >,
               <"name" : "category", "acceptableValues":[{foreach from="$categories" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach} <"name": "0", "value": "ALL">], "value" :"{$view.selected_category/}">,
               <"name" : "status", "acceptableValues":[{foreach from="$status" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], 
                "array": [{foreach from="$checked_status" item="item"} "{$item.synopsis/}",{/foreach}]>,

               <"name" : "priority", "acceptableValues":[{foreach from="$priorities" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach} <"name": "0", "value": "ALL">], "value" :"{$view.selected_priority/}">,

                <"name" : "severity", "acceptableValues":[{foreach from="$severities" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach} <"name": "0", "value": "ALL">], "value" :"{$view.selected_severity/}">,

                <"name" : "responsible", "acceptableValues":[{foreach from="$responsibles" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach} <"name": "0", "value": "ALL">], "value" :"{$view.selected_responsible/}">,
                <"name" : "submitter", "value" : "{$view.submitter/}">,
                <"name" : "filter", "value" : "{$view.filter/}">,
                <"name" : "filter_content", "acceptableValues":[<"name":"1","value":"True">,<"name":"0","value":"False">], "value" : "{$view.filter_content/}">,
                <"name" : "size", "value":"{$size/}">

            ]
        >
    ]                      
  >
>