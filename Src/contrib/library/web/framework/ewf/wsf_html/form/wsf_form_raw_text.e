note
	description: "Summary description for {WSF_FORM_RAW_TEXT}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_RAW_TEXT

obsolete "Use WSF_WIDGET_TEXT 2013-Sept-06"

inherit
	WSF_WIDGET_TEXT
		rename
			set_text as set_value,
			make_with_text as make
		redefine
			append_to_html
		end

create
	make

feature -- Conversion

	append_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			append_item_html_to (a_theme, a_html)
		end

	append_item_html_to (a_theme: WSF_THEME; a_html: STRING_8)
		do
			a_html.append (text)
		end

end
