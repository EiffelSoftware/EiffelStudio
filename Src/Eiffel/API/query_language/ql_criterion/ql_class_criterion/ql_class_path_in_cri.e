note
	description: "Criterion to test whether or not a class is from a given folder or recursively in its subfolders"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	QL_CLASS_PATH_IN_CRI

inherit
	QL_NAME_CRITERION
		rename
			make as old_make
		redefine
			is_satisfied_by
		end

	QL_CLASS_CRITERION
		redefine
			is_satisfied_by
		end

create
	make,
	make_with_flag

feature{NONE} -- Initialization

	make (a_name: STRING)
			-- Initialize `name' with `a_name'.
			-- Set `is_recursive' to True by default.
		do
			make_with_setting (a_name, True, {QL_NAME_CRITERION}.containing_matching_strategy)
			is_recursive := True
		ensure
			is_recursive_set: is_recursive
		end

	make_with_flag (a_name: STRING; a_recursive: BOOLEAN)
			-- Initialize `name' with `a_name' and `is_recursive' with `a_recursive'.
		do
			make (a_name)
			is_recursive := a_recursive
		ensure
			is_recursive_set: is_recursive = a_recursive
		end

feature -- Evaluate

	is_satisfied_by (a_item: QL_CLASS): BOOLEAN
			-- Evaluate `a_item'.
		local
			l_path: STRING
		do
			l_path := a_item.conf_class.path
			if name.is_empty then
				Result := l_path /= Void and then l_path.is_empty
			else
				if is_recursive then
					Result := l_path.substring (1, name.count).is_equal (name)
				else
					Result := l_path.is_equal (name)
				end
			end
		end

feature -- Status report

	require_compiled: BOOLEAN
			-- Does current criterion require a compiled item?
		do
			Result := False
		end

	is_recursive: BOOLEAN;
			--Is path search recursive?

note
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
