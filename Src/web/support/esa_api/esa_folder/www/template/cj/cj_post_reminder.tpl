<"collection": <
    "version": "1.0", 
    "href": "{$host/}", 
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
    "items":[
               <
                "href": "{$host/}/reminder",
                "data": [
                    <
                        "name": "Reminder",
                        "prompt": "Eiffel Reminder Confirmation",
                        "value": "Thank you, your new password was successfully sent to your email."
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