indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FRAME

inherit
	ICOR_OBJECT

create 
	make_by_pointer
	

feature {ICOR_EXPORTER} -- QueryInterface

	query_interface_icor_debug_il_frame: ICOR_DEBUG_IL_FRAME is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugILFrame (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
				Result.add_ref
			end
		ensure
--			success: last_call_success = 0
		end

	query_interface_icor_debug_native_frame: ICOR_DEBUG_NATIVE_FRAME is
		local
			p: POINTER
		do
			last_call_success := cpp_query_interface_ICorDebugNativeFrame (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
				Result.add_ref
			end
		ensure
--			success: last_call_success = 0
		end

feature {ICOR_EXPORTER} -- Access

	get_chain: ICOR_DEBUG_CHAIN is
		local
			p: POINTER
		do
			last_call_success := cpp_get_chain (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_code: ICOR_DEBUG_CODE is
		local
			p: POINTER
		do
			last_call_success := cpp_get_code (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_function: ICOR_DEBUG_FUNCTION is
		local
			p: POINTER
		do
			last_call_success := cpp_get_function (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_function_token: INTEGER is
		do
			last_call_success := cpp_get_function_token (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_caller: ICOR_DEBUG_FRAME is
		local
			p: POINTER
		do
			last_call_success := cpp_get_caller (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
--			success: last_call_success = 0
		end

	get_callee: ICOR_DEBUG_FRAME is
		local
			p: POINTER
		do
			last_call_success := cpp_get_callee (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
--			success: last_call_success = 0
		end

	create_stepper: ICOR_DEBUG_STEPPER is
		local
			l_p_stepper: POINTER
		do
			last_call_success := cpp_create_stepper (item, $l_p_stepper)
			if l_p_stepper /= default_pointer then
				create Result.make_by_pointer (l_p_stepper)
			end
		ensure
--			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_chain (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugChain**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetChain"
		end

	cpp_get_code (obj: POINTER; a_p_code: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugCode**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetCode"
		end

	cpp_get_function (obj: POINTER; a_p_function: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugFunction**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetFunction"
		end

	cpp_get_function_token (obj: POINTER; a_p: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugFrame signature(mdMethodDef*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetFunctionToken"
		end

	cpp_get_caller (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugFrame**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetCaller"
		end

	cpp_get_callee (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugFrame**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetCallee"
		end

	cpp_create_stepper (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFrame signature(ICorDebugStepper**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"CreateStepper"
		end

feature {NONE} -- Implementation / Constants

	cpp_query_interface_ICorDebugILFrame (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugFrame *) $obj)->QueryInterface (IID_ICorDebugILFrame, (void **) $a_p)"
		end
		
	cpp_query_interface_ICorDebugNativeFrame (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"C++ inline use %"cli_debugger_utils.h%""
		alias
			"((ICorDebugFrame *) $obj)->QueryInterface (IID_ICorDebugNativeFrame, (void **) $a_p)"
		end		

end -- class ICOR_DEBUG_FRAME

