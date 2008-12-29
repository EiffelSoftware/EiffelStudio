note
description: "Objects that convert a path to double quoted path"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SAFE_PATH_BUILDER

feature -- Safe path

	safe_path (a_path: STRING): STRING
			-- Double quoted string from `a_path'.
			-- Use double quote to avoid issue with blank in `a_path'
		do
			if a_path /= Void then
				if not a_path.is_empty then
					if a_path.item (1) /= '"' then
						create Result.make (a_path.count + 2)
						Result.prepend_character ('"')
						Result.append_string (a_path)
						Result.append_character ('"')
					else
						Result := a_path.twin
					end
				else
					create Result.make_empty
				end
			end
		ensure
			Result_not_argument: a_path /= Void implies Result /= a_path
		end

note
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
