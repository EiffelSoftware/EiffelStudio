note
	description: "Summary description for {FOO_CRITERIA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FOO_CRITERIA

inherit
	CRITERIA_WITH_NAME [FOO]

create
	make

feature {NONE} -- Initialization

	make (v: like bar)
			-- Initialize `Current'.
		do
			set_criteria_name ("foo")
			bar := v
		end

	bar: BAR

feature -- Access	

	criteria_value: READABLE_STRING_32
			-- Associated criteria value.
		do
			create {STRING_32} Result.make_from_string_general (bar.value)
		end

feature -- Status

	meet (t: FOO): BOOLEAN
		do
			Result := t.bar ~ bar
		end


note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
