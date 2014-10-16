note
	description: "Summary description for {LINE_BREAK_TO_HTML_CONTENT_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LINE_BREAK_TO_HTML_CONTENT_FILTER

inherit
	CONTENT_FILTER
		redefine
			help
		end

feature -- Access

	name: STRING_8 = "line_break_converter"

	title: STRING_8 = "Line break converter"

	help: STRING = "Lines and paragraphs break automatically"
	
	description: STRING_8 = "Converts line breaks into HTML (i.e. <br> and <p> tags)."

feature -- Conversion

	filter (a_text: STRING_8)
		do
			a_text.replace_substring_all ("%N", "<br/>%N")
			-- FIXME jfiat [2012/09/12] :also use <p> ...
		end

end
