note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_TYPE_IDS

feature -- Access: Boolean

	array_type_id: INTEGER
			-- {ARRAY [ANY]} runtime type id.
		once
			Result := type_of ({ARRAY [ANY]})
		ensure
			result_positive: Result > 0
		end

feature -- Access: Boolean

	boolean_type_id: INTEGER
			-- {BOOLEAN} runtime type id.
		once
			Result := type_of ({BOOLEAN})
		ensure
			result_positive: Result > 0
		end

feature -- Access: Integer

	integer_8_type_id: INTEGER
			-- {INTEGER_8} runtime type id.
		once
			Result := type_of ({INTEGER_8})
		ensure
			result_positive: Result > 0
		end

	integer_16_type_id: INTEGER
			-- {INTEGER_32} runtime type id.
		once
			Result := type_of ({INTEGER_16})
		ensure
			result_positive: Result > 0
		end

	integer_32_type_id: INTEGER
			-- {INTEGER_32} runtime type id.
		once
			Result := type_of ({INTEGER_32})
		ensure
			result_positive: Result > 0
		end

	integer_64_type_id: INTEGER
			-- {INTEGER_64} runtime type id.
		once
			Result := type_of ({INTEGER_64})
		ensure
			result_positive: Result > 0
		end

feature -- Access: Natural

	natural_8_type_id: INTEGER
			-- {NATURAL_8} runtime type id.
		once
			Result := type_of ({NATURAL_8})
		ensure
			result_positive: Result > 0
		end

	natural_16_type_id: INTEGER
			-- {NATURAL_32} runtime type id.
		once
			Result := type_of ({NATURAL_16})
		ensure
			result_positive: Result > 0
		end

	natural_32_type_id: INTEGER
			-- {NATURAL_32} runtime type id.
		once
			Result := type_of ({NATURAL_32})
		ensure
			result_positive: Result > 0
		end

	natural_64_type_id: INTEGER
			-- {NATURAL_64} runtime type id.
		once
			Result := type_of ({NATURAL_64})
		ensure
			result_positive: Result > 0
		end

feature -- Access: Real

	real_32_type_id: INTEGER
			-- {REAL_32} runtime type id.
		once
			Result := type_of ({REAL_32})
		ensure
			result_positive: Result > 0
		end

	real_64_type_id: INTEGER
			-- {REAL_64} runtime type id.
		once
			Result := type_of ({REAL_64})
		ensure
			result_positive: Result > 0
		end

feature -- Access: String

	string_8_type_id: INTEGER
			-- {STRING_8} runtime type id.
		once
			Result := type_of ({STRING_8})
		ensure
			result_positive: Result > 0
		end

	readable_string_8_type_id: INTEGER
			-- {READABLE_STRING_8} runtime type id.
		once
			Result := type_of ({READABLE_STRING_8})
		ensure
			result_positive: Result > 0
		end

	readable_string_general_type_id: INTEGER
			-- {READABLE_STRING_GENERAL} runtime type id.
		once
			Result := type_of ({READABLE_STRING_GENERAL})
		ensure
			result_positive: Result > 0
		end

	immutable_string_8_type_id: INTEGER
			-- {IMMUTABLE_STRING_8} runtime type id.
		once
			Result := type_of ({IMMUTABLE_STRING_8})
		ensure
			result_positive: Result > 0
		end

	string_32_type_id: INTEGER
			-- {STRING_32} runtime type id.
		once
			Result := type_of ({STRING_32})
		ensure
			result_positive: Result > 0
		end

	readable_string_32_type_id: INTEGER
			-- {READABLE_STRING_32} runtime type id.
		once
			Result := type_of ({READABLE_STRING_32})
		ensure
			result_positive: Result > 0
		end

	immutable_string_32_type_id: INTEGER
			-- {IMMUTABLE_STRING_32} runtime type id.
		once
			Result := type_of ({IMMUTABLE_STRING_32})
		ensure
			result_positive: Result > 0
		end

