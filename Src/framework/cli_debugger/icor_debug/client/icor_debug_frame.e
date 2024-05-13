note
	description: "[
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_FRAME

inherit
	ICOR_DEBUG_I

feature {ICOR_EXPORTER} -- QueryInterface

	query_interface_icor_debug_il_frame: ICOR_DEBUG_IL_FRAME
		require
			item /= Default_pointer
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugILFrame (item, $p))
			if p /= default_pointer then
				Result := new_il_frame (p)
			end
		end

	query_interface_icor_debug_native_frame: ICOR_DEBUG_NATIVE_FRAME
		require
			item /= Default_pointer
		local
			p: POINTER
		do
			set_last_call_success (cpp_query_interface_ICorDebugNativeFrame (item, $p))
			if p /= default_pointer then
				Result := new_native_frame (p)
			end
		end

feature {ICOR_EXPORTER} -- Access

	get_chain: ICOR_DEBUG_CHAIN
		require
			item /= Default_pointer
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_chain (item, $p))
			if p /= default_pointer then
				Result := new_chain (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_code: ICOR_DEBUG_CODE
		require
			item /= Default_pointer
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_code (item, $p))
			if p /= default_pointer then
				Result := new_code (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_function: ICOR_DEBUG_FUNCTION
		require
			item /= Default_pointer
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_function (item, $p))
			if p /= default_pointer then
				Result := Icor_objects_manager.icd_function (p, Current)
			end
		end

	get_function_token: NATURAL_32
		require
			item /= Default_pointer
		do
			set_last_call_success (cpp_get_function_token (item, $Result))
		ensure
			success: last_call_success = 0
		end

	get_caller: ICOR_DEBUG_FRAME
		require
			item /= Default_pointer
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_caller (item, $p))
			if p /= default_pointer then
				Result := new_frame (p)
			end
		end

	get_callee: ICOR_DEBUG_FRAME
		require
			item /= Default_pointer
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_callee (item, $p))
			if p /= default_pointer then
				Result := new_frame (p)
			end
		end

	create_stepper: ICOR_DEBUG_STEPPER
		require
			item /= Default_pointer
		local
			p: POINTER
		do
			set_last_call_success (cpp_create_stepper (item, $p))
			if p /= default_pointer then
				Result := new_stepper (p)
			end
		ensure
--			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_chain (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugChain**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetChain"
		end

	cpp_get_code (obj: POINTER; a_p_code: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugCode**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCode"
		end

	cpp_get_function (obj: POINTER; a_p_function: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugFunction**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetFunction"
		end

	cpp_get_function_token (obj: POINTER; a_p: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugFrame signature(mdMethodDef*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetFunctionToken"
		end

	cpp_get_caller (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugFrame**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCaller"
		end

	cpp_get_callee (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugFrame**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCallee"
		end

	cpp_create_stepper (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugStepper**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"CreateStepper"
		end

feature {NONE} -- Implementation / Constants

	cpp_query_interface_ICorDebugILFrame (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugFrame *) $obj)->QueryInterface (IID_ICorDebugILFrame, (void **) $a_p)"
		end

	cpp_query_interface_ICorDebugNativeFrame (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugFrame *) $obj)->QueryInterface (IID_ICorDebugNativeFrame, (void **) $a_p)"
		end

note
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

end -- class ICOR_DEBUG_FRAME

