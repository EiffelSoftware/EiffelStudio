indexing
	description: "Parser to parse ec actions from given argument. Produces ec command as string that EiffelStudio knows."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EC_ACTION_PARSER

inherit
	COMMAND_PROTOCOL_NAMES

feature -- Action

	parse (a_string: !STRING) is
			-- Parse `a_string' to produce `last_command'
			--| Incoming example:
			--| eisi:eiffel://project=base.6D7FF712-BBA5-4AC0-AABF-2D9880493A01&target=base&cluster=ise&class=exception&feature=raise
			--| result command example:	
			--| <com.eiffel.compiler><project_ready><com.eiffel.eis_incoming>
			--| <eiffel://project=base.6D7FF712-BBA5-4AC0-AABF-2D9880493A01&target=base&cluster=ise&class=exception&feature=raise>
		local
			l_string: !STRING
			l_result: ?STRING
			l_prefix_count: INTEGER
		do
			last_command := Void
			l_prefix_count := eis_incoming.count
			if a_string.count > l_prefix_count and then a_string.substring (1, l_prefix_count).is_case_insensitive_equal (eis_incoming) then
				l_string := a_string.twin
					-- Remove "eisi:"
				l_string.remove_head (l_prefix_count)

				l_result := label (compiler_module)
				l_result.append (label (project_ready))
				l_result.append (label (eis_incoming_module))
				l_result.append (label (l_string))
			end
			last_command := l_result
		end

feature -- Access

	last_command: ?STRING
			-- Last commans string for EiffelStudio

feature {NONE} -- Implementation

	label (a_content: !STRING): !STRING is
			-- A label: <a_content>
		do
			Result := a_content.twin
			Result.prepend_character (left_angle_bracket)
			Result.append_character (right_angle_bracket)
		end

feature {NONE} -- Implementation

	eis_incoming: !STRING = "eisi:"

	left_angle_bracket: CHARACTER = '<'

	right_angle_bracket: CHARACTER = '>';

indexing
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
