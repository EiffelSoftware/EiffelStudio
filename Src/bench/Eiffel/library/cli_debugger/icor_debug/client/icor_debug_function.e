indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FUNCTION

inherit

	ICOR_OBJECT
		redefine
			init_icor
		end

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	init_icor is
			-- 
		do
			Precursor
			token := get_token
		end	
	
feature -- Addons

	to_string: STRING is
			-- 
		do
			Result := "Function [Ox" + item.out + "] " 
					+ " Token="+ get_token.out + "~0x"+get_token.to_hex_string
			if get_class /= Void then
				Result.append (" ClassToken=" + get_class.get_token.out + "~0x"+get_class.get_token.to_hex_string)
			else
				Result.append (" Class= not IL ")
				
			end
			Result.append (" Module["+get_module.get_token.out+"]=" + get_module.get_name + " .")
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
				create Result.make_by_pointer (p)
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
				create Result.make_by_pointer (p)
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
				use "cli_headers.h"
			]"
		alias
			"GetModule"
		end

	cpp_get_class (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugClass**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetClass"
		end

	cpp_get_token (obj: POINTER; a_p: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(mdMethodDef*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetToken"
		end

	cpp_get_il_code (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugCode**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetILCode"
		end

	cpp_get_native_code (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugCode**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetNativeCode"
		end

	cpp_create_breakpoint (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ICorDebugFunctionBreakpoint**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"CreateBreakpoint"
		end

	cpp_get_local_var_sig_token (obj: POINTER; a_p_token: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(mdSignature*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetLocalVarSigToken"
		end

	cpp_get_current_version_number (obj: POINTER; a_p_vers_number: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugFunction signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetCurrentVersionNumber"
		end

end -- class ICOR_DEBUG_FUNCTION

