note
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCM_STATUS

inherit
	COMPARABLE

feature {NONE} -- Initialization

	make (loc: PATH)
		do
			location := loc
			is_directory := False
		end

	make_with_name (a_location_name: READABLE_STRING_GENERAL)
		do
			make (create {PATH}.make_from_string (a_location_name))
		end

feature -- Status

	location: PATH

	is_directory: BOOLEAN

	status_as_string: STRING
		deferred
		end

feature -- comp

	is_less alias "<" (other: like Current): BOOLEAN
		do
			Result := location < other.location
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
