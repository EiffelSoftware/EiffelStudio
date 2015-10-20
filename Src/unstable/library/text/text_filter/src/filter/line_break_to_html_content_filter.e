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

	filter (a_text: STRING_GENERAL)
		do
			if attached {STRING_8} a_text as s8 then
				s8.replace_substring_all ("%N", "<br/>%N")
			elseif attached {STRING_32} a_text as s32 then
				s32.replace_substring_all ({STRING_32} "%N", {STRING_32} "<br/>%N")
			end
			-- FIXME jfiat [2012/09/12] :also use <p> ...
		end

end
