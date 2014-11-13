<"collection": <
    "version": "1.0",
     "href": "{$host/}/severity", 
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
                    "href": "{$host/}/logoff",
                    "rel": "logoff",
                    "prompt": "Logoff"
                >,
            {/if}
            {unless isset="$user"}
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
                "href": "http://alps.io/iana/relations.xml",
                "rel": "profile"
            >
          ],
        "items": [
               {foreach from="$severity" item="item"}
               <
                "href": "{$host/}/severity/{$item.id/}",
                "data": [
                    <
                        "name": "Id",
                        "prompt": "Id",
                        "value": "{$item.id/}"
                    >,
                    <
                        "name": "severity",
                        "prompt": "severity",
                        "value": "{$item.synopsis/}"
                    >
                  ]
                >,{/foreach}]                      
    >
>