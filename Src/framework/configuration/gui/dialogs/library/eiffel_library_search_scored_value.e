note
	description: "Summary description for {EIFFEL_LIBRARY_SEARCH_SCORED_VALUE}."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_LIBRARY_SEARCH_SCORED_VALUE [G]

inherit
	EIFFEL_LIBRARY_SEARCH_ITEM [G]

create
	make

feature {NONE} -- Initialization

	make (a_scored_value: SCORED_VALUE [G]; a_identifier: READABLE_STRING_GENERAL)
		do
			score := a_scored_value.score
			identifier := a_identifier
			object := a_scored_value.value
		end

feature -- Access

	score: REAL

	identifier: READABLE_STRING_GENERAL

	object: G

;note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
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
