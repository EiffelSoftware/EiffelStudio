<"collection": <
    "version": "1.0", 
    "href": "{$host/}/register", 
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
 
   "template": <
      "data": [
        <"name": "first_name", "prompt": "Frist Name", "value": "{$form.first_name/}">,
        <"name": "last_name", "prompt": "Last Name", "value": "{$form.last_name/}">,
        <"name": "email", "prompt": "Email", "value": "{$form.email/}">,
        <"name": "user_name", "prompt": "User Name", "value": "{$form.user_name/}">,
        <"name": "password", "prompt": "Password", "value": "{$form.password/}">,
        <"name": "check_password", "prompt": "Re-Type Password", "value": "{$form.check_password/}">,
        <"name": "question", "prompt": "Question", "value": "{$form.selected_question/}">,
        <"name": "answer", "prompt": "Answer", "value": "{$form.answer/}">
      ]
      >,
    
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