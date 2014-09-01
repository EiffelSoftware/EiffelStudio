note
	description: "Summary description for {CMS_HTML_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_LINE_BREAK_CONVERTER_FILTER

inherit
	CMS_FILTER
		redefine
			help
		end

feature -- Access

	name: STRING_8 = "line_break_converter"

	title: STRING_8 = "Line break converter"

	help: STRING = "Lines and paragraphs break automatically"
	
	description: STRING_8 = "Converts line breaks into HTML (i.e. &lt;br&gt; and &lt;p&gt; tags)."

feature -- Conversion

	filter (a_text: STRING_8)
		do
			a_text.replace_substring_all ("%N", "<br/>%N")
			-- FIXME jfiat [2012/09/12] :also use <p> ...
		end

end
