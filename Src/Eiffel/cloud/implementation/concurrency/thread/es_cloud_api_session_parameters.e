note
	description: "Parameters to pass for ES_CLOUD_API feature related to sessions."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_API_SESSION_PARAMETERS

inherit
	TABLE_ITERABLE [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL]

create
	make

feature {NONE} -- Initialization

	make (a_installation_id: READABLE_STRING_8; a_session_id: READABLE_STRING_GENERAL)
		do
			create items.make_caseless (3)
			create installation_id.make_from_string (a_installation_id)
			create session_id.make_from_string_general (a_session_id)
		end

feature -- Access

	installation_id: IMMUTABLE_STRING_8

	session_id: IMMUTABLE_STRING_32

	item alias "[]"(a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_GENERAL assign force
		do
			Result := items [a_name]
		end

	items: STRING_TABLE [READABLE_STRING_GENERAL]

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [READABLE_STRING_GENERAL, READABLE_STRING_GENERAL]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Element change

	force (a_value: READABLE_STRING_GENERAL; a_name: READABLE_STRING_GENERAL)
		do
			items [a_name] := a_value
		end

invariant
note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
