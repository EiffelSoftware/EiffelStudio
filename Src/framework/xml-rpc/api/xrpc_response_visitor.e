note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_RESPONSE_VISITOR

inherit
	XRPC_VISITOR

--feature -- Processing helpers

--	process_response (a_response: XRPC_RESPONSE)
--			-- Processes a XML-RPC fault response.
--			--
--			-- `a_response': A response to process.
--		require
--			a_response_attached: attached a_response
--		do
--			if attached {XRPC_VALUE_RESPONSE} a_response as l_value then
--				process_value_response (l_value)
--			elseif attached {XRPC_FAULT_RESPONSE} a_response as l_fault then
--				process_fault_response (l_fault)
--			else
--				check unsupported_response: False end
--			end
--		end

feature -- Processing operations

	process_fault_response (a_response: XRPC_FAULT_RESPONSE)
			-- Processes a XML-RPC double.
			--
			-- `a_response': A fault response object.
		require
			a_response_attached: attached a_response
		do
			a_response.value.visit (Current)
		end

	process_value_response (a_response: XRPC_VALUE_RESPONSE)
			-- Processes a XML-RPC value response.
			--
			-- `a_response': A value response object.
		require
			a_response_attached: attached a_response
		do
			a_response.value.visit (Current)
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