feature -- Access: XML-RPC object type ids

	xrpc_array_type_id: INTEGER
			-- XML-RPC array type, defined by {XRPC_ARRAY}.
		once
			Result := type_of ({detachable XRPC_ARRAY})
		end

	xrpc_boolean_type_id: INTEGER
			-- XML-RPC boolean type, defined by {XRPC_BOOLEAN}.
		once
			Result := type_of ({detachable XRPC_BOOLEAN})
		end

	xrpc_integer_type_id: INTEGER
			-- XML-RPC integer type id, defined by {XRPC_INTEGER}.
		once
			Result := type_of ({XRPC_INTEGER})
		end

	xrpc_double_type_id: INTEGER
			-- XML-RPC double type id, defined by {XRPC_DOUBLE}.
		once
			Result := type_of ({XRPC_DOUBLE})
		end

	xrpc_string_type_id: INTEGER
			-- XML-RPC string type id, defined by {XRPC_STRING}.
		once
			Result := type_of ({XRPC_STRING})
		end

	xrpc_response_type_id: INTEGER
			-- XML-RPC response type id, defined by {XRPC_RESPONSE}.
		once
			Result :=  type_of ({XRPC_RESPONSE})
		end

feature -- Status report

	is_array (a_type: INTEGER): BOOLEAN
			-- Indicates if the dynamic type id represents a boolean, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for boolean types against.
			-- `Result': True if the supplied type ID represents a boolean; False otherwise.
		local
			l_internal: like internal
		do
			l_internal := internal
			Result := l_internal.type_conforms_to (a_type, xrpc_array_type_id) or else
				l_internal.type_conforms_to (a_type, array_type_id)
		end

	is_boolean (a_type: INTEGER): BOOLEAN
			-- Indicates if the dynamic type id represents a boolean, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for boolean types against.
			-- `Result': True if the supplied type ID represents a boolean; False otherwise.
		do
			Result := a_type = xrpc_boolean_type_id or else
				a_type = boolean_type_id
		end

	is_double (a_type: INTEGER): BOOLEAN
			-- Indicates if the dynamic type id represents a double precision real, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for real types against.
			-- `Result': True if the supplied type ID represents a real; False otherwise.
		do
			Result := a_type = xrpc_double_type_id or else
				a_type = real_32_type_id or else
				a_type = real_64_type_id
		end

	is_integer (a_type: INTEGER): BOOLEAN
			-- Indicates if the dynamic type id represents an integer, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for integer types against.
			-- `Result': True if the supplied type ID represents an integer; False otherwise.
		do
			Result := a_type = xrpc_integer_type_id or else
				a_type = integer_32_type_id or else
				a_type = integer_16_type_id or else
				a_type = integer_8_type_id or else
				a_type = natural_32_type_id or else
				a_type = natural_16_type_id or else
				a_type = natural_8_type_id
		end

	is_string (a_type: INTEGER): BOOLEAN
			-- Indicates if the dynamic type id represents an integer, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for string types against.
			-- `Result': True if the supplied type ID represents a string; False otherwise.
		do
			Result := a_type = xrpc_string_type_id or else
				a_type = string_8_type_id or else
				a_type = readable_string_8_type_id or else
				a_type = readable_string_general_type_id or else
				a_type = immutable_string_8_type_id or else
				a_type = string_32_type_id or else
				a_type = readable_string_32_type_id or else
				a_type = immutable_string_32_type_id
		end

feature {NONE} -- Query

	type_of (a_type: TYPE [detachable ANY]): INTEGER
			-- Retrieves the dynamic type of a type (not the TYPE object but what it represents.)
			--
			-- `a_type': A type to retrieve the dynamic type of.
			-- `Result': A type identifier for the given type
		do
			Result := internal.generic_dynamic_type (a_type, 1)
		ensure
			result_positive: Result > 0
		end

feature {NONE} -- Helpers

	internal: INTERNAL
			-- Access to INTERNAL
		once
			create Result
		ensure
			result_attached: attached Result
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
