note
	description : "[
				Filtered html format
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	FILTERED_HTML_CONTENT_FORMAT

inherit
	CONTENT_FORMAT
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create filters.make (3)
			filters.force (create {URL_CONTENT_FILTER})
			filters.force (create {HTML_CONTENT_FILTER})
			filters.force (create {LINE_BREAK_TO_HTML_CONTENT_FILTER})

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

	filters: ARRAYED_LIST [CONTENT_FILTER]

end

