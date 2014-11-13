<"collection": <
    "version": "1.0", 
    "href": "{$host/}/account", 
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
             <"name": "first_name", "prompt": "Frist Name", "value": "{$account.first_name/}">,
             <"name": "last_name", "prompt": "Last Name", "value": "{$account.last_name/}">,
             <"name": "user_email", "prompt": "Email", "value": "{$account.email/}">,
             <"name": "country", "prompt": "Country",  "acceptableValues":[{foreach from="$account.countries" item="item"}<"name": "{$item.id/}", "value": "{$item.synopsis/}">,{/foreach} <"name": "0", "value": "ALL">], "value": "{$account.selected_country/}">,
             <"name": "user_region", "prompt": "Region", "value": "{$account.region/}">,
             <"name": "user_position", "prompt": "Position", "value": "{$account.position/}">,
             <"name": "user_city", "prompt": "City", "value": "{$account.city/}">,
             <"name": "user_address", "prompt": "Address", "value": "{$account.address/}">,
             <"name": "user_post_code", "prompt": "Postal Code", "value": "{$account.postal_code/}">,
             <"name": "user_phone", "prompt": "Thelehone", "value": "{$account.telephone/}">,
             <"name": "user_fax", "prompt": "Fax", "value": "{$account.fax/}">
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