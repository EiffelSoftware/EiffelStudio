note
	description : "[
				Plain Text format
			]"
	date        : "$Date$"
	revision    : "$Revision$"

class
	CMS_PLAIN_TEXT_FORMAT

inherit
	CMS_FORMAT
		redefine
			default_create,
			help
		end

feature {NONE} -- Initialization

	default_create
		do
			Precursor
			create filters.make (2)
			filters.force (create {CMS_HTML_TO_TEXT_FILTER})
			filters.force (create {CMS_LINE_BREAK_CONVERTER_FILTER})
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

	filters: ARRAYED_LIST [CMS_FILTER]

end
