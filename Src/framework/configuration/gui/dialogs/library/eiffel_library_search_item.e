note
	description: "[
			Search results item.
		]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EIFFEL_LIBRARY_SEARCH_ITEM [G]

inherit
	COMPARABLE

	DEBUG_OUTPUT
		undefine
			is_equal
		end

feature -- Access

	score: REAL
		deferred
		end

	object: G
		deferred
		end

	identifier: READABLE_STRING_GENERAL
		deferred
		end

feature -- Status report	

	is_less alias "<" (other: like Current): BOOLEAN
			-- <Precursor>
		do
			if score = other.score then
				Result := identifier.as_string_32 < other.identifier.as_string_32
			else
				Result := score <= other.score
			end
		end

	debug_output: STRING_32
			-- <Precursor>.
		do
			create Result.make (5)
			Result.append_character ('[')
			Result.append (score.out)
			Result.append_character (']')
			if attached {DEBUG_OUTPUT} object as dbg then
				Result.append_string_general (dbg.debug_output)
			end
		end

invariant
	valid_score: score >= 0

note
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
