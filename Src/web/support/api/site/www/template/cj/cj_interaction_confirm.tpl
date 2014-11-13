<"collection": <
    "version": "1.0",
    "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form/{$form.id/}", 
    "links": [
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
                "href": "{$host/}/report_form",
                "rel": "create_report_form",
                "prompt": "Report a Problem"
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
                 "href": "{$host/}/email",
                 "rel": "change_email",
                 "prompt": "Change Email"
            >,
            <
                "href": "{$host/}/logoff",
                "rel": "logoff",
                "prompt": "Logoff"
            >
            {/if}
          ],
      "items": [
               <
                 "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form/{$form.id/}", 
 
                "data": [

                    <
                        "name": "title",
                        "prompt": "title",
                        "value": "Interaction Submission Confirmation"
                    >,
                    <
                        "name": "description",
                        "prompt": "Description",
                        "value": "{$form.description/}"
                    >
                    {if condition="$has_access"}
                        
                        {if isset="$new_status"}  
                         {foreach from="$status" item="item"} 
                             {if condition="$item.id = $form.selected_status"} 
                               {assign name="new_status" expression="$item.synopsis"/} 
                             {/if} 
                         {/foreach} 
                          ,
                         <
                            "name": "status",
                            "prompt": "status",
                            "value": "Change status from {$form.report.status.synopsis/} to {$new_status/}"
                         >
                        {/if}
                        {if isset="$new_category"}  
                            {foreach from="$categories" item="item"} 
                                 {if condition="$item.id = $new_category"} 
                                   {assign name="new_category_synopsis" expression="$item.synopsis"/} 
                                 {/if} 
                             {/foreach} 
                              ,
                             <
                                "name": "Category",
                                "prompt": "Category",
                                "value": "Change Category from {$form.report.category.synopsis/} to {$new_category_synopsis/}"
                             >
                        {/if}
                    {/if}

                    {if condition="$form.is_responsible_or_admin"}    
                        {if isset="$private"}  
                         ,<
                            "name": "private",
                            "prompt": "private",
                            "value": "Change Private from False to {$private/}"
                         >
                        {/if}
                    {/if}    
                    {if isset="$attachments"}
                            ,<
                            "name": "Attachments",
                            "prompt": "attachments",
                            "value" : "{foreach from="$attachments" item="item"}{$item/} {/foreach}"
                            >
                    {/if}
                    ]
                    ,
            "links": [
                        <"rel":"create", "href": "{$host/}/report_detail/{$form.report.number/}/interaction_confirm/{$form.id/}", "prompt": "Confirm">,
                        <"rel":"update", "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form/{$form.id/}", "prompt": "Edit">
                    ]  
                >
            ]

    {if isset="$error_message"}
    ,
    "error":<"title":"{$title/}","code":"{$code/}", "message":"{$error_message/}">
    {/if}  
  >
>