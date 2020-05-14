note
	description: "[
		SQLite statement argument object marshaller to convert Eiffel basic type objects into those usable
		by the internals of the SQLite library.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_BIND_ARG_MARSHALLER

inherit
	SQLITE_BINDING_HELPERS

feature {NONE} -- Access

	default_bind_arg: SQLITE_BIND_ARG [ANY]
			-- Default binding argument for array creation (Void-Safe mode).
		once
			create {SQLITE_NULL_ARG} Result.make ("?1")
		ensure
			result_attached: attached Result
		end

feature -- Status report

	is_value_marshalled (a_value: detachable ANY): BOOLEAN
			-- Indicates if the value has already been marshalled (is of a {SQLITE_BIND_ARG} type.
			--
			-- `a_value': A value to check.
			-- `Result': True if no marshalling needs to be perform; False otherwise.
		require
			a_value_is_valid_value_type: is_valid_argument (a_value)
		do
			Result := attached {SQLITE_BIND_ARG [ANY]} a_value
		ensure
			a_value_is_bind_arg: Result implies attached {SQLITE_BIND_ARG [ANY]} a_value
		end

feature -- Query

	new_binding_argument_array (a_args: ITERABLE [detachable ANY]): ARRAY [SQLITE_BIND_ARG [ANY]]
			-- Creates a new argument array from a tuple of values.
			--
			-- `a_args': Arguments to create a new array for.
			-- `Result': Argument array to use with processing
		require
			a_args_attached: attached a_args
			not_a_args_is_empty: across a_args as ic some True end
			a_args_is_valid_arguments: is_valid_arguments (a_args)
		local
			i_count, i: INTEGER
			l_arg: detachable ANY
			l_var: STRING
		do
			i_count := iterable_min_count_or_value (a_args, maximum_variable_index_number)
			create Result.make_filled (default_bind_arg, 1, i_count)
			i := 1
			across
				a_args as ic
			until
				i > i_count
			loop
				l_arg := ic.item
				if attached {SQLITE_BIND_ARG [ANY]} l_arg as l_bind_arg then
						-- Already a bound argument
					Result[i] := l_bind_arg
				else
					create l_var.make (3)
					l_var.append_character ('?')
					l_var.append_integer (i)
					Result[i] := new_binding_argument (l_arg, l_var)
				end
				i := i + 1
			end
		ensure
			result_attached: attached Result
			result_count_matches: iterable_has_count (a_args, Result.count)
		end

	new_binding_argument (a_value: detachable ANY; a_var: READABLE_STRING_8): SQLITE_BIND_ARG [ANY]
			-- Creates a new SQLite bind argument for us with executing SQLite statements containing arguments.
			--
			-- `a_value': A value to create a binding argument for.
			-- `Result': A bound argument, or `a_value' if the argument is already a binding argument.
		require
			a_value_is_valid_argument: is_valid_argument (a_value)
			a_var_attached: attached a_var
			not_a_var_is_empty: not a_var.is_empty
			a_var_is_valid_variable_name: is_valid_variable_name (a_var)
		local
			l_scalar_result: detachable SQLITE_BIND_ARG [ANY]
			l_type_id: INTEGER
		do
			if attached a_value then
				if attached {SQLITE_BIND_ARG [ANY]} a_value as l_result then
					Result := l_result
				elseif attached {READABLE_STRING_8} a_value as l_value then
					create {SQLITE_STRING_ARG} Result.make (a_var, l_value)
				elseif attached {READABLE_STRING_32} a_value as l_s32 then
					if l_s32.is_valid_as_string_8 then
						create {SQLITE_STRING_ARG} Result.make (a_var, l_s32.to_string_8)
					else
							--| Should not occur due to precondition is_valid_argument
						check unsupported_value_for_type_string_32: False end
						create {SQLITE_NULL_ARG} Result.make (a_var)
					end
				elseif attached {MANAGED_POINTER} a_value as l_value then
					create {SQLITE_BLOB_ARG} Result.make (a_var, l_value)
				else
						-- Must be a scalar
					l_type_id := a_value.generating_type.type_id
					if l_type_id = ({INTEGER_8}).type_id then
						if attached {INTEGER_8_REF} a_value as l_value then
							create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item)
						end
					elseif l_type_id = ({INTEGER_16}).type_id then
						if attached {INTEGER_16_REF} a_value as l_value then
							create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item)
						end
					elseif l_type_id = ({INTEGER_32}).type_id then
						if attached {INTEGER_32_REF} a_value as l_value then
							create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item)
						end
					elseif l_type_id = ({INTEGER_64}).type_id then
						if attached {INTEGER_64_REF} a_value as l_value then
							create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item)
						end
					elseif l_type_id = ({NATURAL_8}).type_id then
						if attached {NATURAL_8_REF} a_value as l_value then
							create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item.as_integer_32)
						end
					elseif l_type_id = ({NATURAL_16}).type_id then
						if attached {NATURAL_16_REF} a_value as l_value then
							create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item.as_integer_32)
						end
					elseif l_type_id = ({NATURAL_32}).type_id then
						if attached {NATURAL_32_REF} a_value as l_value then
							if l_value <= {INTEGER_32}.max_value.as_natural_32 then
								create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item.as_integer_32)
							else
								create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item.as_integer_64)
							end
						end
					elseif l_type_id = ({NATURAL_64}).type_id then
						if attached {NATURAL_64_REF} a_value as l_value then
							if l_value <= {INTEGER_32}.max_value.as_natural_64 then
								create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item.as_integer_32)
							elseif l_value <= {INTEGER_64}.max_value.as_natural_64 then
								create {SQLITE_INTEGER_ARG} l_scalar_result.make (a_var, l_value.item.as_integer_64)
							else
									--| Should not occur due to precondition is_valid_argument
								check unsupported_value_for_type_natural_64: False end
								create {SQLITE_INTEGER_ARG} Result.make (a_var, 0)
							end
						end
					elseif l_type_id = ({REAL_32}).type_id then
						if attached {REAL_32_REF} a_value as l_value then
							create {SQLITE_DOUBLE_ARG} l_scalar_result.make (a_var, l_value.item)
						end
					elseif l_type_id = ({REAL_64}).type_id then
						if attached {REAL_64_REF} a_value as l_value then
							create {SQLITE_DOUBLE_ARG} l_scalar_result.make (a_var, l_value.item)
						end
					elseif l_type_id = ({BOOLEAN}).type_id then
						if attached {BOOLEAN_REF} a_value as l_value then
							create {SQLITE_BOOLEAN_ARG} l_scalar_result.make (a_var, l_value.item)
						end
					else
							--| Should not occur due to precondition is_valid_argument
						check unsupported_type: False end
						create {SQLITE_NULL_ARG} Result.make (a_var)
					end
					check l_scalar_result_attached: attached l_scalar_result then
						-- Implied by precondition `is_valid_argument'
						Result := l_scalar_result
					end
				end
			else
				create {SQLITE_NULL_ARG} Result.make (a_var)
			end
		ensure
			result_attached: attached Result
			result_is_value_marshalled: is_value_marshalled (Result)
		end

;note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
