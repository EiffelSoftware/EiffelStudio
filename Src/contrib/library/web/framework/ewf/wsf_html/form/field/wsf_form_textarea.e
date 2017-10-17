note
	description: "Summary description for {WSF_FORM_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_FORM_TEXTAREA

inherit
	WSF_FORM_FIELD

create
	make

feature {NONE} -- Initialization

	make (a_name: like name)
		do
			name := a_name
		end

feature -- Access

	default_value: detachable READABLE_STRING_32

	rows: INTEGER

	cols: INTEGER

feature -- Element change

	set_rows (i: like rows)
		do
			rows := i
		end

	set_cols (i: like cols)
		do
			cols := i
		end

	set_text_value (s: like default_value)
		do
			set_default_value (s)
		end

	set_value (v: detachable WSF_VALUE)
		do
			if attached {WSF_STRING} v as s then
				set_text_value (s.value)
			else
				set_text_value (Void)
			end
		end

	set_default_value (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void then
				default_value := Void
			else
				default_value := v.as_string_32
			end
		end

feature -- Conversion

	append_item_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			a_html.append ("<textarea name=%""+ name +"%"")
			if rows > 0 then
				a_html.append (" rows=%"" + rows.out + "%"")
			end
			if cols > 0 then
				a_html.append (" cols=%"" + cols.out + "%"")
			end

			append_css_class_to (a_html, Void)
			append_css_id_to (a_html)
			append_css_style_to (a_html)

			if is_readonly then
				a_html.append (" readonly=%"readonly%">")
			else
				a_html.append (">")
			end
			if attached default_value as dft then
				a_html.append (a_theme.html_encoded (dft))
			end
			a_html.append ("</textarea>")
		end

end
