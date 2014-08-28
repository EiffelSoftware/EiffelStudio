note
	description: "Summary description for {CMS_HTML_TO_TEXT_FILTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_HTML_TO_TEXT_FILTER

inherit
	CMS_FILTER

feature -- Access

	name: STRING_8 = "html_to_text"

	title: STRING_8 = "HTML to text"

	description: STRING_8 = "Replaces HTML tags and entities with plain text formatting, moving links at the end. This filter is just for text messages and it isn't safe for rendering content on a web page."

feature -- Conversion

	filter (a_text: STRING_8)
		local
			enc: HTML_ENCODER
			s: STRING_8
		do
			create enc
			s := enc.encoded_string (a_text)
			a_text.wipe_out
			a_text.append (s)
		end

end
