note
	description: "[
			(generated)
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SERVLET

inherit
	XWA_XRPC_SERVLET [MY_XMLRPC_API]
		redefine
			namespace
		 end

create
	make

feature -- Access

	namespace: IMMUTABLE_STRING_8
			-- <Precursor>
		once
			Result := "math"
		end

feature {NONE} -- Factory

	new_method_agents: HASH_TABLE [ROUTINE [ANY, TUPLE], READABLE_STRING_8]
			-- <Precursor>
		do
			create Result.make (3)
			Result.put (agent xrpc_api.print_hello, "hello")
			Result.put (agent xrpc_api.sum, "sum")
			Result.put (agent xrpc_api.sum_x, "sum_x")
			Result.put (agent xrpc_api.test_array, "array")
		end

note
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
		]"end
