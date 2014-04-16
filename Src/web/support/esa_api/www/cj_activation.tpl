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
    "template": <
      "data": [
                <"name" : "email", "value" : "{$form.email/}", "prompt": "Email">,
                <"name" : "token", "value" : "{$form.token/}", "prompt": "Token">
            ]
        >
      {if isset="$error"}
        ,
       "error":<"title":"{$title/}","code":"{$code/}", "message":"{$error/}">
      {/if}  
      

    ]      
  >
>