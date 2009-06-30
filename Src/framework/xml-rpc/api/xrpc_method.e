note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XRPC_METHOD

feature -- Access

	name: IMMUTABLE_STRING_8
			-- Name of the XML-RPC method.

	arguments: LINEAR [XRPC_ARGUMENT]
			-- List of argument descriptors for the method.

	return: XRPC_ARGUMENT
			--

feature -- Status report

	is_executing: BOOLEAN
			-- Indicates if the method is being executed

	is_valid_arguments (a_args: ARRAY [XRPC_VALUE]): BOOLEAN
		do

		end

feature -- Basic operations

	frozen execute (a_arguments: ARRAY [XRPC_VALUE]): XRPC_RESPONSE
			--
		require
			not_is_executing: not is_executing
		do
			on_before_execute
			if attached internal_before_execute_actions as l_actions then
				l_actions.call ([Current, a_arguments])
			end
			execute_internal (a_arguments)
			if attached internal_before_execute_actions as l_actions then
				l_actions.call ([Current, a_arguments])
			end
			on_after_executed
		ensure
			not_is_executing: not is_executing
		end

feature -- Actions

	before_execute_actions: ACTION_SEQUENCE [TUPLE [method: XRPC_METHOD; arguments: ARRAY [XRPC_VALUE]]]
			-- Actions called prior to executing the method.
		do
			if attached internal_before_execute_actions as l_result then
				Result := l_result
			else
				create Result
				internal_before_execute_actions := Result
			end
		ensure
			result_attached: attached Result
			result_consistent: Result = before_execute_actions
		end

	after_executed_actions: ACTION_SEQUENCE [TUPLE [method: XRPC_METHOD; arguments: ARRAY [XRPC_VALUE]]]
			-- Actions called after executing the method.
		do
			if attached internal_after_execute_actions as l_result then
				Result := l_result
			else
				create Result
				internal_after_execute_actions := Result
			end
		ensure
			result_attached: attached Result
			result_consistent: Result = after_executed_actions
		end

feature {NONE} -- Action handlers

	on_before_execute
		require
			not_is_executing: not is_executing
		do
		end

	on_after_executed
		require
			not_is_executing: not is_executing
		do
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
