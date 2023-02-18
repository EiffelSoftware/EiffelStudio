note
	description: "[
		Handles parsing and extraction of an inbound XML-RPC method call request. The handler does not
		handle any form of transport, only parsing and delegation of the method call request, and
		generation of a sound response.
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

	EXCEPTION_MANAGER_FACTORY
		export
			{NONE} all
		end

	ANY

feature {NONE} -- Access

	parser: XML_STOPPABLE_PARSER
			-- Parser used to parse XML-RPC requests.
		once
			create Result.make
			Result.set_callbacks (create {XRPC_REQUEST_LOAD_CALLBACKS}.make (Result))
		end

feature {NONE} -- Helpers

	xml_emitter: XRPC_RESPONSE_XML_EMITTER
			-- Shared access to an XML emitter for responses.
		once
			create Result.make
		ensure
			result_attached: attached Result
		end

feature -- Basic operations

	response_string (a_xml: READABLE_STRING_8; a_dispatcher: XRPC_SERVER_DISPATCHER): STRING
			-- Processes a XML-RPC request and returns a response string.
			--
			-- `a_xml': The XML string to parse.
			-- `a_dispatcher': A dispatch server to process parsed requests on.
			-- `Result': A response string, which may be empty if there was no response by all went well.
		require
			a_xml_attached: attached a_xml
			not_a_xml_is_empty: not a_xml.is_empty
			a_dispatcher_attached: attached a_dispatcher
		local
			l_response: like response
			l_emitter: like xml_emitter
		do
			l_response := response (a_xml, a_dispatcher)
			if attached l_response then
				l_emitter := xml_emitter
				l_emitter.reset
				l_response.visit (l_emitter)
				Result :=  l_emitter.xml
			else
				create Result.make_empty
			end
		ensure
			result_attached: attached Result
		end

	response (a_xml: READABLE_STRING_8; a_dispatcher: XRPC_SERVER_DISPATCHER): detachable XRPC_RESPONSE
			-- Processes a XML-RPC request.
			--
			-- `a_xml': The XML string to parse.
			-- `a_dispatcher': A dispatch server to process parsed requests on.
			-- `Result': A response object, which may be Void if there was no response by all went well.
		require
			a_xml_attached: attached a_xml
			not_a_xml_is_empty: not a_xml.is_empty
			a_dispatcher_attached: attached a_dispatcher
		local
			l_parser: like parser
			l_name: STRING_32
			l_params: detachable CHAIN [XRPC_VALUE]
			retried: BOOLEAN
		do
			if not retried then
				l_parser := parser
				l_parser.parse_from_string (a_xml.as_string_8)
				if attached {XRPC_REQUEST_LOAD_CALLBACKS} l_parser.callbacks as l_callbacks then
					if not l_callbacks.has_error then
						l_name := l_callbacks.method_name
						if not l_name.is_empty then
							if l_callbacks.has_parameters then
								l_params := l_callbacks.method_parameters
							end
							Result := dispatch_call (a_dispatcher, l_name, l_params)
						else
							Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_request_no_method_name)
						end
					else
						Result := response_factory.new_response_from_error_code_and_message ({XRPC_ERROR_CODES}.e_code_request_invalid, l_callbacks.last_error_message)
					end
				else
					check should_never_happen: False end
					Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_internal_error)
				end
			else
				if attached exception_manager.last_exception as l_exception then
					Result := response_factory.new_response_from_exception (l_exception)
				else
					Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_internal_error)
					check exception_occurred_with_no_exception_object: False end
				end
			end
		rescue
			if not retried then
				retried := True
				retry
			end
		end

feature {NONE} -- Basic operations

	dispatch_call (a_dispatcher: XRPC_SERVER_DISPATCHER; a_name: READABLE_STRING_32; a_params: detachable CHAIN [XRPC_VALUE]): detachable XRPC_RESPONSE
			-- Dispatches a call to a server and traps any other erronous conditions prior to execution.
			---
			-- `a_dispatcher': The dispatch server to perform the call on.
			-- `a_name': The name of the method to call.
			-- `a_params': Requested list of parameters.
			-- `Result': A response object.
		require
			a_dispatcher_attached: attached a_dispatcher
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		local
			l_args: detachable ARRAY [XRPC_VALUE]
			l_response: detachable XRPC_RESPONSE
			i: INTEGER
		do
			if attached a_params then
					-- Build argument list.
				create l_args.make_filled (create {XRPC_DEFAULT_VALUE}, 1, a_params.count)
				from a_params.start until a_params.after or attached l_response loop
					i := i + 1
					if attached a_params.item_for_iteration as l_value and then l_value.is_valid then
						l_args.put (l_value, i)
					else
						l_response := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_argument_invalid)
					end
					a_params.forth
				end
				check l_args_are_valid: not attached l_response implies l_args.for_all (agent {XRPC_VALUE}.is_valid) end
			end

			if not attached l_response then
					-- Perform the call
				Result := a_dispatcher.call (a_name, l_args)
			else
				Result := l_response
			end
		ensure
			result_attached: attached Result
		end

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
