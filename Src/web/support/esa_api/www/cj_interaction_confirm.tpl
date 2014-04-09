<"collection": <
    "version": "1.0",
    "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form/{$id/}", 
    "links": [
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
          ],
      "items": [
               <
                 "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form/{$id/}", 
 
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
                    {if isset="$new_status"}  
                     {foreach from="$status" item="item"} 
                         {if condition="$item.id = $form.selected_status"} 
                           {assign name="new_status" vale="$item.synopsis"/} 
                         {/if} 
                     {/foreach} 
                      ,
                     <
                        "name": "status",
                        "prompt": "status",
                        "value": "Change status from {$form.report.status.synopsis/} to {$new_status/}"
                     >
                     ,{/if}{if isset="$private"}  
                     <
                        "name": "private",
                        "prompt": "private",
                        "value": "Change Private from {$form.report.confidential/} to {$private/}"
                     >
                    {/if}]
                    ,
            "links": [
                        <"rel":"create-form", "href": "{$host/}/report_detail/{$form.report.number/}/interaction_confirm/{$form.id/}", "prompt": "Confirm">,
                        <"rel":"edit-form", "href": "{$host/}/report_detail/{$form.report.number/}/interaction_form/{$form.id/}", "prompt": "Edit">
                    ]  
                >
            ]

    {if isset="$error_message"}
    ,
    "error":<"title":"{$title/}","code":"{$code/}", "message":"{$error_message/}">
    {/if}  
  >
>