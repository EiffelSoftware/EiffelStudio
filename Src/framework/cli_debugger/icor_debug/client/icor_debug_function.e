note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_FUNCTION

inherit
	ICOR_DEBUG_I

feature -- Addons

	to_function_name: detachable STRING_32
		do
			Result := get_module.md_member_name (token)
		end

	to_string: STRING_32
			-- String representation of the Current ICorDebugFunction.
			-- For debug purpose only
		do
			create Result.make_from_string ("Function [")
			Result.append_string (item.out)
			Result.append_character (']')
			Result.append_string (" Token=" + token.out + "~0x" + token.to_hex_string)
			if attached get_class as l_cl then
				Result.append (" ClassToken=" + l_cl.token.out + "~0x" + l_cl.token.to_hex_string)
--				l_cl.clean_on_dispose
			else
				Result.append (" Class=not IL ")
			end
			if attached get_module as l_module then
				Result.append ({STRING_32} " Module[" + l_module.get_token.out + "]=" + l_module.name + " .")
			else
				Result.append (" Module=None ")
			end
		ensure
			Result_attached: Result /= Void
		end

feature {ICOR_EXPORTER} -- Access

	token: NATURAL_32
			-- Feature's token
		do
			--| FIXME jfiat [2008/11/12] : maybe try to cache the value ...
			Result := get_token
		end

feature {ICOR_EXPORTER} -- Access

	get_module: detachable ICOR_DEBUG_MODULE
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_module (item, $p))
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_module (p, Current)
			end
		ensure
			success: last_call_success = 0
		end

	get_class: detachable ICOR_DEBUG_CLASS
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_class (item, $p))
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_class (p, Current)
			end
		ensure
			success: last_call_success = 0
		end

	get_il_code: detachable ICOR_DEBUG_CODE
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_il_code (item, $p))
			if p /= default_pointer then
				Result := new_code (p)
			end
--		ensure
--			success: last_call_success = 0
		end

	get_native_code: detachable ICOR_DEBUG_CODE
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_native_code (item, $p))
			if p /= default_pointer then
				Result := new_code (p)
			end
--		ensure
--			success: last_call_success = 0
		end

	create_breakpoint: detachable ICOR_DEBUG_FUNCTION_BREAKPOINT
		local
			p: POINTER
		do
			set_last_call_success (cpp_create_breakpoint (item, $p))
			if p /= default_pointer then
				Result := new_function_breakpoint (p)
			end
			debug ("DBG")
				if not last_call_succeed then
					io.put_string ("ERROR ["+ last_error_code_id +"]: while create_breakpoint on ICorDebugFunction ")

				end
			end
--		ensure
--			success: last_call_success = 0
		end

	get_local_var_sig_token: NATURAL_32
			-- Returns mdSignature of Function
		do
			set_last_call_success (cpp_get_local_var_sig_token (item, $Result))
		ensure
			success: last_call_success = 0
		end

	get_current_version_number: NATURAL_32
			-- Returns version number of code
		do
			set_last_call_success (cpp_get_current_version_number (item, $Result))
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Access

	get_token: like token
		do
			set_last_call_success (cpp_get_token (item, $Result))
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_module (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugModule**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetModule"
		end

	cpp_get_class (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugClass**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetClass"
		end

	cpp_get_token (obj: POINTER; a_p: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugFunction signature(mdMethodDef*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetToken"
		end

	cpp_get_il_code (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugCode**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetILCode"
		end

	cpp_get_native_code (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugCode**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetNativeCode"
		end

	cpp_create_breakpoint (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugFunctionBreakpoint**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"CreateBreakpoint"
		end

	cpp_get_local_var_sig_token (obj: POINTER; a_p_token: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugFunction signature(mdSignature*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetLocalVarSigToken"
		end

	cpp_get_current_version_number (obj: POINTER; a_p_vers_number: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugFunction signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCurrentVersionNumber"
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

