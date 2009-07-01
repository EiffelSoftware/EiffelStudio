note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_MARSHALLER

inherit
	ANY

	XRPC_TYPE_IDS
		export
			{NONE} all
			{ANY} is_boolean, is_double, is_integer, is_string
		end

feature -- Status report

	is_marshallable_type (a_type: INTEGER): BOOLEAN
			-- Determines if a type can be marshalled.
			-- Note: This is typically used for XML-RPC method argument type validation. For method result
			--       types use `is_marshallable_result_type'.
			--
			-- `a_type': A type identifier of a method argument type.
			-- `Result': True if the type is marshallable; False otherwise.
		do
			Result := is_boolean (a_type) or else
				is_double (a_type) or else
				is_integer (a_type) or else
				is_string (a_type) or else
				is_array (a_type)
		end

	is_marshallable_result_type (a_type: INTEGER): BOOLEAN
			-- Determines if a function result type can be marshalled.
			-- Note: This is typically used for XML-RPC method result type validation. For method arguments
			--       types use `is_marshallable_type'.
			--
			-- `a_type': A type identifier of a method result type.
			-- `Result': True if the type is marshallable; False otherwise.
		do
			Result := is_marshallable_type (a_type) or else a_type = xrpc_response_type_id
		ensure
			is_marshallable_type: Result implies
				(is_marshallable_type (a_type) or else a_type = xrpc_response_type_id)
		end

	is_marshallable_routine (a_routine: ROUTINE [ANY, TUPLE]): BOOLEAN
			-- Determines if a routine is able to be marshalled.
			-- This check ensures any arguments and a result type are marshallable.
			--
			-- `a_routine': A procedure/function agent to validate for marshalling.
			-- `Result': True if the routine is marshallable; False otherwise.
		require
			a_routine_attached: attached a_routine
		local
			l_internal: like internal
			l_tuple_id: INTEGER
			l_type_id: INTEGER
			i, i_count: INTEGER
		do
				-- Routines cannot have an open target because custom Eiffel objects cannot be marshalled.
			Result := attached a_routine.target
			if Result then
				l_internal := internal
				if a_routine.open_count > 0 then
						-- Check argument tuple types
					l_tuple_id := l_internal.generic_dynamic_type (a_routine, 2)
					i_count := l_internal.generic_count_of_type (l_tuple_id)
					from i := 1 until i > i_count or not Result loop
						l_type_id := l_internal.generic_dynamic_type_of_type (l_tuple_id, i)
						Result := is_marshallable_type (l_type_id)
						i := i + 1
					end
				end

				if Result and then attached {FUNCTION [ANY, TUPLE, ANY]} a_routine as l_function then
						-- Check result type
					l_type_id := l_internal.generic_dynamic_type (l_function, 3)
					Result := is_marshallable_result_type (l_type_id)
				end
			end
		ensure
			a_routine_target_attached: Result implies attached a_routine.target
		end

	is_marshallable_object (a_object: ANY): BOOLEAN
			-- Determines if an object is able to be marshalled.
			--
			-- `a_routine': An object to validate for marshalling.
			-- `Result': True if the object is marshallable; False otherwise.
		require
			a_object_attached: attached a_object
		local
			l_type_id: INTEGER
		do
			l_type_id := internal.dynamic_type (a_object)
			Result := is_array (l_type_id) or
				is_boolean (l_type_id) or
				is_double (l_type_id) or
				is_integer (l_type_id) or
				is_string (l_type_id)
		end

