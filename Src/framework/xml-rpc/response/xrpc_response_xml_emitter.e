note
	description: "[
		Emits an XML-RPC XML from the core set of XML-RPC data types and values, as well as XML-RPC
		responses.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_RESPONSE_XML_EMITTER

inherit
	XRPC_RESPONSE_VISITOR
		undefine
			process_array,
			process_boolean,
			process_double,
			process_integer,
			process_member,
			process_string,
			process_struct
		redefine
			process_fault_response,
			process_value_response
		end

	XRPC_XML_EMITTER

create
	make

feature -- Processing operations

	process_fault_response (a_response: XRPC_FAULT_RESPONSE)
			-- <Precursor>
		do
			append_opening_tag ({XRPC_CONSTANTS}.method_response_name, buffer, True)
			append_opening_tag ({XRPC_CONSTANTS}.fault_name, buffer, True)
			Precursor (a_response)
			append_closing_tag ({XRPC_CONSTANTS}.fault_name, buffer, True)
			append_closing_tag ({XRPC_CONSTANTS}.method_response_name, buffer, True)
		end

	process_value_response (a_response: XRPC_VALUE_RESPONSE)
			-- <Precursor>
		do
			append_opening_tag ({XRPC_CONSTANTS}.method_response_name, buffer, True)
			append_opening_tag ({XRPC_CONSTANTS}.params_name, buffer, True)
			append_opening_tag ({XRPC_CONSTANTS}.param_name, buffer, True)
			Precursor (a_response)
			append_closing_tag ({XRPC_CONSTANTS}.param_name, buffer, True)
			append_closing_tag ({XRPC_CONSTANTS}.params_name, buffer, True)
			append_closing_tag ({XRPC_CONSTANTS}.method_response_name, buffer, True)
		end

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
