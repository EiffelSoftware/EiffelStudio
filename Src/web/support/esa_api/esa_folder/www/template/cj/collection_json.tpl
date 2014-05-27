<"collection": <
    "version": "1.0", 
    "href": "{$host/}", 
    "links": [
            <
                "href": "{$host/}/profile/esa_api.xml",
                "rel": "profile"
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
                "rel": "create-report-form",
                "prompt": "Report a Problem"
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
            >,
            <
                "href": "{$host/}/reminder",
                "rel": "reminder",
                "prompt": "Recover Username/Password"
            >
            {/unless}
           
          ],
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
  >
>