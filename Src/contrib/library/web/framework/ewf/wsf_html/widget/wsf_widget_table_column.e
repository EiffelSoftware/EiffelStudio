note
	description: "Summary description for {WSF_WIDGET_COLUMN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_WIDGET_TABLE_COLUMN

inherit
	WSF_WITH_CSS_CLASS

	WSF_WITH_CSS_STYLE

create
	make

feature {NONE} -- Initialization

	make (i: like index)
		do
			index := i
		end

feature -- Access

	index: INTEGER

	title: detachable READABLE_STRING_32

feature -- Change

	set_title (t: like title)
		do
			title := t
		end

feature -- Conversion

	append_table_header_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			a_html.append ("<th")
			append_css_class_to (a_html, Void)
			append_css_style_to (a_html)
			a_html.append_character ('>')
			if attached title as l_title then
				a_html.append (a_theme.html_encoded (l_title))
			end
			a_html.append ("</th>")
		end

end
