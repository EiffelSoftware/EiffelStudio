note
	description: "Summary description for {WSF_WITH_HTML_ATTRIBUTE}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_WITH_HTML_ATTRIBUTE

feature -- Status report

	html_attributes: detachable HASH_TABLE [detachable READABLE_STRING_8, STRING_8]

feature -- Change

	reset_html_attributes
		do
			html_attributes := Void
		end

	add_html_attribute (a_name: READABLE_STRING_8; a_value: detachable READABLE_STRING_8)
		require
			is_valid_attribute_name: is_valid_attribute_name (a_name)
			is_valid_attribute_value: is_valid_attribute_value (a_value)
		local
			lst: like html_attributes
		do
			lst := html_attributes
			if lst = Void then
				create lst.make (1)
				lst.compare_objects
				html_attributes := lst
			end
			lst.force (a_value, a_name.to_string_8)
		end

	remove_html_attribute (a_name: READABLE_STRING_8)
		require
			is_valid_attribute_name: is_valid_attribute_name (a_name)
		local
			lst: like html_attributes
		do
			lst := html_attributes
			if lst /= Void then
				lst.remove (a_name.to_string_8)
			end
		end

feature -- Query

	is_valid_attribute_name (s: detachable READABLE_STRING_8): BOOLEAN
		do
			Result := s /= Void implies (not s.is_empty)
			-- To complete
		end

	is_valid_attribute_value (s: detachable READABLE_STRING_8): BOOLEAN
		do
			Result := s /= Void implies (not s.has ('%"'))
			-- To complete
		end

feature -- Conversion

	append_html_attributes_to (a_target: STRING)
		do
			if attached html_attributes as attribs then
				across
					attribs as c
				loop
					a_target.append (" " + c.key)
					if attached c.item as v then
						a_target.append_character ('=')
						a_target.append_character ('%"')
						a_target.append (v)
						a_target.append_character ('%"')
					end
				end
			end
		end

end
