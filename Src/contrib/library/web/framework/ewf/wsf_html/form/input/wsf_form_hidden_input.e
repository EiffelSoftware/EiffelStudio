note
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_HIDDEN_INPUT

inherit
	WSF_FORM_INPUT
		redefine
			append_item_to_html
		end

create
	make,
	make_with_text

feature -- Access

	input_type: STRING
		once
			Result := "hidden"
		end

feature -- Conversion

	append_item_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			a_html.append ("<div style=%"display:none%">")
			Precursor (a_theme, a_html)
			a_html.append ("</div>")
		end

end
