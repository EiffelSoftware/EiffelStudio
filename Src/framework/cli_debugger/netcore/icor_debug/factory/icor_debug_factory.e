note
	description: "Create CorDebug instances."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FACTORY

inherit
	ICOR_DEBUG_FACTORY_I

feature {ICOR_EXPORTER} -- Factory

	new_md_import (p: POINTER): ICOR_MD_IMPORT_I
		do
			create {ICOR_MD_IMPORT} Result.make_by_pointer (p)
		end

	new_controller (p: POINTER): ICOR_DEBUG_CONTROLLER_I
		do
			create {ICOR_DEBUG_CONTROLLER} Result.make_by_pointer (p)
		end

	new_assembly (p: POINTER): ICOR_DEBUG_ASSEMBLY_I
		do
			create {ICOR_DEBUG_ASSEMBLY} Result.make_by_pointer (p)
		end

	new_app_domain (p: POINTER): ICOR_DEBUG_APP_DOMAIN_I
		do
			create {ICOR_DEBUG_APP_DOMAIN} Result.make_by_pointer (p)
		end

	new_module (p: POINTER): ICOR_DEBUG_MODULE_I
		do
			create {ICOR_DEBUG_MODULE} Result.make_by_pointer (p)
		end

	new_class (p: POINTER): ICOR_DEBUG_CLASS_I
		do
			create {ICOR_DEBUG_CLASS} Result.make_by_pointer (p)
		end

	new_chain (p: POINTER): ICOR_DEBUG_CHAIN_I
		do
			create {ICOR_DEBUG_CHAIN} Result.make_by_pointer (p)
		end

	new_code (p: POINTER): ICOR_DEBUG_CODE_I
		do
			create {ICOR_DEBUG_CODE} Result.make_by_pointer (p)
		end

	new_function (p: POINTER): ICOR_DEBUG_FUNCTION_I
		do
			create {ICOR_DEBUG_FUNCTION} Result.make_by_pointer (p)
		end

	new_thread (p: POINTER): ICOR_DEBUG_THREAD_I
		do
			create {ICOR_DEBUG_THREAD} Result.make_by_pointer (p)
		end

	new_register_set (p: POINTER): ICOR_DEBUG_REGISTER_SET_I
		do
			create {ICOR_DEBUG_REGISTER_SET} Result.make_by_pointer (p)
		end

	new_frame (p: POINTER): ICOR_DEBUG_FRAME_I
		do
			create {ICOR_DEBUG_FRAME} Result.make_by_pointer (p)
		end

	new_native_frame (p: POINTER): ICOR_DEBUG_NATIVE_FRAME_I
		do
			create {ICOR_DEBUG_NATIVE_FRAME} Result.make_by_pointer (p)
		end

	new_il_frame (p: POINTER): ICOR_DEBUG_IL_FRAME_I
		do
			create {ICOR_DEBUG_IL_FRAME} Result.make_by_pointer (p)
		end

	new_stepper (p: POINTER): ICOR_DEBUG_STEPPER_I
		do
			create {ICOR_DEBUG_STEPPER} Result.make_by_pointer (p)
		end

	new_function_breakpoint (p: POINTER): ICOR_DEBUG_FUNCTION_BREAKPOINT_I
		do
			create {ICOR_DEBUG_FUNCTION_BREAKPOINT} Result.make_by_pointer (p)
		end

	new_breakpoint (p: POINTER): ICOR_DEBUG_BREAKPOINT_I
		do
			create {ICOR_DEBUG_BREAKPOINT} Result.make_by_pointer (p)
		end

	new_module_breakpoint (p: POINTER): ICOR_DEBUG_MODULE_BREAKPOINT_I
		do
			create {ICOR_DEBUG_MODULE_BREAKPOINT} Result.make_by_pointer (p)
		end

	new_value_breakpoint (p: POINTER): ICOR_DEBUG_VALUE_BREAKPOINT_I
		do
			create {ICOR_DEBUG_VALUE_BREAKPOINT} Result.make_by_pointer (p)
		end

	new_eval (p: POINTER): ICOR_DEBUG_EVAL_I
		do
			create {ICOR_DEBUG_EVAL} Result.make_by_pointer (p)
		end

	new_process (p: POINTER): ICOR_DEBUG_PROCESS_I
		do
			create {ICOR_DEBUG_PROCESS} Result.make_by_pointer (p)
		end

feature -- Value

	new_value (p: POINTER): ICOR_DEBUG_VALUE_I
		do
			create {ICOR_DEBUG_VALUE} Result.make_by_pointer (p)
		end

	new_handle_value (p: POINTER): ICOR_DEBUG_HANDLE_VALUE_I
		do
			create {ICOR_DEBUG_HANDLE_VALUE} Result.make_by_pointer (p)
		end

	new_generic_value (p: POINTER): ICOR_DEBUG_GENERIC_VALUE_I
		do
			create {ICOR_DEBUG_GENERIC_VALUE} Result.make_by_pointer (p)
		end

	new_array_value (p: POINTER): ICOR_DEBUG_ARRAY_VALUE_I
		do
			create {ICOR_DEBUG_ARRAY_VALUE} Result.make_by_pointer (p)
		end

	new_box_value (p: POINTER): ICOR_DEBUG_BOX_VALUE_I
		do
			create {ICOR_DEBUG_BOX_VALUE} Result.make_by_pointer (p)
		end

	new_reference_value (p: POINTER): ICOR_DEBUG_REFERENCE_VALUE_I
		do
			create {ICOR_DEBUG_REFERENCE_VALUE} Result.make_by_pointer (p)
		end

	new_string_value (p: POINTER): ICOR_DEBUG_STRING_VALUE_I
		do
			create {ICOR_DEBUG_STRING_VALUE} Result.make_by_pointer (p)
		end

	new_object_value (p: POINTER): ICOR_DEBUG_OBJECT_VALUE_I
		do
			create {ICOR_DEBUG_OBJECT_VALUE} Result.make_by_pointer (p)
		end

	new_heap_value (p: POINTER): ICOR_DEBUG_HEAP_VALUE_I
		do
			create {ICOR_DEBUG_HEAP_VALUE} Result.make_by_pointer (p)
		end

	new_heap_value2 (p: POINTER): ICOR_DEBUG_HEAP_VALUE2_I
		do
			create {ICOR_DEBUG_HEAP_VALUE2} Result.make_by_pointer (p)
		end

