note
	description: "Summary description for {DEBUGGER_EXECUTION_PROFILE_GROUP}."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_EXECUTION_PROFILE_GROUP

create
	make,
	make_without_title

feature {NONE} -- Initialization

	make_without_title
		do
			create title.make_empty
		end

	make (a_title: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (a_title)
		end

feature -- Access

	title: IMMUTABLE_STRING_32

feature -- Status

	same_as (g: DEBUGGER_EXECUTION_PROFILE_GROUP): BOOLEAN
		do
			Result := title.same_string (g.title)
		end

feature -- Element change

	set_title (v: detachable READABLE_STRING_GENERAL)
			-- Assign `title` with `v`.
		do
			if v = Void then
				create title.make_empty
			else
				title := v
			end
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
