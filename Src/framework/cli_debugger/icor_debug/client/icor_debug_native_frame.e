note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_NATIVE_FRAME

inherit
	ICOR_DEBUG_FRAME

feature {ICOR_EXPORTER} -- Access

	get_ip: NATURAL_32
			-- get OffSet
		do
			set_last_call_success (cpp_get_ip (item, $Result))
		ensure
			success: last_call_success = 0
		end

	get_register_set: ICOR_DEBUG_REGISTER_SET
			-- get OffSet
		local
			l_p: POINTER
		do
			set_last_call_success (cpp_get_register_set (item, $l_p))
			if l_p /= default_pointer then
				Result := new_register_set (l_p)
			end
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_ip (obj: POINTER; a_p_offset: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugNativeFrame signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetIP"
		end

	cpp_get_register_set (obj: POINTER; a_p_register: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugNativeFrame signature(ICorDebugRegisterSet**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetRegisterSet"
		end


end
