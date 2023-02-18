note
	date: "$Date$"
	revision: "$Revision$"

class
	DUMP_VALUE_FACTORY

inherit
	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (dbg: like debugger_manager)
			-- Instanciate Current with `dbg'
		require
			dbg_attached: dbg /= Void
		do
			debugger_manager := dbg
		end

	debugger_manager: DEBUGGER_MANAGER
			-- Associated debugger

feature {DEBUGGER_MANAGER} -- Change

	set_debug_output_evaluation_enabled (b: like debug_output_evaluation_enabled)
			-- Set `debug_output_evaluation_enabled' to `b'
		do
			debug_output_evaluation_enabled := b
		end

feature {NONE} -- Properties		

	debug_output_evaluation_enabled: BOOLEAN
			-- Is `{DEBUG_OUTPUT}.debug_output' evaluation enabled?

feature -- Prepare value

	init_value (dv: DUMP_VALUE)
			-- Initialize value `dv' with optional parameters
		require
			dv_attached: dv /= Void
		do
			dv.set_debug_output_evaluation_enabled (debug_output_evaluation_enabled)
		end

feature -- Access

	new_boolean_value (value: BOOLEAN; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a boolean item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_boolean_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_character_value (value: CHARACTER; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a character item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_character_8_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_character_32_value (value: CHARACTER_32; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a character_32 item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_character_32_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_integer_8_value  (value: INTEGER_8; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a integer item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_integer_8_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_integer_16_value  (value: INTEGER_16; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a integer item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_integer_16_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_integer_32_value  (value: INTEGER_32; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a integer item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_integer_32_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_integer_64_value  (value: INTEGER_64; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a integer_64 item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_integer_64_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_natural_8_value  (value: NATURAL_8; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a integer item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_natural_8_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_natural_16_value  (value: NATURAL_16; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a integer item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_natural_16_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_natural_32_value  (value: NATURAL_32; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a integer item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_natural_32_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_natural_64_value  (value: NATURAL_64; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a integer_64 item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_natural_64_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_real_32_value (value: REAL_32; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a real item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_real_32_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_real_64_value (value: REAL_64; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a real_64 item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_real_64_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_bits_value  (a_value, a_type: STRING; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- Make bit item of type `a_type' and class `dtype'
			-- initialized with `value'.
		require
			a_value_not_void: a_value /= Void
			a_type_not_void: a_type /= Void
			dtype_not_void: dtype /= Void
		do
			create Result.make_empty (debugger_manager)
			Result.set_bits_value (a_value, a_type, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_pointer_value (value: POINTER; dtype: CLASS_C): DUMP_VALUE_BASIC
			-- make a pointer item initialized to `value'
		do
			create Result.make_empty (debugger_manager)
			Result.set_pointer_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_void_value (dtype: CLASS_C): DUMP_VALUE
		do
			create Result.make_empty (debugger_manager)
			Result.set_void_value (dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_object_value (addr: DBG_ADDRESS; a_dtype: CLASS_C; a_scp_pid: NATURAL_16): DUMP_VALUE
			-- make a object item initialized to `value'
		require
			(addr /= Void and then not addr.is_void) implies a_dtype /= Void
		do
			if debugger_manager.is_dotnet_project then
				create {DUMP_VALUE_DOTNET} Result.make_empty (debugger_manager)
			else
				create Result.make_empty (debugger_manager)
			end
			Result.set_object_value (addr, a_dtype, a_scp_pid)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_incomplete_object_value (addr: DBG_ADDRESS): DUMP_VALUE
		local
			dobj: detachable DEBUGGED_OBJECT
			dtype: CLASS_C
			scp_pid: NATURAL_16
		do
			if addr /= Void and then not addr.is_void then
				dobj := debugger_manager.object_manager.object_at_address (addr)
				dtype := dobj.dynamic_class
				scp_pid := dobj.scoop_processor_id
			end
			Result := new_object_value (addr, dtype, scp_pid)
		end

	new_expanded_object_value  (addr: DBG_ADDRESS; dtype: CLASS_C; a_scp_pid: NATURAL_16): DUMP_VALUE
			-- Make an expanded object item of type `dtype'.
		require
			dtype_not_void: dtype /= Void
		do
			create Result.make_empty (debugger_manager)
			Result.set_expanded_object_value (addr, dtype, a_scp_pid)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_manifest_string_value  (value: STRING; dtype: CLASS_C): DUMP_VALUE
			-- make a string item initialized to `value'
		require
			value_attached: value /= Void
		do
			create Result.make_empty (debugger_manager)
			Result.set_manifest_string_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_manifest_string_32_value  (value: READABLE_STRING_32; dtype: CLASS_C): DUMP_VALUE
			-- make a string item initialized to `value'
		require
			value_attached: value /= Void
		do
			create Result.make_empty (debugger_manager)
			Result.set_manifest_string_32_value (value, dtype)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_exception_value (value: EXCEPTION_DEBUG_VALUE): DUMP_VALUE
		do
			create Result.make_empty (debugger_manager)
			Result.set_exception_value (value)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_procedure_return_value  (value: PROCEDURE_RETURN_DEBUG_VALUE): DUMP_VALUE
		do
			create Result.make_empty (debugger_manager)
			Result.set_procedure_return_value (value)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

feature -- Dotnet creation

	new_string_for_dotnet_value  (a_eifnet_dsv: EIFNET_DEBUG_STRING_VALUE): DUMP_VALUE_DOTNET
			-- make a object ICorDebugStringValue item initialized to `value'
		require
			arg_not_void: a_eifnet_dsv /= Void
		do
			create Result.make_empty (debugger_manager)
			Result.set_string_for_dotnet_value (a_eifnet_dsv)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_object_for_dotnet_value  (a_eifnet_drv: EIFNET_DEBUG_REFERENCE_VALUE): DUMP_VALUE_DOTNET
			-- make a object ICorDebugObjectValue item initialized to `value'
		require
			arg_not_void: a_eifnet_drv /= Void
		do
			create Result.make_empty (debugger_manager)
			Result.set_object_for_dotnet_value (a_eifnet_drv)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

	new_native_array_object_for_dotnet_value  (a_eifnet_dnav: EIFNET_DEBUG_NATIVE_ARRAY_VALUE): DUMP_VALUE_DOTNET
			-- make a object ICorDebugObjectValue item initialized to `value'
		require
			arg_not_void: a_eifnet_dnav /= Void
		do
			create Result.make_empty (debugger_manager)
			Result.set_native_array_object_for_dotnet_value (a_eifnet_dnav)
			init_value (Result)
		ensure
			Result_attached: Result /= Void
		end

invariant

	debugger_manager_not_void: debugger_manager /= Void

note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
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
