note
	description: "Summary description for {MISSING_CMS_TEMPLATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MISSING_CMS_TEMPLATE

inherit

	CMS_TEMPLATE

create
	make

feature {NONE} -- Implementation

	make ( a_theme: MISSING_CMS_THEME)
		do
			theme := a_theme
		end

feature -- Access

	theme: MISSING_CMS_THEME

	variables: STRING_TABLE [detachable ANY]
		do
			create Result.make (0)
		end

	prepare (page: CMS_HTML_PAGE)
		do
		end

	to_html (page: CMS_HTML_PAGE): STRING
		do
			Result := " "
		end

end
