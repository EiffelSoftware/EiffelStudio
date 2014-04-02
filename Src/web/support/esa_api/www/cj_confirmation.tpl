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
            <
                "href": "{$host/}/report_form",
                "rel": "create-form",
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