note
	description: "[
		A registeration server to register call delegate objects. Once registered calls may be routed
		through the dispatcher to the approrate call delegate object.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_SERVER_DISPATCHER

inherit
	ANY

	XRPC_SHARED_MARSHALLER
		export
			{NONE} all
		end

	XRPC_SHARED_RESPONSE_FACTORY
		export
			{NONE} all
		end

	XRPC_SHARED_UTILITIES
		export
			{NONE} all
		end

	EXCEPTION_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the XML-RPC dispatch server.
		do
			create delegates.make (1)
			create built_ins
			delegates.extend (built_ins)
		end

feature {NONE} -- Access

	built_ins: XRPC_BUILT_IN_DELEGATE
			-- Built in delegate for internal functions.

	delegates: ARRAYED_LIST [XRPC_DELEGATE]
			-- Managed list of delegates to perform API calls on.

feature -- Status report

	is_case_sensitive: BOOLEAN
			-- Indicates if method name lookup respects case sensitive, by default for all delegates.
			-- Note: Delegates can set their own case sensitivity.
		do
				-- It's Eiffel so by default there is no case sensitivity.
			Result := False
		end

	has (a_delegate: XRPC_DELEGATE): BOOLEAN
			-- Detemines if a delegate is already is available on the dispatcher.
			--
			-- `a_delegate': The delegate to determine the presence of.
			-- `Result': True if the delegate is present in the dispatcher; False otherwise.
		require
			a_delegate_attached: attached a_delegate
		do
			Result := delegates.has (a_delegate)
		ensure
			delegates_has_a_delegate: Result implies delegates.has (a_delegate)
		end

feature -- Query

	delegate_for_method (a_name: READABLE_STRING_32): detachable TUPLE [delegate: XRPC_DELEGATE; name: READABLE_STRING_32]
			-- Attempts to locate a responding delegate for a given method name.
			--
			-- `a_name': A method name to retrieve a responding delegate for.
			-- `Result': A responding delegate.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		local
			l_delegates: ARRAYED_LIST [XRPC_DELEGATE]
			l_cursor: CURSOR
			l_parts: TUPLE [name: STRING_32; namespace: detachable STRING_32]
			l_namespace: detachable READABLE_STRING_32
			l_name: READABLE_STRING_32
		do
			l_delegates := delegates
			l_cursor := l_delegates.cursor

				-- Search in the global (no) namespace first.
			from l_delegates.start until l_delegates.after or Result /= Void loop
				if attached l_delegates.item as l_delegate then
					if l_delegate.namespace = Void and then l_delegate.has_method (a_name) then
						Result := [l_delegate, a_name]
					end
				end
				l_delegates.forth
			end

				-- Next try delegates with set namespaces.
			if Result = Void then
				l_parts := utilities.split_method_name (a_name)
				l_namespace := l_parts.namespace
				l_name := l_parts.name
				if l_namespace /= Void then
					from l_delegates.start until l_delegates.after or Result /= Void loop
						if attached l_delegates.item as l_delegate then
							if
								attached l_delegate.namespace as l_other_namespace and then
								l_other_namespace.same_string (l_namespace)
							then
								if l_delegate.has_method (l_name) then
									Result := [l_delegate, l_name]
								end
							end
						end
						l_delegates.forth
					end
				end
			end

			l_delegates.go_to (l_cursor)
		end

feature {NONE} -- Query: Marshalling

	marshal_routine_arguments (a_agent: ROUTINE; a_args: ARRAY [XRPC_VALUE]): TUPLE
			-- Marshals a routine's arguments and returns a tuple callable with the supplied routine.
			--
			-- `a_agent': The agent to call with the supplied arguments.
			-- `a_args': The argument object to marshal.
			-- `Result': A {TUPLE} containing the marshalled arguments for use with the supplied routine.
		require
			a_agent_attached: a_agent /= Void
			a_agent_target_attached: a_agent.target /= Void
			a_args_attached: a_args /= Void
			a_args_big_enough: a_args.count >= a_agent.open_count
		local
			l_agent_type: TYPE [detachable ROUTINE]
			l_tuple_type: TYPE [detachable ANY]
			l_arg_type: TYPE [detachable ANY]
			l_value: XRPC_VALUE
			l_result: detachable TUPLE
			i, nb: INTEGER
		do
			l_agent_type := a_agent.generating_type
				-- Fetch argument tuple type information.
			l_tuple_type := l_agent_type.generic_parameter_type (2)

				-- Create a new tuple base on the tuple type id.
			if attached {TUPLE} internal.new_instance_of (l_tuple_type.type_id) as l_tuple then
				l_result := l_tuple
			end
			check l_result_attached: attached l_result end
			Result := l_result

				-- Set the result tuple arguments
			nb := l_tuple_type.generic_parameter_count
			from i := 1 until i > nb loop
				l_arg_type := l_tuple_type.generic_parameter_type (i)
				l_value := a_args[i]
				if l_value.is_valid then -- and then is_compatible_type (l_arg_id, l_value) then
					if attached marshaller.marshal_to (l_arg_type, l_value) as l_marshalled_value then
						check valid_value: Result.valid_type_for_index (l_marshalled_value, i) end
						Result.put (l_marshalled_value, i)
					else
						--create {XRPC_MARSHAL_EXCEPTION} l_exception
					end
				else
					-- Error: Bad object type
				end
				i := i + 1
			end
		end

feature -- Extension

	extend (a_delegate: XRPC_DELEGATE)
			-- Extends the server with a new delegate. All methods in the delegate are then made available
			-- to the server using a fully quantified method name [namespace.]method-name.
			--
			-- `a_delegate': The delegate object to extend the server with.
		require
			a_delegate_attached: a_delegate /= Void
			not_has_a_delegate: not has (a_delegate)
			a_delegate_unassociated: a_delegate.dispatcher = Void
		do
			delegates.extend (a_delegate)
			a_delegate.dispatcher := Current
		ensure
			has_a_delegate: has (a_delegate)
			a_delegate_dispatcher_set: a_delegate.dispatcher = Current
		end

