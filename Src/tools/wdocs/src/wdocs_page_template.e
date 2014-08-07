note
	description: "Summary description for {WDOCS_PAGE_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_PAGE_TEMPLATE

feature -- Rendering

	xhtml (a_values: STRING_TABLE [READABLE_STRING_8]): STRING
		do
			Result := "[
<html>
	<head>
		<title>
			Wiki Docs
		</title>
	</head>
	<body>
		${HEADER}
		<div id="main">
			<div id="content">${CONTENT}</div>
		</div>
		${FOOTER}
	</body>
</html>
			]"
			across
				a_values as ic
			loop
				Result.replace_substring_all ("${"+ ic.key.as_string_8 +"}", ic.item)
			end
		end

end
