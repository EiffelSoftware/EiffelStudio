<"collection": <
    "version": "1.0", 
    "href": "{$host/}/reminder", 
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
          ],
    "template": <
      "data": [
                <"name" : "email", "value" : "", "prompt": "Email">
            ]
        >
      {if isset="$error"}
        ,
       "error":<"title":"","code":"", "message":"{$error/}">
      {/if}  
  >
>