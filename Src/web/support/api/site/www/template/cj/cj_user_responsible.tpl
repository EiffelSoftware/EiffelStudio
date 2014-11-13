<"collection": <
    "version": "1.0",
     "href": "{$host/}/responsible", 
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
                    "rel": "all-user",
                    "prompt": "My Reports"
                >,
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
                "href": "{$host/}/static/profile/esa_api.xml",
                "rel": "profile"
            >
          ],
        "items": [
               {foreach from="$users" item="item"}
               <
                "href": "{$host/}/responsible/{$item.id/}",
                "data": [
                    <
                        "name": "Id",
                        "prompt": "Id",
                        "value": "{$item.id/}"
                    >,
                    <
                        "name": "responsible",
                        "prompt": "responsible",
                        "value": "{$item.name/}"
                    >
                  ]
                >,{/foreach}]                      
    >
>