feature -- Basic operations: To Eiffel

	marshal_to (a_type: INTEGER; a_value: XRPC_VALUE): detachable ANY
			-- Marshals an XML-RPC value object into an object of the supplied type.
		require
			a_value_attached: attached a_value
			a_value_is_valid: a_value.is_valid
		do
			inspect a_value.type.item
			when {XRPC_TYPE}.boolean then
				if is_boolean (a_type) and then attached {XRPC_BOOLEAN} a_value as l_value then
					Result := marshal_to_boolean (a_type, l_value)
				else
					-- Error: Incompatible type.
				end
			when {XRPC_TYPE}.double then
				if is_double (a_type) and then attached {XRPC_DOUBLE} a_value as l_value then
					Result := marshal_to_double (a_type, l_value)
				else
					-- Error: Incompatible type.
				end
			when {XRPC_TYPE}.integer then
				if is_integer (a_type) and then attached {XRPC_INTEGER} a_value as l_value then
					Result := marshal_to_integer (a_type, l_value)
				else
					-- Error: Incompatible type.
				end
			when {XRPC_TYPE}.string then
				if is_string (a_type) and then attached {XRPC_STRING} a_value as l_value then
					Result := marshal_to_string (a_type, l_value)
				else
					-- Error: Incompatible type.
				end
			else
				if internal.dynamic_type (a_value) = a_type then
					Result := a_value
				else
					-- Error: Incompatbile type.
				end
			end
		end

	marshal_to_boolean (a_type: INTEGER; a_value: XRPC_BOOLEAN): ANY
			-- Marshals an XML-RPC value to an boolean object.
		require
			a_type_is_boolean: is_boolean (a_type)
			a_value_attached: attached a_value
			a_value_is_valid: a_value.is_valid
		do
			if a_type = xrpc_boolean_type_id then
					-- No marshalling needed.
				Result := a_value
			else
				Result := a_value.value
			end
		ensure
			result_attached: attached Result
		end

	marshal_to_double (a_type: INTEGER; a_value: XRPC_DOUBLE): ANY
			-- Marshals an XML-RPC value to an double object.
		require
			a_type_is_double: is_double (a_type)
			a_value_attached: attached a_value
			a_value_is_valid: a_value.is_valid
		local
			l_double: REAL_64
		do
			if a_type = xrpc_double_type_id then
					-- No marshalling needed.
				Result := a_value
			else
				l_double := a_value.value
				if a_type = real_32_type_id then
					Result := l_double.truncated_to_real
				else
					Result := l_double
				end
			end
		ensure
			result_attached: attached Result
		end

	marshal_to_integer (a_type: INTEGER; a_value: XRPC_INTEGER): ANY
			-- Marshals an XML-RPC value to an integer object.
		require
			a_type_is_integer: is_integer (a_type)
			a_value_attached: attached a_value
			a_value_is_valid: a_value.is_valid
		local
			l_integer: INTEGER_32
		do
			if a_type = xrpc_integer_type_id then
					-- No marshalling needed.
				Result := a_value
			else
				l_integer := a_value.value
				if a_type = integer_32_type_id then
					Result := l_integer
				elseif a_type = integer_16_type_id then
					if l_integer <= {INTEGER_16}.max_value then
						Result := l_integer.as_integer_16
					else
							-- Overflow.
						Result := {INTEGER_16}0
					end
				elseif a_type = integer_8_type_id then
					if l_integer <= {INTEGER_8}.max_value then
						Result := l_integer.as_integer_8
					else
							-- Overflow.
						Result := {INTEGER_8}0
					end
				else
					if l_integer >= 0 then
						if a_type = natural_32_type_id then
							Result := l_integer.as_natural_32
						elseif a_type = natural_16_type_id then
							if l_integer <= {NATURAL_16}.max_value then
								Result := l_integer.as_natural_16
							else
									-- Overflow.
								Result := {NATURAL_16}0
							end
						elseif a_type = natural_8_type_id then
							if l_integer <= {NATURAL_8}.max_value then
								Result := l_integer.as_natural_8
							else
									-- Overflow.
								Result := {NATURAL_8}0
							end
						else
							Result := {NATURAL_8}0
						end
					else
							-- Underflow.
						Result := {NATURAL_8}0
					end
				end
			end
		ensure
			result_attached: attached Result
		end

	marshal_to_string (a_type: INTEGER; a_value: XRPC_STRING): ANY
			-- Marshals an XML-RPC value to an string object.
		require
			a_type_is_string: is_string (a_type)
			a_value_attached: attached a_value
			a_value_is_valid: a_value.is_valid
		local
			l_string: STRING
		do
			if a_type = xrpc_string_type_id then
					-- No marshalling needed.
				Result := a_value
			else
				l_string := a_value.value
				if
					a_type = string_8_type_id or
					a_type = readable_string_8_type_id or
					a_type = readable_string_general_type_id
				then
					Result := l_string
				elseif
					a_type = string_32_type_id or
					a_type = readable_string_32_type_id
				then
					Result := l_string.as_string_32
				elseif a_type = immutable_string_8_type_id then
					create {IMMUTABLE_STRING_8} Result.make_from_string (l_string)
				elseif a_type = immutable_string_8_type_id then
					create {IMMUTABLE_STRING_32} Result.make_from_string_8 (l_string)
				else
						-- Unknown string
					Result := ""
				end
			end
		ensure
			result_attached: attached Result
		end