feature -- Enum	

	new_enum (p: POINTER): ICOR_DEBUG_ENUM_I
		do
			create {ICOR_DEBUG_ENUM} Result.make_by_pointer (p)
		end

	new_frame_enum (p: POINTER): ICOR_DEBUG_FRAME_ENUM_I
		do
			create {ICOR_DEBUG_FRAME_ENUM} Result.make_by_pointer (p)
		end

	new_stepper_enum (p: POINTER): ICOR_DEBUG_STEPPER_ENUM_I
		do
			create {ICOR_DEBUG_STEPPER_ENUM} Result.make_by_pointer (p)
		end

	new_breakpoint_enum (p: POINTER): ICOR_DEBUG_BREAKPOINT_ENUM_I
		do
			create {ICOR_DEBUG_BREAKPOINT_ENUM} Result.make_by_pointer (p)
		end

	new_assembly_enum (p: POINTER): ICOR_DEBUG_ASSEMBLY_ENUM_I
		do
			create {ICOR_DEBUG_ASSEMBLY_ENUM} Result.make_by_pointer (p)
		end

	new_app_domain_enum (p: POINTER): ICOR_DEBUG_APP_DOMAIN_ENUM_I
		do
			create {ICOR_DEBUG_APP_DOMAIN_ENUM} Result.make_by_pointer (p)
		end

	new_module_enum (p: POINTER): ICOR_DEBUG_MODULE_ENUM_I
		do
			create {ICOR_DEBUG_MODULE_ENUM} Result.make_by_pointer (p)
		end

	new_chain_enum (p: POINTER): ICOR_DEBUG_CHAIN_ENUM_I
		do
			create {ICOR_DEBUG_CHAIN_ENUM} Result.make_by_pointer (p)
		end

	new_value_enum (p: POINTER): ICOR_DEBUG_VALUE_ENUM_I
		do
			create {ICOR_DEBUG_VALUE_ENUM} Result.make_by_pointer (p)
		end

	new_thread_enum (p: POINTER): ICOR_DEBUG_THREAD_ENUM_I
		do
			create {ICOR_DEBUG_THREAD_ENUM} Result.make_by_pointer (p)
		end

feature {ICOR_EXPORTER} -- Initialization

	new_cordebug_pointer_for (a_dbg_version: READABLE_STRING_GENERAL): POINTER
			-- Create a new instance of ICorDebug for `a_dbg_version'.
		local
			l_version: CLI_STRING
			res: INTEGER
		do
			--initialize_com
			if a_dbg_version = Void then
				create l_version.make ((create {IL_ENVIRONMENT}).default_version)
			else
				create l_version.make (a_dbg_version)
			end
			res := c_get_cordebug (l_version.item, $Result)
		ensure
			class
		rescue
			retry
		end

	new_cordebug_managed_callback: ICOR_DEBUG_MANAGED_CALLBACK
			-- Create a new instance of ICOR_DEBUG_MANAGED_CALLBACK.
		local
			p: POINTER
		do
			--initialize_com
			p := cpp_new_cordebug_managed_callback
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			result_exist: Result /= Void
			class
		end

	new_cordebug_unmanaged_callback: ICOR_DEBUG_UNMANAGED_CALLBACK
			-- Create a new instance of ICOR_DEBUG_MUNANAGED_CALLBACK.
		local
			p: POINTER
		do
			--initialize_com
			p := cpp_new_cordebug_unmanaged_callback
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			result_exists: Result /= Void
			class
		end

feature {NONE} -- Externals

	c_get_cordebug (a_dbg_version: POINTER; a_cor_debug: TYPED_POINTER [POINTER]): INTEGER
			-- New instance of ICorDebug
		external
			"C signature (LPWSTR, EIF_POINTER **): EIF_INTEGER use %"cli_debugger.h%""
		alias
			"get_cordebug"
		ensure
			class
		end

	cpp_new_cordebug_managed_callback: POINTER
			-- create an instance of DebuggerManagedCallback
		external
			"[
				C++ creator DebuggerManagedCallback
				signature ()
				use "cli_debugger_callback.h"
			]"
		ensure
			class
		end

	cpp_new_cordebug_unmanaged_callback: POINTER
			-- create an instance of DebuggerUnmanagedCallback
		external
			"[
				C++ creator DebuggerUnmanagedCallback
				signature ()
				use "cli_debugger_callback.h"
			]"
		ensure
			class
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
