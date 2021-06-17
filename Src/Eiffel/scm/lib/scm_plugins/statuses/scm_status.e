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
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
end
