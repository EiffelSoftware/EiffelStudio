<"collection": <
    "version": "1.0",
     {if isset="$id"} 
        "href": "{$host/}/report_form/{$id/}", 
     {/if}
     {unless isset="$id"}
           "href": "{$host/}/report_form",
     {/unless}      
        
    "links": [
            <
                "href": "{$host/}/reports",
                "rel": "collection",
                "prompt": "Reports"
            >,
            <
                "href": "http://alps.io/iana/relations.xml",
                "rel": "profile"
            >,
            {if isset="$user"}
            <
                "href": "{$host/}/user_reports/{$user/}",
                "rel": "author",
                "prompt": "My Reports"
            >,
            {if isset="$id"} 
                <
                "href": "{$host/}/report_confirm/{$id/}",
                "rel": "alternate",
                "prompt": "Confirm Report"
            >,
            {/if}
            <
                "href": "{$host/}/logoff",
                "rel": "logoff",
                "prompt": "Logoff"
            >
            {/if}
          ],
    "template": <
      "data": [
        <"name": "category", "prompt": "Category", {if isset="$category"}"value": "{$category/}"{/if}{unless isset="$category"}"value" : ""{/unless}>, 
        <"name": "severity", "prompt": "Severity", {if isset="$severity"}"value": "{$severity/}"{/if}{unless isset="$severity"}"value" : ""{/unless}>,
        <"name": "priority", "prompt": "Priority", {if isset="$priority"}"value": "{$priority/}"{/if}{unless isset="$priority"}"value" : ""{/unless}>,
        <"name": "class", "prompt": "Class", {if isset="$class"}"value": "{$class/}"{/if}{unless isset="$class"}"value" : ""{/unless}>,
        <"name": "release", "prompt": "Release", {if isset="$release"}"value": "{$release/}"{/if}{unless isset="$release"}"value" : ""{/unless}>,
        <"name": "confidential", "prompt": "Confidential", {if isset="$confidential"}"value": "{$confidential/}"{/if}{unless isset="$confidential"}"value" : ""{/unless}>,
        <"name": "synopsis", "prompt": "Synopsis", {if isset="$synopsis"}"value": "{$synopsis/}"{/if}{unless isset="$synopsis"}"value" : ""{/unless}>,
        <"name": "environment", "prompt": "Environment",{if isset="$environment"}"value": "{$environment/}"{/if}{unless isset="$environment"}"value" : ""{/unless}>,
        <"name": "description", "prompt": "Description",{if isset="$description"}"value": "{$description/}"{/if}{unless isset="$description"}"value" : ""{/unless}>,
        <"name": "to_reproduce", "prompt": "To Reproduce", {if isset="$to_reproduce"}"value": "{$to_reproduce/}"{/if}{unless isset="$to_reproduce"}"value" : ""{/unless}>
      ]
      >
    {if isset="$error_message"}
    ,
    "error":<"title":"{$title/}","code":"{$code/}", "message":"{$error_message/}">
    {/if}  
  >
>