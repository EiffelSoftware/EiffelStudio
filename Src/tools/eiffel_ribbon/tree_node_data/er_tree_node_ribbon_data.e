note
	description: "[
					Ribbon tree node data
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_TREE_NODE_RIBBON_DATA

inherit
	ER_TREE_NODE_DATA
		redefine
			new_unique_command_name
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			command_name_prefix := "ribbon_"
			xml_constants := {ER_XML_CONSTANTS}.ribbon
			new_unique_command_name
		end

feature -- Implementation

	new_unique_command_name
			-- Initialize a command name automatically
		local
			l_shared: ER_SHARED_TOOLS
			l_command_name: STRING
			l_count: INTEGER
		do
				-- Count how many layout constructors
			create l_shared

			l_count := l_shared.layout_constructor_list.count

				-- check if the command name conflict with others'
			from
				l_command_name := command_name_prefix + l_count.out
			until
				not is_layout_constructor_name_conflict (l_shared.layout_constructor_list, l_command_name)
			loop
				l_count := l_count + 1
				l_command_name := command_name_prefix + l_count.out
			end
			set_command_name (l_command_name)
		end

	is_layout_constructor_name_conflict (a_all_constructors: ARRAYED_LIST [ER_LAYOUT_CONSTRUCTOR]; a_command_name: STRING): BOOLEAN
			-- Is layout contructor's `a_name' conflict with `a_all_constructors's ?
		require
			not_void: a_all_constructors /= Void
			valid: a_command_name /= Void and then not a_command_name.is_empty
		do
			from
				a_all_constructors.start
			until
				a_all_constructors.after or Result
			loop
				if attached {ER_TREE_NODE_RIBBON_DATA} a_all_constructors.item.widget.data as l_data then
					if attached l_data.command_name as l_command_name then
						Result := l_command_name.same_string (a_command_name)
					end
				end
				a_all_constructors.forth
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
