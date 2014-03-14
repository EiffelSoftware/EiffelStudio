<"collection": <
    "version": "1.0", 
    "href": "{$host/}/reports", 
    "links": [
            <
                "href": "{$host/}",
                "rel": "home",
                "prompt": "Home"
            >,
             <
                "href": "{$host/}reports",
                "rel": "collection",
                "prompt": "Reports"
            >,
            <
                "href": "{$host/}/reports",
                "rel": "first",
                "prompt": "First"
            >,
            <
                "href": "{$host/}/reports/{$prev/}",
                "rel": "previous",
                "prompt": "Previous"
            >,
            <
                "href": "{$host/}/reports/{$next/}",
                "rel": "next",
                "prompt": "Next"
            >,
            <
                "href": "{$host/}/reports/{$last/}",
                "rel": "last",
                "prompt": "Last"
            >,
            <
                "href": "http://alps.io/iana/relations.xml",
                "rel": "profile"
            >
          ],
     "items": [
               {foreach from="$reports" item="item"}
               <
                "href": "{$host/}/report_detail/{$item.number/}",
                "data": [
                    <
                        "name": "status",
                        "prompt": "Status",
                        "value": "{$item.status.synopsis/}"
                    >,
                    <
                        "name": "Synopsis",
                        "prompt": "synopsis",
                        "value": "{$item.synopsis/}"
                    >,
                    <
                        "name": "submission date",
                        "prompt": "Submission date",
                        "value": "{$item.submission_date/}"
                    >,
                      <
                        "name": "Category",
                        "prompt": "category",
                        "value": "{$item.category.synopsis/}"
                    >
                  ]
                >,{/foreach}]     
  >
>