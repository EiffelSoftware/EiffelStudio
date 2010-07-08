note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_TYPE_IDS

feature -- Access: Basic

	any_type: TYPE [ANY]
			-- {ARRAY [ANY]} runtime type id.
		once
			Result := {ANY}
		ensure
			result_attached: Result /= Void
		end

feature -- Access: Array

	array_any_type: TYPE [detachable ARRAY [ANY]]
			-- {ARRAY [ANY]} runtime type id.
		once
			Result := {detachable ARRAY [ANY]}
		ensure
			result_attached: Result /= Void
		end

	array_none_type: TYPE [detachable ARRAY [NONE]]
			-- {ARRAY [ANY]} runtime type id.
		once
			Result := {detachable ARRAY [NONE]}
		ensure
			result_attached: Result /= Void
		end

feature -- Access: Boolean

	boolean_type: TYPE [BOOLEAN]
			-- {BOOLEAN} runtime type id.
		once
			Result := {BOOLEAN}
		ensure
			result_attached: Result /= Void
		end

feature -- Access: Integer

	integer_8_type: TYPE [INTEGER_8]
			-- {INTEGER_8} runtime type id.
		once
			Result := {INTEGER_8}
		ensure
			result_attached: Result /= Void
		end

	integer_16_type: TYPE [INTEGER_16]
			-- {INTEGER_32} runtime type id.
		once
			Result := {INTEGER_16}
		ensure
			result_attached: Result /= Void
		end

	integer_32_type: TYPE [INTEGER_32]
			-- {INTEGER_32} runtime type id.
		once
			Result := {INTEGER_32}
		ensure
			result_attached: Result /= Void
		end

	integer_64_type: TYPE [INTEGER_64]
			-- {INTEGER_64} runtime type id.
		once
			Result := {INTEGER_64}
		ensure
			result_attached: Result /= Void
		end

feature -- Access: Natural

	natural_8_type: TYPE [NATURAL_8]
			-- {NATURAL_8} runtime type id.
		once
			Result := {NATURAL_8}
		ensure
			result_attached: Result /= Void
		end

	natural_16_type: TYPE [NATURAL_16]
			-- {NATURAL_32} runtime type id.
		once
			Result := {NATURAL_16}
		ensure
			result_attached: Result /= Void
		end

	natural_32_type: TYPE [NATURAL_32]
			-- {NATURAL_32} runtime type id.
		once
			Result := {NATURAL_32}
		ensure
			result_attached: Result /= Void
		end

	natural_64_type: TYPE [NATURAL_64]
			-- {NATURAL_64} runtime type id.
		once
			Result := {NATURAL_64}
		ensure
			result_attached: Result /= Void
		end

feature -- Access: Real

	real_32_type: TYPE [REAL_32]
			-- {REAL_32} runtime type id.
		once
			Result := {REAL_32}
		ensure
			result_attached: Result /= Void
		end

	real_64_type: TYPE [REAL_64]
			-- {REAL_64} runtime type id.
		once
			Result := {REAL_64}
		ensure
			result_attached: Result /= Void
		end

feature -- Access: String

	string_8_type: TYPE [detachable STRING_8]
			-- {STRING_8} runtime type id.
		once
			Result := {detachable STRING_8}
		ensure
			result_attached: Result /= Void
		end

	readable_string_8_type: TYPE [detachable READABLE_STRING_8]
			-- {READABLE_STRING_8} runtime type id.
		once
			Result := {detachable READABLE_STRING_8}
		ensure
			result_attached: Result /= Void
		end

	readable_string_general_type: TYPE [detachable READABLE_STRING_GENERAL]
			-- {READABLE_STRING_GENERAL} runtime type id.
		once
			Result := {detachable READABLE_STRING_GENERAL}
		ensure
			result_attached: Result /= Void
		end

	immutable_string_8_type: TYPE [detachable IMMUTABLE_STRING_8]
			-- {IMMUTABLE_STRING_8} runtime type id.
		once
			Result := {detachable IMMUTABLE_STRING_8}
		ensure
			result_attached: Result /= Void
		end

	string_32_type: TYPE [detachable STRING_32]
			-- {STRING_32} runtime type id.
		once
			Result := {detachable STRING_32}
		ensure
			result_attached: Result /= Void
		end

	readable_string_32_type: TYPE [detachable READABLE_STRING_32]
			-- {READABLE_STRING_32} runtime type id.
		once
			Result := {detachable READABLE_STRING_32}
		ensure
			result_attached: Result /= Void
		end

	immutable_string_32_type: TYPE [detachable IMMUTABLE_STRING_32]
			-- {IMMUTABLE_STRING_32} runtime type id.
		once
			Result := {detachable IMMUTABLE_STRING_32}
		ensure
			result_attached: Result /= Void
		end

