indexing
	description: "[
		Priority levels used to signify in basic terms if an entity should have an elevated or lowered priority.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	PRIORITY_LEVELS

feature -- Access

	low: INTEGER_8 = -1
	normal: INTEGER_8 = 0
	high: INTEGER_8 = 1

feature -- Query

	is_valid_priority_level (a_level: INTEGER_8): BOOLEAN
			-- Determines if `a_level' is a valid severity level
			--
			-- `a_level': A severity level
			-- `Result': True to indicate the level of severity is valid; False otherwise.
		do
			Result :=
				a_level = low or
				a_level = normal or
				a_level = high
		ensure
			not_a_level_is_valid: not Result implies a_level /= low and a_level /= normal and a_level /= high
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
