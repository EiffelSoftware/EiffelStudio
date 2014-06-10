<"collection": <
    "version": "1.0", 
    "href": "{$host/}/activation", 
    "links": [
             <
                "href": "{$host/}",
                "rel": "home",
                "prompt": "Home"
            >,
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
     "items" :
        [
         <
          "href" : "{$host/}",
          "data" :
            [
                <"name" : "title", "prompt": "Eiffel Support Confirmation" ,"value" : "Eiffel Support Confirmation">,
                <"name" : "message","prompt": "Message", "value" : "Thank you, your account was activated successfully. You may now Login to your account using the username and password you chose during registration.">
            ],
           "links": [
              <
                "href": "{$host/}/login", 
                "rel": "login", 
                "prompt": "Login", 
                "name": "Login"             
              >
            ]  
         >
    ]      
  >
>