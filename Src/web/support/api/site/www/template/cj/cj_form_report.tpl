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
                "rel": "all",
                "prompt": "Reports"
            >,
            <
                "href": "{$host/}/static/profile/esa_api.xml",
                "rel": "profile"
            >,
            {if isset="$user"}
            <
                "href": "{$host/}/user_reports/{$user/}",
                "rel": "all_user",
                "prompt": "My Reports"
            >,
            {if isset="$id"} 
                <
                "href": "{$host/}/report_confirm/{$id/}",
                "rel": "create",
                "prompt": "Confirm Report"
            >,
            {/if}
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
    "template": <
      "data": [
        <"name": "category", "prompt": "Category","acceptableValues":[{foreach from="$categories" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], {if isset="$category"}"value": "{$category/}"{/if}{unless isset="$category"}"value" : ""{/unless}>, 
        <"name": "severity", "prompt": "Severity", "acceptableValues":[{foreach from="$severities" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], {if isset="$severity"}"value": "{$severity/}"{/if}{unless isset="$severity"}"value" : ""{/unless}>,
        <"name": "priority", "prompt": "Priority", "acceptableValues":[{foreach from="$priorities" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], {if isset="$priority"}"value": "{$priority/}"{/if}{unless isset="$priority"}"value" : ""{/unless}>,
        <"name": "class", "prompt": "Class", "acceptableValues":[{foreach from="$classes" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], {if isset="$class"}"value": "{$class/}"{/if}{unless isset="$class"}"value" : ""{/unless}>,
        <"name": "release", "prompt": "Release", {if isset="$release"}"value": "{$release/}"{/if}{unless isset="$release"}"value" : ""{/unless}>,
        <"name": "confidential", "prompt": "Confidential", "acceptableValues":[<"name":"1","value":"True">,<"name":"0","value":"False">], {if isset="$confidential"}"value": "{$confidential/}"{/if}{unless isset="$confidential"}"value" : ""{/unless}>,
        <"name": "synopsis", "prompt": "Synopsis", {if isset="$synopsis"}"value": "{$synopsis/}"{/if}{unless isset="$synopsis"}"value" : ""{/unless}>,
        <"name": "environment", "prompt": "Environment",{if isset="$environment"}"value": "{$environment/}"{/if}{unless isset="$environment"}"value" : ""{/unless}>,
        <"name": "description", "prompt": "Description",{if isset="$description"}"value": "{$form.description_json/}"{/if}{unless isset="$description"}"value" : ""{/unless}>,
        <"name": "to_reproduce", "prompt": "To Reproduce", {if isset="$to_reproduce"}"value": "{$form.to_reproduce_json/}"{/if}{unless isset="$to_reproduce"}"value" : ""{/unless}>,
        <"name" : "attachments", "files" : [{foreach from="$uploaded_files", item="file"} <"name":"{$file.name/}", "value":"">,{/foreach}] , "prompt" : "Attachments">
      ]
      >
    {if isset="$error_message"}
    ,
    "error":<"title":"{$title/}","code":"{$code/}", "message":"{$error_message/}">
    {/if}  
  >
>