feature -- Basic operations: From Eiffel

	marshal_from (a_value: ANY): XRPC_VALUE
			-- Marshals an XML-RPC value object into an object of the supplied type.
		require
			a_value_attached: attached a_value
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		local
			l_type: INTEGER
		do
			if attached {XRPC_VALUE} a_value as l_result then
					-- No marshalling needed
				Result := l_result
			else
				l_type := internal.dynamic_type (a_value)
				if is_boolean (l_type) then
					Result := marshal_from_boolean (a_value)
				elseif is_double (l_type) then
					Result := marshal_from_double (a_value)
				elseif is_integer (l_type) then
					Result := marshal_from_integer (a_value)
				elseif is_string (l_type) then
					Result := marshal_from_string (a_value)
				elseif is_array (l_type) then
					Result := marshal_from_array (a_value)
				else
						-- Error
					create {XRPC_DEFAULT_VALUE} Result
				end
			end
		end

	marshal_from_array (a_value: ANY): XRPC_ARRAY
			-- Marshals an Eiffel array to a XML-RPC array object.
			--
			-- `a_value': A array to marshal.
			-- `Result': A marshaled XML-RPC array object.
		require
			a_value_attached: attached a_value
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		local
			l_mutable_array: XRPC_MUTABLE_ARRAY
			i, i_upper: INTEGER
		do
			check a_value_is_array: is_array (internal.dynamic_type (a_value)) end

			if internal.dynamic_type (a_value) = xrpc_array_type_id and then attached {XRPC_ARRAY} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				create l_mutable_array.make_empty
				if attached {ARRAY [ANY]} a_value as l_array then
					from
						i := l_array.lower
						i_upper := l_array.upper
					until
						i > i_upper
					loop
						if attached l_array[i] as l_item and then is_marshallable_object (l_item) then
							l_mutable_array.extend (marshal_from (l_item))
						else
-- Error: Incompatible type
						end
						i := i + 1
					end
					check same_count: l_array.count.as_natural_32  = l_mutable_array.count end
				else
					check should_never_happen: False end
				end
				Result := l_mutable_array
			end
		ensure
			result_attached: attached Result
			result_is_valid: Result.is_valid
			result_is_array: is_array (internal.dynamic_type (Result))
		end

	marshal_from_boolean (a_value: ANY): XRPC_BOOLEAN
			-- Marshals an Eiffel Boolean value to a XML-RPC Boolean object.
			--
			-- `a_value': A Boolean value to marshal.
			-- `Result': A marshaled XML-RPC Boolean object.
		require
			a_value_attached: attached a_value
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		do
			check a_value_is_boolean: is_boolean (internal.dynamic_type (a_value)) end

			if internal.dynamic_type (a_value) = xrpc_boolean_type_id and then attached {XRPC_BOOLEAN} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				if attached {BOOLEAN_REF} a_value as l_bool then
					create Result.make (l_bool.item)
				else
					check should_never_happen: False end
					create Result.make (False)
				end
			end
		ensure
			result_attached: attached Result
			result_is_valid: Result.is_valid
			result_is_boolean: is_boolean (internal.dynamic_type (Result))
		end

	marshal_from_double (a_value: ANY): XRPC_DOUBLE
			-- Marshals an Eiffel real value to a XML-RPC double object.
			--
			-- `a_value': A real value to marshal.
			-- `Result': A marshaled XML-RPC double object.
		require
			a_value_attached: attached a_value
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		do
			check a_value_is_double: is_double (internal.dynamic_type (a_value)) end

			if internal.dynamic_type (a_value) = xrpc_double_type_id and then attached {XRPC_DOUBLE} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				if attached {REAL_64_REF} a_value as l_real then
					create Result.make (l_real.item)
				elseif attached {REAL_32_REF} a_value as l_real then
					create Result.make (l_real.item)
				else
					check should_never_happen: False end
					create Result.make (0.0)
				end
			end
		ensure
			result_attached: attached Result
			result_is_valid: Result.is_valid
			result_is_boolean: is_boolean (internal.dynamic_type (Result))
		end

	marshal_from_integer (a_value: ANY): XRPC_INTEGER
			-- Marshals an Eiffel integer value to a XML-RPC integer object.
			--
			-- `a_value': An integer or nautral value to marshal.
			-- `Result': A marshaled XML-RPC integer object.
		require
			a_value_attached: attached a_value
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		local
			l_type: INTEGER
		do
			check a_value_is_integer: is_integer (internal.dynamic_type (a_value)) end

			l_type := internal.dynamic_type (a_value)
			if l_type = xrpc_integer_type_id and then attached {XRPC_INTEGER} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				if l_type = integer_64_type_id then
					if attached {INTEGER_64_REF} a_value as l_int then
						if l_int.item <= {INTEGER_32}.max_value then
							if l_int.item >= {INTEGER_32}.min_value then
								create Result.make (l_int.item.as_integer_32)
							else
