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
                "href": "{$host/}/profile/esa_api.xml",
                "rel": "profile"
            >,
            {if isset="$user"}
            <
                "href": "{$host/}/report_form",
                "rel": "create-report-form",
                "prompt": "Report a Problem"
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
                        <"rel":"all", "href": "{$host/}/report_detail/{$report.number/}/interactions", "prompt": "List of Report Interactions">,
                        <"rel":"all", "href": "{$host/}/categories", "prompt": "List of Report Categories">,
                        <"rel":"all", "href": "{$host/}/status", "prompt": "List of Report Status">
                    ]  
                >
            ],

   {if isset="$id"}        
    "template": <
      "data": [
        <"name": "category", "prompt": "Category", "value" : "{$form.category/}">, 
        <"name": "status", "prompt": "Status", "value" : "{$form.selected_status/}">,
        <"name": "private", "prompt": "Private", "value" : "{$form.private/}">,
        <"name": "description", "prompt": "Description","value" : "{$form.description/}">,
         <"name" : "attachments", "files" : [{foreach from="$uploaded_files", item="file"} <"name":"{$file.name/}", "value":"">,{/foreach}] , "prompt" : "Attachments">
      ]
      >
    {/if}

    {unless isset="$id"}        
    "template": <
      "data": [
        <"name": "category", "prompt": "Category", "value" : "">, 
        <"name": "status", "prompt": "Status", "value" : "">,
        <"name": "private", "prompt": "Private", "value" : "">,
        <"name": "description", "prompt": "Description", "value" : "">,
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