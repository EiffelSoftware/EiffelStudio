indexing
	description: "[
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FUNCTION

inherit
	ICOR_OBJECT
		export
			{ICOR_OBJECTS_MANAGER} clean_on_dispose
		redefine
			init_icor
		end

create {ICOR_OBJECTS_MANAGER}
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	init_icor is
			--
		do
			Precursor
			token := get_token
		end

feature -- Addons

	to_function_name: STRING is
		do
			Result := get_module.md_member_name (get_token)
		end

	to_string: STRING is
			-- String representation of the Current ICorDebugFunction.
			-- For debug purpose only
		local
			l_cl: ICOR_DEBUG_CLASS
			l_module: ICOR_DEBUG_MODULE
		do
			Result := "Function [" + item.out + "] "
					+ " Token="+ get_token.out + "~0x" + get_token.to_hex_string
			l_cl := get_class
			if l_cl /= Void then
				Result.append (" ClassToken=" + l_cl.get_token.out + "~0x" + l_cl.get_token.to_hex_string)
--				l_cl.clean_on_dispose
			else
				Result.append (" Class= not IL ")
			end
			l_module := get_module
			Result.append (" Module[" + l_module.get_token.out + "]=" + l_module.get_name + " .")
		end

feature {ICOR_EXPORTER} -- Access

	token: INTEGER

feature {ICOR_EXPORTER} -- Access

	get_module: ICOR_DEBUG_MODULE is
		local
			p: POINTER
		do
			last_call_success := cpp_get_module (item, $p)
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_module (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_class: ICOR_DEBUG_CLASS is
		local
			p: POINTER
		do
			last_call_success := cpp_get_class (item, $p)
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_class (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_token: INTEGER is
		do
			last_call_success := cpp_get_token (item, $Result)
			token := Result
		ensure
			success: last_call_success = 0
		end

	get_il_code: ICOR_DEBUG_CODE is
		local
			p: POINTER
		do
			last_call_success := cpp_get_il_code (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
--		ensure
--			success: last_call_success = 0
		end

	get_native_code: ICOR_DEBUG_CODE is
		local
			p: POINTER
		do
			last_call_success := cpp_get_native_code (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
--		ensure
--			success: last_call_success = 0
		end

	create_breakpoint: ICOR_DEBUG_FUNCTION_BREAKPOINT is
		local
			p: POINTER
		do
			last_call_success := cpp_create_breakpoint (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
			debug ("DBG")
				if not last_call_succeed then
					io.put_string ("ERROR ["+ last_error_code_id +"]: while create_breakpoint on ICorDebugFunction ")

				end
			end
--		ensure
--			success: last_call_success = 0
		end

	get_local_var_sig_token: INTEGER is
			-- Returns mdSignature of Function
		do
			last_call_success := cpp_get_local_var_sig_token (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_current_version_number: INTEGER is
			-- Returns version number of code
		do
			last_call_success := cpp_get_current_version_number (item, $Result)
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_module (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugModule**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetModule"
		end

	cpp_get_class (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugClass**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetClass"
		end

	cpp_get_token (obj: POINTER; a_p: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(mdMethodDef*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetToken"
		end

	cpp_get_il_code (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugCode**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetILCode"
		end

	cpp_get_native_code (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugCode**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetNativeCode"
		end

	cpp_create_breakpoint (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugFunctionBreakpoint**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"CreateBreakpoint"
		end

	cpp_get_local_var_sig_token (obj: POINTER; a_p_token: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(mdSignature*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetLocalVarSigToken"
		end

	cpp_get_current_version_number (obj: POINTER; a_p_vers_number: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCurrentVersionNumber"
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

end -- class ICOR_DEBUG_FUNCTION