-- Error too small
								create Result.make (0)
							end
						else
-- Error too big
							create Result.make (0)
						end
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = integer_32_type_id then
					if attached {INTEGER_32_REF} a_value as l_int then
						create Result.make (l_int.item)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = integer_16_type_id then
					if attached {INTEGER_16_REF} a_value as l_int then
						create Result.make (l_int.item)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = integer_8_type_id then
					if attached {INTEGER_8_REF} a_value as l_int then
						create Result.make (l_int.item)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = natural_64_type_id then
					if attached {NATURAL_64_REF} a_value as l_natural then
						if l_natural.item <= {INTEGER_32}.max_value.as_natural_64 then
							create Result.make (l_natural.item.as_integer_32)
						else
-- Error too big
							create Result.make (0)
						end
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = natural_32_type_id then
					if attached {NATURAL_32_REF} a_value as l_natural then
						if l_natural.item <= {INTEGER_32}.max_value.as_natural_32 then
							create Result.make (l_natural.item.as_integer_32)
						else
-- Error too big
							create Result.make (0)
						end
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = natural_16_type_id then
					if attached {NATURAL_16_REF} a_value as l_natural then
						create Result.make (l_natural.item.as_integer_32)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				elseif l_type = natural_8_type_id then
					if attached {NATURAL_8_REF} a_value as l_natural then
						create Result.make (l_natural.item.as_integer_32)
					else
						check should_never_happen: False end
						create Result.make (0)
					end

				else
					check should_never_happen: False end
					create Result.make (0)
				end
			end
		ensure
			result_attached: attached Result
			result_is_valid: Result.is_valid
			result_is_integer: is_integer (internal.dynamic_type (Result))
		end

	marshal_from_string (a_value: ANY): XRPC_STRING
			-- Marshals an Eiffel string value to a XML-RPC string object.
			--
			-- `a_value': A string value to marshal.
			-- `Result': A marshaled XML-RPC string object.
		require
			a_value_attached: attached a_value
			a_value_is_marshallable_object: is_marshallable_object (a_value)
		do
			check a_value_is_string: is_string (internal.dynamic_type (a_value)) end

			if internal.dynamic_type (a_value) = xrpc_string_type_id and then attached {XRPC_STRING} a_value as l_result then
					-- No marshalling needed.
				Result := l_result
			else
				if attached {READABLE_STRING_8} a_value as l_string then
					create Result.make (l_string)
				elseif attached {READABLE_STRING_32} a_value as l_string and then l_string.is_string_8 then
					create Result.make (l_string.to_string_8)
				else
-- Incompatible string
					create Result.make ("")
				end
			end
		ensure
			result_attached: attached Result
			result_is_valid: Result.is_valid
			result_is_string: is_string (internal.dynamic_type (Result))
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
