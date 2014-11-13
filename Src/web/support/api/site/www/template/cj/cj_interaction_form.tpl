<"collection": <
    "version": "1.0",
     {if isset="$id"} 
        "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form/{$id/}", 
     {/if}
     {unless isset="$id"}
           "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form",
     {/unless}      
        
    "links": [
            <
                "href": "{$host/}/reports",
                "rel": "all",
                "prompt": "Reports"
            >,
            <
                "href": "{$host/}/static/profile/esa_api.xml",
                "rel": "profile"
            >,
            {if isset="$user"}
            <
                "href": "{$host/}/report_form",
                "rel": "create_report_form",
                "prompt": "Report a Problem"
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
            >
            {/if}
          ],
      "items": [
               <
                   {if isset="$id"} 
                        "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form/{$id/}", 
                    {/if}
                    {unless isset="$id"}
                          "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form",
                    {/unless}  
                 "data": [

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
                   
                  ],
            "links": [
                        <"rel":"all", "href": "{$host/}/report_detail/{$report.number/}", "prompt": "Report Detail">,
                        <"rel":"all", "href": "{$host/}/categories", "prompt": "List of Report Categories">,
                        <"rel":"all", "href": "{$host/}/status", "prompt": "List of Report Status">
                    ]  
                >
            ],

   {if isset="$id"}        
    "template": <
      "data": [
        <"name": "description", "prompt": "Description","value" : "{$form.description/}">,
        {if condition="$has_access"}
        <"name": "category", "prompt": "Category", "acceptableValues":[{foreach from="$categories" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], "value" : "{$form.category/}">, 
        <"name": "status", "prompt": "Status","acceptableValues":[{foreach from="$status" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], "value" : "{$form.selected_status/}">,
        {/if}
        {if condition="$form.is_responsible_or_admin"}
         <"name": "private", "prompt": "Private", "acceptableValues":[<"name":"1","value":"True">,<"name":"0","value":"False">], "value" : "{$form.private/}">,
        {/if}
        <"name" : "attachments", "files" : [{foreach from="$temporary_files", item="file"} <"name":"{$file.name/}", "value":"">,{/foreach}] , "prompt" : "Attachments">
      ]
      >
    {/if}

    {unless isset="$id"}        
    "template": <
      "data": [
        <"name": "description", "prompt": "Description", "value" : "">,
        {if condition="$has_access"}
        <"name": "category", "prompt": "Category","acceptableValues":[{foreach from="$categories" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], "value" : "">, 
        <"name": "status", "prompt": "Status", "acceptableValues":[{foreach from="$status" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], "value" : "">,
        {/if}
        {if condition="$form.is_responsible_or_admin"}
        <"name": "private", "prompt": "Private", "acceptableValues":[<"name":"1","value":"True">,<"name":"0","value":"False">], "value" : "{$form.private/}">,
        {/if}
        <"name" : "attachments", "files" : [<>] , "prompt" : "Attachments">
      ]
      >
    {/unless}
       
    {if isset="$error_message"}
    ,
    "error":<"title":"{$title/}","code":"{$code/}", "message":"{$error_message/}">
    {/if}  
  >
>