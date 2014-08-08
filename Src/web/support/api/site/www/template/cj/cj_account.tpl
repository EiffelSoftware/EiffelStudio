<"collection": <
    "version": "1.0", 
    "href": "{$host/}/account", 
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
                "href": "{$host/}/email",
                "rel": "change_email",
                "prompt": "Change email"
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

          ],
 
   "template": <
      "data": [
             <"name": "first_name", "prompt": "Frist Name", "value": "{$form.first_name/}">,
             <"name": "last_name", "prompt": "Last Name", "value": "{$form.last_name/}">,
             <"name": "user_email", "prompt": "Email", "value": "{$form.email/}">,
             <"name": "country", "prompt": "Country", "value": "{$form.country/}">,
             <"name": "user_region", "prompt": "Region", "value": "{$form.region/}">,
             <"name": "user_position", "prompt": "Position", "value": "{$form.position/}">,
             <"name": "user_city", "prompt": "City", "value": "{$form.city/}">,
             <"name": "user_address", "prompt": "Address", "value": "{$form.address/}">,
             <"name": "user_post_code", "prompt": "Postal Code", "value": "{$form.postal_code/}">,
             <"name": "user_phone", "prompt": "Thelehone", "value": "{$form.telephone/}">,
             <"name": "user_fax", "prompt": "Fax", "value": "{$form.fax/}">
      ]     >,
    
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