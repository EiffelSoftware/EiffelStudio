<"collection": <
    "version": "1.0", 
    "href": "{$host/}/report_detail/{$report.number/}", 
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
                "href": "http://alps.io/iana/relations.xml",
                "rel": "profile"
            >
            {if isset="$user"}
            ,
            <
               "href": "{$host/}/user_reports/{$user/}",
               "rel": "author",
               "prompt": "My Reports"
            >,
            <
               "href": "{$host/}/report_form",
               "rel": "create-form",
               "prompt": "Report a Problem"
            >,
            <
             "href": "{$host/}/logoff",
             "rel": "logoff",
             "prompt": "Logoff"
            >
            {/if}
            {unless isset="$user"}
             ,   
             <
              "href": "{$host/}/login",
              "rel": "login",
              "prompt": "Login"
             >,
             <
               "href": "{$host/}/register",
               "rel": "register",
               "prompt": "Register"
             >
            {/unless}
          ],
     "items": [
               <
                "href": "{$host/}/report_detail/{$report.number/}",
                "data": [
                    <
                        "name": "Group",
                        "prompt": "group",
                        "value": "Description"
                    >,
                    <
                        "name": "Submitter",
                        "prompt": "submitter",
                        "value": "{$report.contact.name/}"
                    >,
                    <
                        "name": "Category",
                        "prompt": "category",
                        "value": "{$report.category.synopsis/}"
                    >,
                    <
                        "name": "Priority",
                        "prompt": "priority",
                        "value": "{$report.priority.synopsis/}"
                    >,
                    <
                        "name": "Category",
                        "prompt": "category",
                        "value": "{$item.category.synopsis/}"
                    >,
                    <                    
                        "name": "Date",
                        "prompt": "date",
                        "value": "{$report.submission_date/}"
                    >,
                    <
                        "name": "Class",
                        "prompt": "class",
                        "value": "{$report.report_class.synopsis/}"
                    >,
                    <
                        "name": "Severity",
                        "prompt": "severity",
                        "value": "{$report.severity.synopsis/}"
                    >,
                    <
                        "name": "Number",
                        "prompt": "number",
                        "value": "{$report.number/}"
                    >,
                    <
                        "name": "Release",
                        "prompt": "release",
                        "value": "{$report.release/}"
                    >,
                    <
                        "name": "Confidential",
                        "prompt": "confidential",
                        "value": "{$report.confidential/}"
                    >,
                    <
                        "name": "Status",
                        "prompt": "status",
                        "value": "{$report.status.synopsis/}"
                    >,
                    <
                        "name": "Responsible",
                        "prompt": "responsible",
                        "value": ""
                    >,
                    <
                        "name": "Environment",
                        "prompt": "environment",
                        "value": "{$report.environment/}"
                    >,
                    <
                        "name": "Synopsys",
                        "prompt": "synopsis",
                        "value": "{$report.synopsis/}"
                    >,
                    <
                        "name": "Description",
                        "prompt": "description",
                        "value": "{$report.description_encode/}"
                    >,
                    <
                        "name": "To reproduce",
                        "prompt": "to reproduce",
                        "value": "{$report.to_reproduce_encode/}"
                    >
                   ,{foreach from="$report.interactions" item="item"}
                     <
                        "name": "Group",
                        "prompt": "group",
                        "value": "Interactions"
                    >,
                     <
                        "name": "From",
                        "prompt": "from",
                        "value": "{$item.contact.name/}"
                    >,
                    <
                        "name": "Date",
                        "prompt": "date",
                        "value": "{$item.date/} "
                    >,
                    <
                        "name": "Status",
                        "prompt": "status",
                        "value": "{$item.status/} "
                    >,
                    <
                        "name": "Content",
                        "prompt": "content",
                        "value": "{$item.content_encoded/}"
                    >,{foreach from="$item.attachments" item="elem"}
                        <
                            "name": "Group",
                            "prompt": "group",
                            "value": "Interactions-Attachments"
                        >,
                        <
                            "name": "Attatchment",
                            "prompt": "attachment",
                            "value": "{$host/}/report_interaction/{$elem.id/}/{$elem.name/}"
                        >,
                         <
                            "name": "Bytes count",
                            "prompt": "bytes count",
                            "value": "{$elem.bytes_count/}"
                        >
                      {/foreach}{/foreach}], 
                "links":[
                {foreach from="$report.interactions" item="item"}
                   
                    {foreach from="$item.attachments" item="elem"}
                     <
                       "href": "{$host/}/report_interaction/{$elem.id/}/{$elem.name/}",
                       "rel": "download",
                       "prompt": "Attatchment"
                     >,{/foreach}{/foreach}]      

               >
            ]
     
   >
>