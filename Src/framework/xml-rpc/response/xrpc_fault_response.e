note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_FAULT_RESPONSE

inherit
	XRPC_RESPONSE

create
	make

feature {NONE} -- Initialization

	make (a_code: INTEGER; a_message: READABLE_STRING_32)
			-- Initializes a fault response using a code and message.
			--
			-- `a_code':
			-- `a_message':
		local
			l_struct: XRPC_STRUCT
		do
			code := a_code
			create message.make_from_string (a_message)

				-- Create `value' struct using the names from the XML-RPC spec.
			create l_struct.make
			l_struct.put (create {XRPC_INTEGER}.make (a_code), {XRPC_CONSTANTS}.fault_code_value)
			l_struct.put (create {XRPC_STRING}.make (a_message), {XRPC_CONSTANTS}.fault_string_value)
			value := l_struct
		ensure
			code_set: code = a_code
			messsage_set: message.same_string (a_message)
		end

feature -- Access

	code: INTEGER
			-- Fault code.

	message: IMMUTABLE_STRING_32
			-- Message from the server describing the fault.

	value: XRPC_VALUE
			-- <Precursor>

feature -- Status report

	is_fault: BOOLEAN = True
			-- <Precursor>

feature -- Basic operations: Visitor

	visit (a_visitor: XRPC_RESPONSE_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_fault_response (Current)
		end

invariant
	is_fault: is_fault
	message_attached: attached message
--	not_message_is_empty: not message.is_empty

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
