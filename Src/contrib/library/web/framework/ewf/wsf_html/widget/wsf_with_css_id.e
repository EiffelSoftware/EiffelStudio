note
	description: "Summary description for {WSF_WITH_CSS_ID}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WSF_WITH_CSS_ID

feature -- Status report

	css_id: detachable READABLE_STRING_8

feature -- Change

	set_css_id (a_id: like css_id)
		require
			is_valid_css_id: is_valid_css_id (a_id)
		do
			css_id := a_id
		end

feature -- Query

	is_valid_css_id (s: detachable READABLE_STRING_8): BOOLEAN
		do
			Result := s /= Void implies (not s.is_empty)
			-- To complete
		end

feature -- Conversion

	append_css_id_to (a_target: STRING)
		do
			if attached css_id as l_id then
				a_target.append (" id=%"")
				a_target.append (l_id)
				a_target.append_character ('%"')
			end
		end

end
