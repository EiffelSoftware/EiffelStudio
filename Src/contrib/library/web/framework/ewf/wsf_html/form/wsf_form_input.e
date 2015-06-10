note
	description: "Summary description for {WSF_FORM_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_FORM_INPUT

inherit
	WSF_FORM_FIELD

	WSF_FORM_INPUT_WITH_HTML5

feature {NONE} -- Initialization

	make (a_name: like name)
		do
			name := a_name
		end

	make_with_text (a_name: like name; a_text: READABLE_STRING_32)
		do
			make (a_name)
			set_text_value (a_text)
		end

feature -- Access

	default_value: detachable READABLE_STRING_32

	size: INTEGER
			-- Width, in characters, of an <input> element.

	maxlength: INTEGER
			-- Maximum number of characters allowed in an <input> element.

	disabled: BOOLEAN
			-- Current <input> element should be disabled?

	input_type: STRING
		deferred
		end

feature -- Element change

	set_text_value (s: detachable READABLE_STRING_32)
		do
			set_default_value (s)
		end

	set_size (i: like size)
		do
			size := i
		end

	set_maxlength (i: like maxlength)
		do
			maxlength := i
		end

	set_disabled (b: like disabled)
		do
			disabled := b
		end

	set_value (v: detachable WSF_VALUE)
		do
			if attached {WSF_STRING} v as s then
				set_text_value (s.value)
			else
				set_text_value (Void)
			end
		end

	set_default_value (v: like default_value)
		do
			default_value := v
		end

feature -- Conversion

	append_item_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		local
			old_count: INTEGER
		do
			a_html.append ("<input type=%""+ input_type +"%" name=%""+ name +"%"")
			append_css_class_to (a_html, Void)
			append_css_id_to (a_html)
			append_css_style_to (a_html)
			append_html5_input_attributes_to (a_theme, a_html)

			if is_readonly then
				a_html.append (" readonly=%"readonly%"")
			end
			if attached default_value as dft then
				a_html.append (" value=%"" + a_theme.html_encoded (dft) + "%"")
			end
			if disabled then
				a_html.append (" disabled=%"disabled%"")
			end
			if size > 0 then
				a_html.append (" size=%"" + size.out + "%"")
			end
			if maxlength > 0 then
				a_html.append (" maxlength=%"" + maxlength.out + "%"")
			end

			if attached specific_input_attributes_string as s then
				a_html.append_character (' ')
				a_html.append (s)
			end
			a_html.append (">")
			old_count := a_html.count
			append_child_to_html (a_theme, a_html)
			if a_html.count > old_count then
				a_html.append ("</input>")
			else
				check a_html.item (a_html.count) = '>' end
				a_html.put ('/', a_html.count) -- replace previous '>'
				a_html.append (">")
			end
		end

feature {NONE} -- Implementation

	append_child_to_html (a_theme: WSF_THEME; a_html: STRING_8)
			-- Specific child element if any.	
			--| To redefine if needed
		do
		end

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			--| To redefine if needed
		do
			-- TODO: should we consider to use theme?
		end

end
