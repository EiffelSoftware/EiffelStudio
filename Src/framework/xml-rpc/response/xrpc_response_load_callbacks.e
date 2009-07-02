note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_RESPONSE_LOAD_CALLBACKS

inherit
	XRPC_LOAD_CALLBACKS
		redefine
			reset,
			process_tag_state,
			process_end_tag_state,
			on_finish,
			on_error,
			new_tag_state_transitions
		end

	XRPC_SHARED_RESPONSE_FACTORY
		export
			{NONE} all
		end

create
	make

feature -- Access

	response: detachable XRPC_RESPONSE
			-- Response generated from last parse.
			-- If the parse was unsuccessful then a response will be available, indicating the error.

feature {NONE} -- Status report

	is_fault: BOOLEAN
			-- Indicates if the response is a fault response

feature {NONE} -- Basic operations

	reset
			-- <Precursor>
		do
			is_fault := False
			response := Void
		ensure then
			not_is_fault: not is_fault
			response_detached: not attached response
		end

feature {NONE} -- Process

	process_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			inspect a_state
			when t_fault then
				is_fault := True
			when t_params then
				if is_fault then
					on_report_xml_error (e_schema_error)
				else
					Precursor (a_state)
				end
			when t_param then
				if has_parameters and then currrent_parameters.count = 1 then
					on_report_xml_error (e_schema_error)
				else
					Precursor (a_state)
				end
			else
				Precursor (a_state)
			end

		end

	process_end_tag_state (a_state: NATURAL_8)
			-- <Precursor>
		do
			Precursor (a_state)
		end

	on_finish
			-- <Precursor>
		do
			Precursor
			if not has_error then
				if is_fault then
					if not has_parameters and then not current_value_stack.is_empty then
						if
							attached {XRPC_STRUCT} current_value as l_struct and then
							l_struct.has_member ({XRPC_CONSTANTS}.fault_code_value) and then
							attached {XRPC_INTEGER} l_struct[{XRPC_CONSTANTS}.fault_code_value] as l_code and then
							l_struct.has_member ({XRPC_CONSTANTS}.fault_string_value) and then
							attached {XRPC_STRING} l_struct[{XRPC_CONSTANTS}.fault_code_value] as l_message
						then
							response := response_factory.new_response_from_error_code_and_message (l_code.value, l_message.value)
						else
							on_report_xml_error (e_schema_error)
						end
					else
						on_report_xml_error (e_schema_error)
					end
				else
					if has_parameters then
						if attached parameters.first as l_value then
							response := response_factory.new_response_from_value (l_value)
						else
							on_report_xml_error (e_schema_error)
						end
					else
						on_report_xml_error (e_schema_error)
					end
				end
			end
		end

	on_error (a_msg: READABLE_STRING_GENERAL; a_line: NATURAL_32; a_index: NATURAL_32)
			-- <Precursor>
		do
			Precursor (a_msg, a_line, a_index)
			is_fault := True
			response := response_factory.new_response_from_error_code_and_message ({XRPC_ERROR_CODES}.e_code_response_invalid, a_msg.as_string_8)
		end

feature {NONE} -- State transistions

	new_tag_state_transitions: DS_HASH_TABLE [DS_HASH_TABLE [NATURAL_8, STRING], NATURAL_8]
			-- <Precursor>
		local
			l_table: DS_HASH_TABLE [NATURAL_8, STRING]
		do
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
