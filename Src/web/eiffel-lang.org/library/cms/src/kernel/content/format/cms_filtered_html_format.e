note
	description : "[
				Filtered html format
			]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	CMS_FILTERED_HTML_FORMAT

inherit
	CMS_FORMAT
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create filters.make (3)
			filters.force (create {CMS_URL_FILTER})
			filters.force (create {CMS_HTML_FILTER})
			filters.force (create {CMS_LINE_BREAK_CONVERTER_FILTER})

--			help := "<ul><li>Web page addresses and e-mail addresses turn into links automatically.</li><li>Allowed HTML tags: "
--			across
--				allowed_html_tags as c
--			loop
--				help.append ("&lt;" + c.item + "&gt; ")
--			end
--			help.append ("</li><li>Lines and paragraphs break automatically.</li></ul>")
		end

feature -- Access

	name: STRING = "filtered_html"

	title: STRING_8 = "Filtered HTML"

	filters: ARRAYED_LIST [CMS_FILTER]

end
