indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE_FACTORY

inherit
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature -- Prepare value

	init_value (dv: DUMP_VALUE) is
		do
			if debug_output_evaluation_enabled_pref = Void then
				debug_output_evaluation_enabled_pref := preferences.debug_tool_data.debug_output_evaluation_enabled_preference
			end
			if generating_type_evaluation_enabled_pref = Void then
				generating_type_evaluation_enabled_pref := preferences.debug_tool_data.generating_type_evaluation_enabled_preference
			end
			dv.set_debugger_preferences (
						generating_type_evaluation_enabled_pref,
						debug_output_evaluation_enabled_pref
					)
		end

	generating_type_evaluation_enabled_pref,
	debug_output_evaluation_enabled_pref: BOOLEAN_PREFERENCE

feature -- Access

	new_boolean_value (value: BOOLEAN; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a boolean item initialized to `value'
		do
			create Result.make_empty
			Result.set_boolean_value (value, dtype)
			init_value (Result)
		end

	new_character_value (value: CHARACTER; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a character item initialized to `value'
		do
			create Result.make_empty
			Result.set_character_8_value (value, dtype)
			init_value (Result)
		end

	new_wide_character_value (value: WIDE_CHARACTER; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a wide_character item initialized to `value'
		do
			create Result.make_empty
			Result.set_character_32_value (value, dtype)
			init_value (Result)
		end

	new_integer_32_value  (value: INTEGER; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a integer item initialized to `value'
		do
			create Result.make_empty
			Result.set_integer_32_value (value, dtype)
			init_value (Result)
		end

	new_integer_64_value  (value: INTEGER_64; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a integer_64 item initialized to `value'
		do
			create Result.make_empty
			Result.set_integer_64_value (value, dtype)
			init_value (Result)
		end

	new_natural_8_value  (value: NATURAL_8; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a integer item initialized to `value'
		do
			create Result.make_empty
			Result.set_natural_8_value (value, dtype)
			init_value (Result)
		end

	new_natural_16_value  (value: NATURAL_16; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a integer item initialized to `value'
		do
			create Result.make_empty
			Result.set_natural_16_value (value, dtype)
			init_value (Result)
		end

	new_natural_32_value  (value: NATURAL_32; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a integer item initialized to `value'
		do
			create Result.make_empty
			Result.set_natural_32_value (value, dtype)
			init_value (Result)
		end

	new_natural_64_value  (value: NATURAL_64; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a integer_64 item initialized to `value'
		do
			create Result.make_empty
			Result.set_natural_64_value (value, dtype)
			init_value (Result)
		end

	new_real_value (value: REAL; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a real item initialized to `value'
		do
			create Result.make_empty
			Result.set_real_32_value (value, dtype)
			init_value (Result)
		end

	new_double_value (value: DOUBLE; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a double item initialized to `value'
		do
			create Result.make_empty
			Result.set_real_64_value (value, dtype)
			init_value (Result)
		end

	new_bits_value  (a_value, a_type: STRING; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- Make bit item of type `a_type' and class `dtype'
			-- initialized with `value'.
		require
			a_value_not_void: a_value /= Void
			a_type_not_void: a_type /= Void
			dtype_not_void: dtype /= Void
		do
			create Result.make_empty
			Result.set_bits_value (a_value, a_type, dtype)
			init_value (Result)
		end

	new_pointer_value (value: POINTER; dtype: CLASS_C): DUMP_VALUE_BASIC is
			-- make a pointer item initialized to `value'
		do
			create Result.make_empty
			Result.set_pointer_value (value, dtype)
			init_value (Result)
		end

	new_void_value (dtype: CLASS_C): DUMP_VALUE is
		do
			create Result.make_empty
			Result.set_void_value (dtype)
			init_value (Result)
		end

	new_object_value  (value: STRING; dtype: CLASS_C): DUMP_VALUE is
			-- make a object item initialized to `value'
		do
			create Result.make_empty
			Result.set_object_value (value, dtype)
			init_value (Result)
		end

	new_expanded_object_value  (addr: STRING; dtype: CLASS_C): DUMP_VALUE is
			-- Make an expanded object item of type `dtype'.
		require
			dtype_not_void: dtype /= Void
		do
			create Result.make_empty
			Result.set_expanded_object_value (addr, dtype)
			init_value (Result)
		end

	new_manifest_string_value  (value: STRING; dtype: CLASS_C): DUMP_VALUE is
			-- make a string item initialized to `value'
		do
			create Result.make_empty
			Result.set_manifest_string_value (value, dtype)
			init_value (Result)
		end

	new_exception_value  (value: EXCEPTION_DEBUG_VALUE): DUMP_VALUE is
		do
			create Result.make_empty
			Result.set_exception_value (value)
			init_value (Result)
		end

feature -- Dotnet creation

	new_string_for_dotnet_value  (a_eifnet_dsv: EIFNET_DEBUG_STRING_VALUE): DUMP_VALUE is
			-- make a object ICorDebugStringValue item initialized to `value'
		require
			arg_not_void: a_eifnet_dsv /= Void
		do
			create Result.make_empty
			Result.set_string_for_dotnet_value (a_eifnet_dsv)
		end

	new_object_for_dotnet_value  (a_eifnet_drv: EIFNET_DEBUG_REFERENCE_VALUE): DUMP_VALUE is
			-- make a object ICorDebugObjectValue item initialized to `value'
		require
			arg_not_void: a_eifnet_drv /= Void
		do
			create Result.make_empty
			Result.set_object_for_dotnet_value (a_eifnet_drv)
		end

	new_native_array_object_for_dotnet_value  (a_eifnet_dnav: EIFNET_DEBUG_NATIVE_ARRAY_VALUE): DUMP_VALUE is
			-- make a object ICorDebugObjectValue item initialized to `value'
		require
			arg_not_void: a_eifnet_dnav /= Void
		do
			create Result.make_empty
			Result.set_native_array_object_for_dotnet_value (a_eifnet_dnav)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end
