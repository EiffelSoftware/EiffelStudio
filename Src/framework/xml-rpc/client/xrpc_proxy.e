note
	description: "[
		An XML-RPC proxy for server communcation.
		Clients should make all calls through a proxy or a specialized descendent.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_PROXY

inherit
	XRPC_SHARED_MARSHALLER
		export
			{NONE} all
		end

	XRPC_SHARED_RESPONSE_FACTORY
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_url: READABLE_STRING_8)
			-- Initializes the proxy using an XML-RPC HTTP url.
			--
			-- `a_url': The URL pointing to the XML-RPC service.
		require
			a_url_attached: attached a_url
			not_a_url_is_empty: not a_url.is_empty
			a_url_is_correct: (create {HTTP_URL}.make (a_url)).is_correct
		do
			create url.make (a_url)
		end

feature -- Access

	url: HTTP_URL
			-- URL to post XML-PRC requests to.

feature -- Status report

	is_valid_arguments (a_args: ARRAY [ANY]): BOOLEAN
			-- Determines if a array of arguments contains valid objects for calling an XML-RPC method.
			--
			-- `a_args': Argument array to validate.
			-- `Result': True if the arguments are valid for a method call; False otherwise.
		require
			a_args_attached: attached a_args
		do
			Result := a_args.is_empty or else a_args.for_all (agent marshaller.is_marshallable_object)
		ensure
			a_args_is_empty_or_contains_valid_items: Result implies
				(a_args.is_empty or else a_args.for_all (agent marshaller.is_marshallable_object))
		end

	is_processing_request: BOOLEAN
			-- Indicates if a request is currently being processed.

feature {NONE} -- Helpers

	parser: XM_EIFFEL_PARSER
			-- Parser used to parse XML-RPC requests.
		once
			create Result.make
			Result.set_callbacks (create {XRPC_RESPONSE_LOAD_CALLBACKS}.make (Result))
		ensure
			result_attached: attached Result
			result_callbacks_set: attached {XRPC_RESPONSE_LOAD_CALLBACKS} Result.callbacks
		end

	xml_emitter: XRPC_REQUEST_XML_EMITTER
			-- Shared access to an XML emitter for requests.
		once
			create Result.make
		ensure
			result_attached: attached Result
		end

feature -- Basic operations

	call (a_name: READABLE_STRING_8; a_args: detachable ARRAY [ANY]): detachable XRPC_RESPONSE
			-- Calls a XML-RPC method on the server, at the set URL.
			--
			-- `a_name': Name of the method to call.
			-- `a_args': Optional method arguments, which must match the API argument list.
			-- `Result': A response object or Void if no error occurred and the method does not return any value.
		require
			not_is_processing_request: not is_processing_request
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			--a_args_contains_valid_items: attached a_args implies is_valid_arguments (a_args)
		local
			l_marshaller: like marshaller
			l_args: detachable ARRAY [XRPC_VALUE]
			i, i_upper: INTEGER
		do
			if attached a_args and not a_args.is_empty then
					-- Marsal the arguments to XML-RPC arguments
				l_marshaller := marshaller
				create l_args.make_filled (create {XRPC_DEFAULT_VALUE}, 1, a_args.count)
				from
					i := a_args.lower
					i_upper := a_args.upper
				until
					i > i_upper
				loop
					l_args.put (l_marshaller.marshal_from (a_args[i]), i)
					i := i + 1
				end
			end

				-- Make the call
			on_before_call (a_name, l_args)
			Result := call_internal (a_name, l_args)
			on_after_call (a_name, l_args, Result)
		end

feature {NONE} -- Basic operations

	call_internal (a_name: READABLE_STRING_8; a_args: detachable ARRAY [XRPC_VALUE]): detachable XRPC_RESPONSE
			-- Processes an internal call to a XML-RPC method on the server, at the set URL.
			--
			-- `a_name': Name of the method to call.
			-- `a_args': Optional method arguments, which must match the API argument list.
			-- `Result': A response object or Void if no error occurred and the method does not return any value.
		require
			not_is_processing_request: not is_processing_request
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			not_a_args_is_empty: attached a_args implies not a_args.is_empty
			a_args_is_one_based: attached a_args implies a_args.lower = 1
		local
			l_parser: like parser
			l_emitter: like xml_emitter
			l_protocol: XRPC_PROTOCOL
			l_response: STRING
			retried: BOOLEAN
		do
			if not retried then
					-- Construct a method call string
				l_emitter := xml_emitter
				l_emitter.reset
				l_emitter.is_pretty_printed := False
				l_emitter.process_method_call_request (a_name, a_args)

					-- Make request.
				create l_protocol.make (url, l_emitter.xml)
				l_protocol.open
				if l_protocol.is_open then
					l_protocol.initiate_transfer
					if not l_protocol.error then
						create l_response.make (256)
						from until not l_protocol.is_packet_pending or l_protocol.error loop
							l_protocol.read
							if l_protocol.has_packet and then attached l_protocol.last_packet as l_packet then
								l_response.append (l_packet)
							end
						end

						if not l_response.is_empty and not l_protocol.error then
							l_parser := parser
							l_parser.parse_from_string (l_response)
							if attached {XRPC_RESPONSE_LOAD_CALLBACKS} l_parser.callbacks as l_callbacks then
								Result := l_callbacks.response

									-- There should always be a response, even if there was a parse error.
								check result_attached: attached Result end
							else
									-- For some reason, the right callbacks are not being used.
								Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_internal_error)
							end
						else
								-- An empty response is not valid.
							Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_response_invalid)
						end
					end
					l_protocol.close
				end
				if l_protocol.error and not attached Result then
						-- The connection failed for some reason, report it.
					Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_connection_mask & l_protocol.error_code)
				end
			else
					-- Unexpected failure, report it.
				if attached (create {EXCEPTION_MANAGER}).last_exception as l_exception then
					Result := response_factory.new_response_from_exception (l_exception)
				else
					Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_internal_error)
				end
			end
		rescue
			retried := True
			if attached l_protocol and then l_protocol.is_open then
				l_protocol.close
			end
			retry
		end

feature {NONE} -- Actions handlers

	on_before_call (a_name: READABLE_STRING_8; a_args: detachable ARRAY [XRPC_VALUE])
			-- Called prior to calling an XML-RPC method.
			--
			-- `a_name': The name of the method to be called.
			-- `a_args': Arguments that will be passed to the method on the server.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			not_a_args_is_empty: not a_args.is_empty
		do
		end

	on_after_call (a_name: READABLE_STRING_8; a_args: detachable ARRAY [XRPC_VALUE]; a_response: detachable XRPC_RESPONSE)
			-- Called after calling an XML-RPC method.
			--
			-- `a_name': The name of the method that was just called.
			-- `a_args': Arguments that were passed to the method on the server.
			-- `a_response': A response object, if any.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			not_a_args_is_empty: attached a_args implies not a_args.is_empty
		do
		end

invariant
	url_attached: attached url
	url_is_correct: url.is_correct

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
