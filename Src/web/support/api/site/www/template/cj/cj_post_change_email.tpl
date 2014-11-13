<"collection": <
    "version": "1.0", 
    "href": "{$host/}/email", 
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
                "href": "{$host/}/logoff",
                "rel": "logoff",
                "prompt": "Logoff"
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
    "items":[
               <
                "href": "{$host/}/confirm_email",
                "data": [
                    <
                        "name": "email",
                        "prompt": "Email Activation",
                        "value": "An e-mail with an activation code was sent to your account.  Please check your email and use the provided link to activate your new email account."
                    >
                  ]
                >
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