feature -- Extension

	prune (a_delegate: XRPC_DELEGATE)
			-- Removes a delegate from the server. The methods of the delegate will no longer be available.
			--
			-- `a_delegate': The delegate object to remove from the server.
		require
			a_delegate_attached: a_delegate /= Void
			has_a_delegate: has (a_delegate)
		do
			delegates.prune (a_delegate)
			a_delegate.dispatcher := Void
		ensure
			not_has_a_delegate: not has (a_delegate)
			a_delegate_dispatcher_unset: a_delegate.dispatcher = Void
		end

feature -- Basic operations

	call (a_name: READABLE_STRING_32; a_args: detachable ARRAY [XRPC_VALUE]): detachable XRPC_RESPONSE
			-- Calls a method found on one of the registered call delegates.
			--
			-- `a_name': Full name of the method to call on the dispatcher.
			-- `a_args': The arguments to call with the method. If the method accepts no arguments then this
			--           can be Void.
			-- `Result': A response of making the call. This could be a fault object {XRPC_FAULT_RESPONSE}
			--           in the event or an error or execption.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			--a_args_contains_valid_values: attached a_args implies a_args.for_all (agent {XRPC_VALUE}.is_valid)
		local
			l_info: like delegate_for_method
			l_delegate: XRPC_DELEGATE
			retried: BOOLEAN
		do
			if not retried then
				l_info := delegate_for_method (a_name)
				if l_info /= Void then
					l_delegate := l_info.delegate
					if l_delegate.has_method (l_info.name) then
						Result := call_internal (l_delegate, l_info.name, a_args)
					else
							-- Unknown method name
						check should_never_happen: False end
						Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_method_unknown)
					end
				else
						-- Unknown method name
					Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_method_unknown)
				end
			else
					-- Internal exception, create the appropriate response.
				if attached last_exception as l_exception then
					Result := response_factory.new_response_from_exception (l_exception)
				else
					Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_method_execution_failure)
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Basic operations

	frozen call_internal (a_delegate: XRPC_DELEGATE; a_name: READABLE_STRING_32; a_args: detachable ARRAY [XRPC_VALUE]): detachable XRPC_RESPONSE
			-- Performs argument object marshalling and call delegation to a method on a given call delegate.
			-- When the call returns a value, fault or otherwise, the result will be attached. All other
			-- exception cases will raise an exception.
			--
			-- `a_delegate': A delegate object to perform the call on.
			-- `a_name': Name of the method to call on the supplied delegate.
			-- `a_args': The arguments to call with the method. If the method accepts no arguments then this
			--           can be Void.
			-- `Result': A response of making the call. This could be a fault object {XRPC_FAULT_RESPONSE}
			--           in the event or an error or execption.
		require
			a_delegate_attached: a_delegate /= Void
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
			a_delegate_has_method_a_name: a_delegate.has_method (a_name)
			--a_args_contains_valid_values: attached a_args implies a_args.for_all (agent {XRPC_VALUE}.is_valid)
		local
			l_agent: ROUTINE
			l_result: ANY
			l_open_args: detachable like marshal_routine_arguments
		do
			l_agent := a_delegate[a_name]
			if
				(a_args /= Void and then l_agent.open_count = a_args.count) or else
				(a_args =  Void and then l_agent.open_count = 0)
			then
					-- There might be arguments/return type, so check the agent routine argument types/return type
					-- can be marshalled before attempting to make the call.
				if marshaller.is_marshallable_routine (l_agent) then
					if a_args = Void or else a_args.is_empty then
						a_delegate.on_before_call (a_name, Void)
						if attached {FUNCTION [ANY]} l_agent as l_function then
								-- Make call with no arguments.
							l_result := l_function.item (Void)
							if l_result /= Void then
								Result := response_factory.new_response_from_value (l_result)
							end
						else
								-- Make call with no arguments and no result.
							l_agent.call (Void)
							check result_detached: Result = Void end
						end
						a_delegate.on_after_call (a_name, Void, Result)
					else
						check a_args_attached: a_args /= Void end

						l_open_args := marshal_routine_arguments (l_agent, a_args)
						if l_agent.valid_operands (l_open_args) then
							a_delegate.on_before_call (a_name, l_open_args)
							if attached {FUNCTION [ANY]} l_agent as l_function then
									-- Make call with arguments.
								l_result := l_function.item (l_open_args)
								if attached l_result then
									Result := response_factory.new_response_from_value (l_result)
								end
							else
									-- Make call with arguments and no result.
								l_agent.call (l_open_args)
								check result_detached: Result = Void end
							end
							a_delegate.on_after_call (a_name, l_open_args, Result)
						end
					end
				else
						-- Unmarshable method because of unmatched argument/result types.
					Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_method_invalid)
				end
			else
				if a_args = Void or else l_agent.open_count > a_args.count then
						-- Not enough arguments in RPC
					Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_method_too_few_arguments)
				else
						-- Too many arguments in RPC
					Result := response_factory.new_response_from_error_code ({XRPC_ERROR_CODES}.e_code_method_too_many_arguments)
				end
			end
		end

feature {NONE} -- Constants

	delegate_qualifier: CHARACTER
			-- Character to split a delegate from the API name.
		do
			Result := '.'
		ensure
			result_is_printable: Result.is_printable
		end

invariant
	built_ins_attached: built_ins /= Void
	delegates_attached: delegates /= Void
	has_built_ins: has (built_ins)

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
