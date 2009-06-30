note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_RESPONSE_LOAD_CALLBACK

inherit
	XRPC_LOAD_CALLBACKS
		redefine
			process_tag_state,
			process_end_tag_state,
			tag_state_transitions
		end

create
	make

feature -- Status report

	is_fault: BOOLEAN
			-- Indicates if the response is a fault response

feature {NONE} -- Process

	process_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			inspect a_state
			when t_fault then
				is_fault := True
			else
				Precursor (a_state)
			end

		end

	process_end_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			Precursor (a_state)
		end

feature {NONE} -- State transistions

	tag_state_transitions: DS_HASH_TABLE [DS_HASH_TABLE [NATURAL_8, STRING], NATURAL_8]
			-- <Precursor>
		local
			l_table: DS_HASH_TABLE [NATURAL_8, STRING]
		once
			Result := Precursor.twin

				-- Override the initial state
			create l_table.make (1)
			l_table.put (t_method_response, {XRPC_CONSTANTS}.method_response_name)
			Result.force (l_table, t_none)

				-- methodResponse
				-- => params
				-- => fault
			create l_table.make (3)
			l_table.put (t_params, {XRPC_CONSTANTS}.params_name)
			l_table.put (t_fault, {XRPC_CONSTANTS}.fault_name)
			Result.put_last (l_table, t_method_response)

				-- fault
				-- => value
			create l_table.make (1)
			l_table.put (t_value, {XRPC_CONSTANTS}.value_name)
			Result.put_last (l_table, t_fault)
		end

feature {NONE} -- Constants: States

	t_fault: NATURAL_8 = 0xF0
	t_method_response: NATURAL_8 = 0xF1

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
