<"collection": <
    "version": "1.0", 
    "href": "{$host/}/report_detail/{$report/}/interaction_confirm", 
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
            >
            {/unless} 

          ],
    "template": <
      "data": [
                <"name" : "confirm", "value" : "{$confirm/}", "prompt": "Confirm Interaction">
            ]
        >
      {if isset="$error"}
        ,
       "error":<"title":"{$title/}","code":"{$code/}", "message":"{$error/}">
      {/if}  
  >
>