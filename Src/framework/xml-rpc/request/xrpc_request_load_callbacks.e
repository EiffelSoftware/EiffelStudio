note
	description: "[
		XML callbacks for parsing incoming XML-RPC method call requests.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_REQUEST_LOAD_CALLBACKS

inherit
	XRPC_LOAD_CALLBACKS
		rename
			parameters as method_parameters
		export
			{NONE} value
		redefine
			initialize,
			reset,
			process_end_tag_state,
			new_tag_state_transitions
		end

create
	make

feature {NONE} -- Initialization

	initialize
			-- <Precursor>
		do
			create method_name.make_empty
			Precursor
		end

feature -- Access

	method_name: STRING_32
			-- Name of the method to call.

feature {NONE} -- Basic operations

	reset
			-- <Precursor>
		do
			create method_name.make_empty
			Precursor
		ensure then
			method_name_is_empty: method_name.is_empty
			method_name_different_object: method_name /= old method_name
		end

feature {NONE} -- Process

	process_end_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			inspect a_state
			when t_method_name then
					-- Set method name, but first wipe it out in case there are duplicate entries.
				method_name.wipe_out
				method_name.append (current_content)
			else
				Precursor (a_state)
			end
		end

feature {NONE} -- Factory

	new_tag_state_transitions: HASH_TABLE [HASH_TABLE [NATURAL_8, STRING_32], NATURAL_8]
			-- <Precursor>
		local
			l_table: like new_tag_state_transitions.item
		do
			Result := Precursor

				-- Override the initial state
			create l_table.make (1)
			l_table.put (t_method_call, {XRPC_CONSTANTS}.method_call_name)
			Result.force (l_table, t_none)

				-- methodCall
				-- => methodName
				-- => params
			create l_table.make (3)
			l_table.put (t_method_name, {XRPC_CONSTANTS}.method_name_name)
			l_table.put (t_params, {XRPC_CONSTANTS}.params_name)
			Result.force (l_table, t_method_call)
		end

feature {NONE} -- Constants: States

	t_method_call: NATURAL_8 = 0xA0
	t_method_name: NATURAL_8 = 0xA1

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
