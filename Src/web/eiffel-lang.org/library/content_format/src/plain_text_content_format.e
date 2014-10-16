note
	description : "[
				Plain Text format
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	PLAIN_TEXT_CONTENT_FORMAT

inherit
	CONTENT_FORMAT
		redefine
			default_create,
			help
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create filters.make (2)
			filters.force (create {HTML_TO_TEXT_CONTENT_FILTER})
			filters.force (create {LINE_BREAK_TO_HTML_CONTENT_FILTER})
		end


feature -- Access

	name: STRING = "plain_text"

	title: STRING_8 = "Plain text"

	help: STRING
		do
			Result := "<li>No HTML tags allowed.</li>"
			Result.append (Precursor)
		end
--		<ul>
--    	<li>No HTML tags allowed.</li>
--		<li>Web page addresses and e-mail addresses turn into links automatically.</li>
--		<li>Lines and paragraphs break automatically.</li>
--		</ul>
--		]"

	filters: ARRAYED_LIST [CONTENT_FILTER]

end
