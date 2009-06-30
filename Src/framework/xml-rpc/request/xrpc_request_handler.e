note
	description: "[
		Handles an incoming XML-RPC request.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_REQUEST_HANDLER

inherit
	XRPC_SHARED_RESPONSE_FACTORY
		export
			{NONE} all
		end

	EXCEPTION_MANAGER
		export
			{NONE} all
		end

	ANY

feature {NONE} -- Access

	parser: XM_EIFFEL_PARSER
			-- Parser used to parse XML-RPC requests
		once
			create Result.make
			Result.set_callbacks (create {XRPC_REQUEST_LOAD_CALLBACKS}.make (Result))
		end

feature -- Basic operations

	process (a_xml: READABLE_STRING_8; a_server: XRPC_SERVER_DISPATCHER): XRPC_RESPONSE
		require
			a_xml_attached: attached a_xml
			not_a_xml_is_empty: not a_xml.is_empty
		local
			l_parser: like parser
			l_name: STRING
			l_params: detachable DS_LINEAR [XRPC_VALUE]
			retried: BOOLEAN
		do
			if not retried then
				l_parser := parser
				l_parser.parse_from_string (a_xml.as_string_8)
				if not l_parser.syntax_error then
					if attached {XRPC_REQUEST_LOAD_CALLBACKS} l_parser.callbacks as l_callbacks then
						if not l_callbacks.has_error then
							l_name := l_callbacks.method_name
							if l_callbacks.has_parameters then
								l_params := l_callbacks.method_parameters
							end
							Result := process_request (l_name, l_params, a_server)
						else
							Result :=
							create {XRPC_FAULT_RESPONSE} Result.make (1, l_callbacks.last_error_message)
						end
					else
						check should_never_happen: False end
						create {XRPC_FAULT_RESPONSE} Result.make (1, {XRPC_ERROR_CODES}.e_internal_error)
					end
				else
					if attached l_parser.last_error_description as l_error then
						create {XRPC_FAULT_RESPONSE} Result.make (1, l_error)
					else
						create {XRPC_FAULT_RESPONSE} Result.make (1, {XRPC_ERROR_CODES}.e_syntax_error)
					end
				end
			else
				create {XRPC_FAULT_RESPONSE} Result.make (1, "Error!")
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Basic operations

	process_request (a_server: XRPC_SERVER_DISPATCHER; a_name: READABLE_STRING_8; a_params: detachable DS_LINEAR [XRPC_VALUE]): XRPC_RESPONSE
			--
		require
			a_server_attached: attached a_server
			a_name_attached: attached a_name
		local
			l_args: detachable ARRAY [XRPC_VALUE]
			l_response: detachable XRPC_RESPONSE
			i: INTEGER
		do
			if not a_name.is_empty then
				if attached a_params then
						-- Build argument list.
					create l_args.make_filled (create {XRPC_DEFAULT_VALUE}, 1, a_params.count)
					from a_params.start until a_params.after or attached l_response loop
						i := i + 1
						if attached a_params.item_for_iteration as l_value and then l_value.is_valid then
							l_args.put (l_value, i)
						else
							create {XRPC_FAULT_RESPONSE} l_response.make (1, {XRPC_ERROR_CODES}.e_invalid_parameter_1)
						end
						a_params.forth
					end
					check l_args_are_valid: not attached l_response implies l_args.for_all (agent {XRPC_VALUE}.is_valid) end
				end

					-- Perform the call
				if not attached l_response then
					Result := a_server.call (a_name, l_args)
				else
					Result := l_response
				end
			else
				create {XRPC_FAULT_RESPONSE} Result.make (1, {XRPC_ERROR_CODES}.e_request_no_method_name)
			end
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
