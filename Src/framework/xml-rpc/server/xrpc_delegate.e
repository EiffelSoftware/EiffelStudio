note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XRPC_DELEGATE

feature {NONE} -- Initialization

	initialize
			-- Initializes the API for first use.
			--|Note: This is not called during creation/initialization.
			--|Implementation here should be sparse because the APIs should behave in a disconnected
			--|fashion, because of stateless web and transport logistics.
		require
			has_dispatcher: has_dispatcher
		do
			is_initialized := True
		ensure
			is_initialized: is_initialized
		end

feature -- Access

	dispatcher: detachable XRPC_SERVER_DISPATCHER assign set_dispatcher
			-- Dispatcher the APIs are managed by.

	namespace: detachable IMMUTABLE_STRING_32
			-- Optional prefix for the call delegate's API method.
			--|Note: This is not used internally, it is used by the dispatch server to route calls.
		do
		ensure
			not_result_is_empty: attached Result implies not Result.is_empty
		end

feature {NONE} -- Access

	method_table: HASH_TABLE [ROUTINE, READABLE_STRING_32]
			-- Table of XML-RPC method calls.
			--
			-- key: A API method name generated from `method_table_key'.
			-- value: A registered routine associated with the name.
		require
			has_dispatcher: has_dispatcher
		local
			l_table: like new_method_agents
		do
			if attached internal_method_table as l_result then
				Result := l_result
			else
				l_table := new_method_agents
				create Result.make (l_table.count)
				Result.compare_objects
				from l_table.start until l_table.after loop
					Result.force (l_table.item_for_iteration, method_table_key (l_table.key_for_iteration))
					l_table.forth
				end
				internal_method_table := Result
			end
		ensure
			result_attached: attached Result
			result_compares_objects: Result.object_comparison
			result_consistent: Result = method_table
		end

feature {XRPC_SERVER_DISPATCHER} -- Element change

	set_dispatcher (a_dispatcher: like dispatcher)
			-- Sets or unsets the dispatcher.
			--
			-- `a_dispatcher': A dispatcher or Void to unset.
		require
			dispatcher_detached: attached a_dispatcher implies not has_dispatcher
		do
			dispatcher := a_dispatcher
		ensure
			dispatcher_set: dispatcher = a_dispatcher
		end

feature -- Status report

	has_dispatcher: BOOLEAN
			-- Indicates if the API has been associated with a dispatcher.
		do
			Result := attached dispatcher
		ensure
			dispatcher_attached: Result implies attached dispatcher
		end

	has_method (a_name: READABLE_STRING_32): BOOLEAN
			-- Determines if the delegate can respond to the supplied method name.
			--
			-- `a_name': Name of the method to retrieve
			-- `Result': The delegate method.
		require
			has_dispatcher: has_dispatcher
		local
			l_key: like method_table_key
		do
			l_key := method_table_key (a_name)
			Result := method_table.has (l_key)
		ensure
			method_table_has_key: Result implies method_table.has (method_table_key (a_name))
		end

feature {NONE} -- Status report

	is_initialized: BOOLEAN
			-- Indiciates if the API has been initialized for first use.

	is_case_sensitive: BOOLEAN
			-- Indicates if the method names are case sensitive.
			--|Note: This affects how the method names are indexed.
		require
			has_dispatcher: has_dispatcher
		do
			if attached dispatcher as l_dispatcher then
				Result := l_dispatcher.is_case_sensitive
			end
		end

feature -- Query

	method alias "[]" (a_name: READABLE_STRING_32): ROUTINE
			-- Retrieves an API method.
			--
			-- `a_name': Name of the method to retrieve
			-- `Result': The delegate method.
		require
			has_dispatcher: has_dispatcher
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			has_method_a_name: has_method (a_name)
		local
			l_key: like method_table_key
			l_result: detachable ROUTINE
		do
			l_key := method_table_key (a_name)
			l_result := method_table.item (a_name)
			check l_result_attached: attached l_result end
			Result := l_result
		ensure
			result_attached: attached Result
			result_target_attached: attached Result.target
		end

feature {NONE} -- Query

	method_table_key (a_api: READABLE_STRING_32): READABLE_STRING_32
			-- Retrieves an API method key for look up in the method table `method_table'.
			--
			-- `a_key': API method name to generate a key for.
			-- `Result': A key to use with `method_table'.
		do
			if is_case_sensitive then
				Result := a_api
			else
				Result := a_api.as_lower
			end
		ensure
			result_attached: attached Result
			not_result_is_empty: not Result.is_empty
			result_is_lower: not is_case_sensitive implies Result.as_lower ~ Result
		end

feature {XRPC_SERVER_DISPATCHER} -- Action handlers

	on_before_call (a_name: READABLE_STRING_32; a_args: detachable TUPLE)
			-- Called prior to executing one of the registered methods in the API.
			--
			-- `a_name': The name of the method to be called.
			-- `a_args': Arguments that will be passed to the method.
		require
			has_dispatcher: has_dispatcher
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			has_method_a_name: has_method (a_name)
		do
			if not is_initialized then
				initialize
			end
		ensure
			is_initialized: is_initialized
		end

	on_after_call (a_name: READABLE_STRING_32; a_args: detachable TUPLE; a_response: detachable XRPC_RESPONSE)
			-- Called after executing one of the registered methods in the API.
			--
			-- `a_name': The name of the method that was just called.
			-- `a_args': Arguments that were passed to the method.
			-- `a_response': A response object, if any.
		require
			has_dispatcher: has_dispatcher
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			has_method_a_name: has_method (a_name)
		do
		end

feature {NONE} -- Factory

	new_method_agents: HASH_TABLE [ROUTINE, READABLE_STRING_32]
			-- Creates a new table of method agents.
			-- XML-RPC method agents may use either Eiffel types or XML-RPC types for arguments and
			-- results. XML-RPC agents may be either a procedure or function using the following supported
			-- types:
			--
			-- * {INTEGER_8}. {INTEGER_16}, {INTEGER_32}, {INTEGER_64}, {XRPC_INTEGER}
			--
			-- A result type may be of any of the above types or a {XRPC_RESPONSE}.
			-- If the result is not {XRPC_RESPONSE} the agent is expected to throw an expection in the case
			-- of an error.
		require
			has_dispatcher: has_dispatcher
		deferred
		ensure
			result_attached: attached Result
--			valid_keys: not Result.current_keys.there_exists (agent {READABLE_STRING_8}.is_empty)
--			result_routines_callable: Result.linear_representation.for_all (agent marshaller.is_marshallable_routine)
		end

feature {NONE} -- Implementation

	internal_method_table: detachable like method_table
			-- Cached version of `method_table'.
			-- Note: Do not use directly!

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