feature -- Access: XML-RPC object type ids

	xrpc_array_type: TYPE [detachable XRPC_ARRAY]
			-- XML-RPC array type, defined by {XRPC_ARRAY}.
		once
			Result := {detachable XRPC_ARRAY}
		end

	xrpc_boolean_type: TYPE [detachable XRPC_BOOLEAN]
			-- XML-RPC boolean type, defined by {XRPC_BOOLEAN}.
		once
			Result := {detachable XRPC_BOOLEAN}
		end

	xrpc_integer_type: TYPE [detachable XRPC_INTEGER]
			-- XML-RPC integer type id, defined by {XRPC_INTEGER}.
		once
			Result := {detachable XRPC_INTEGER}
		end

	xrpc_double_type: TYPE [detachable XRPC_DOUBLE]
			-- XML-RPC double type id, defined by {XRPC_DOUBLE}.
		once
			Result := {detachable XRPC_DOUBLE}
		end

	xrpc_string_type: TYPE [detachable XRPC_STRING]
			-- XML-RPC string type id, defined by {XRPC_STRING}.
		once
			Result := {detachable XRPC_STRING}
		end

	xrpc_struct_type: TYPE [detachable XRPC_STRUCT]
			-- XML-RPC string type id, defined by {XRPC_STRUCT}.
		once
			Result := {detachable XRPC_STRUCT}
		end

	xrpc_response_type: TYPE [detachable XRPC_RESPONSE]
			-- XML-RPC response type id, defined by {XRPC_RESPONSE}.
		once
			Result :=  {detachable XRPC_RESPONSE}
		end

feature -- Status report

	is_array_conform_to (a_type: TYPE [detachable ANY]): BOOLEAN
			-- Indicates if the dynamic type id represents an array, XML-RPC or otherwise, and that
			-- the array types conforms to the type. (XML-RPC -> Eiffel)
			--
			-- `a_type': Type id to check for array types against.
			-- `Result': True if the supplied type ID represents a array; False otherwise.
		do
			Result := a_type /= array_none_type and then
				(
					xrpc_array_type.conforms_to (a_type) or else
					array_none_type.conforms_to (a_type)
				)
		end

	is_array_conform_from (a_type: TYPE [detachable ANY]): BOOLEAN
			-- Indicates if the dynamic type id represents an array, XML-RPC or otherwise, and that
			-- the type conforms to an array.
			--
			-- `a_type': Type id to check for array types against.
			-- `Result': True if the supplied type ID represents a array; False otherwise.
		do
			Result := a_type.conforms_to (xrpc_array_type) or else
				a_type.conforms_to (array_any_type)
		end

	is_boolean (a_type: TYPE [detachable ANY]): BOOLEAN
			-- Indicates if the dynamic type id represents a boolean, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for boolean types against.
			-- `Result': True if the supplied type ID represents a boolean; False otherwise.
		do
			Result := a_type /= array_none_type and then
				(a_type = xrpc_boolean_type or else
				a_type = boolean_type)
		end

	is_double (a_type: TYPE [detachable ANY]): BOOLEAN
			-- Indicates if the dynamic type id represents a double precision real, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for real types against.
			-- `Result': True if the supplied type ID represents a real; False otherwise.
		do
			Result := a_type = xrpc_double_type or else
				a_type = real_32_type or else
				a_type = real_64_type
		end

	is_integer (a_type: TYPE [detachable ANY]): BOOLEAN
			-- Indicates if the dynamic type id represents an integer, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for integer types against.
			-- `Result': True if the supplied type ID represents an integer; False otherwise.
		do
			Result := a_type = xrpc_integer_type or else
				a_type = integer_32_type or else
				a_type = integer_16_type or else
				a_type = integer_8_type or else
				a_type = natural_32_type or else
				a_type = natural_16_type or else
				a_type = natural_8_type
		end

	is_string (a_type: TYPE [detachable ANY]): BOOLEAN
			-- Indicates if the dynamic type id represents an integer, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for string types against.
			-- `Result': True if the supplied type ID represents a string; False otherwise.
		do
			Result := a_type = xrpc_string_type or else
				a_type = string_8_type or else
				a_type = readable_string_8_type or else
				a_type = readable_string_general_type or else
				a_type = immutable_string_8_type or else
				a_type = string_32_type or else
				a_type = readable_string_32_type or else
				a_type = immutable_string_32_type
		end

	is_struct (a_type: TYPE [detachable ANY]): BOOLEAN
			-- Indicates if the dynamic type id represents a struct, XML-RPC or otherwise.
			--
			-- `a_type': Type id to check for struct types against.
			-- `Result': True if the supplied type ID represents a struct; False otherwise.
		do
			Result := a_type = xrpc_struct_type
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
