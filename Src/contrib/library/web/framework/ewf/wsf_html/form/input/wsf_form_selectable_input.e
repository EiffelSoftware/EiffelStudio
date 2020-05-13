note
	description: "Summary description for {WSF_FORM_SELECTABLE_INPUT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_FORM_SELECTABLE_INPUT

inherit
	WSF_FORM_INPUT
		rename
			default_value as value,
			make_with_text as make_with_value
		redefine
			set_value,
			specific_input_attributes_string,
			append_item_to_html
		end

	WSF_FORM_SELECTABLE_ITEM
		rename
			is_selected as checked,
			set_is_selected as set_checked
		end

feature -- Access

	checked: BOOLEAN
			-- Current <input> element should be preselected when the page loads

	title: detachable READABLE_STRING_32

	raw_title: detachable READABLE_STRING_8

feature -- Status report

	is_same_value (v: READABLE_STRING_32): BOOLEAN
		do
			Result := attached value as l_value and then v.same_string (l_value)
		end

feature -- Change

	set_title (t: detachable READABLE_STRING_32)
		do
			title := t
		end

	set_raw_title (t: detachable READABLE_STRING_8)
		do
			raw_title := t
		end

	set_checked (b: like checked)
		do
			checked := b
		end

	set_checked_by_value (v: detachable WSF_VALUE)
		do
			if attached {WSF_STRING} v as s then
				if value /= Void then
					set_checked (is_same_value (s.value))
				else
					set_checked (s.value.same_string ("on") or s.value.same_string ("true") or s.value.same_string ("yes") or s.value.same_string ("enabled"))
				end
			else
				set_checked (False)
			end
		end

	set_value (v: detachable WSF_VALUE)
			-- Set value `v' if applicable to Current
		local
			l_found: BOOLEAN
		do
			if attached {ITERABLE [WSF_VALUE]} v as lst then
				across
					lst as c
				until
					l_found
				loop
					if attached {WSF_STRING} c.item as s and then is_same_value (s.value) then
						set_checked_by_value (c.item)
						l_found := True
					end
				end
				if not l_found then
					set_checked (False)
				end
			else
				set_checked_by_value (v)
				Precursor (v)
			end
		end		

feature {NONE} -- Implementation

	append_item_to_html (a_theme: WSF_THEME; a_html: STRING_8)
		do
			Precursor (a_theme, a_html)
			append_label_to_html (a_theme, a_html)
		end

	append_label_to_html (a_theme: WSF_THEME; a_html: STRING_8)
			-- Specific label element if any.	
		local
			s: READABLE_STRING_8
		do
			if attached raw_title as t then
				s := t
			elseif attached title as t then
				s := a_theme.html_encoded (t)
			end
			if s /= Void then
				if attached css_id as l_id then
					a_html.append ("<label for=%""+ l_id +"%">")
				else
					a_html.append ("<label>")
				end
				a_html.append (s)
				a_html.append ("</label>")
			end
		end

	specific_input_attributes_string: detachable STRING_8
			-- Specific input attributes if any.	
			-- To redefine if needed
		do
			if checked then
				Result := "checked=%"checked%""
			end
		end

invariant

end
