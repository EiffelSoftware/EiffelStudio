<"collection": <
    "version": "1.0", 
    "href": "{$host/}/subscribe_to_category", 
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
                "href": "{$host/}/static/profile/esa_api.xml",
                "rel": "profile"
            >,
            {if isset="$user"}
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
                "href": "{$host/}/email",
                "rel": "change_email",
                "prompt": "Change email"
            >,
            <
                "href": "{$host/}/password",
                "rel": "change_password",
                "prompt": "Change password"
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
             <"name" : "categories", "acceptableValues":[{foreach from="$categories" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach}], 
                "array": [{foreach from="$categories" item="item"}{if condition="$item.subscribed"}"{$item.id/}",{/if}{/foreach}]>
      ]     >,
    
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
        >
       ]  
    {if isset="$error"}
    ,
    "error":<"title":"{$title/}","code":"{$code/}", "message":"{$error/}">
    {/if}  
      
  >
>