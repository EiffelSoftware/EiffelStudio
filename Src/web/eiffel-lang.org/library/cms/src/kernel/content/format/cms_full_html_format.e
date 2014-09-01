note
	description : "[
				Full html format
			]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	CMS_FULL_HTML_FORMAT

inherit
	CMS_FORMAT
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create filters.make (2)
			filters.force (create {CMS_URL_FILTER})
			filters.force (create {CMS_LINE_BREAK_CONVERTER_FILTER})
		end

feature -- Access

	name: STRING = "full_html"

	title: STRING_8 = "Full HTML"

	filters: ARRAYED_LIST [CMS_FILTER]

end
