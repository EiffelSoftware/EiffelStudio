note
	description: "Summary description for {HTML_TO_TEXT_CONTENT_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_TO_TEXT_CONTENT_FILTER

inherit
	CONTENT_FILTER

	STRING_HANDLER

feature -- Access

	name: STRING_8 = "html_to_text"

	title: STRING_8 = "HTML to text"

	description: STRING_8 = "Replaces HTML tags and entities with plain text formatting, moving links at the end. This filter is just for text messages and it isn't safe for rendering content on a web page."

feature -- Conversion

	filter (a_text: STRING_GENERAL)
		local
			enc: HTML_ENCODER
			s: STRING_8
		do
			create enc
			s := enc.encoded_string (a_text)
			a_text.set_count (0)
			a_text.append (s)
		end

end
