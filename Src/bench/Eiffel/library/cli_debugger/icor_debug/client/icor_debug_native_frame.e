indexing
	description: "[ 
		interface ICorDebugNativeFrame : ICorDebugFrame
			GetIP
			SetIP
			GetRegisterSet
			GetLocalRegisterValue
			GetLocalDoubleRegisterValue
			GetLocalMemoryValue
			GetLocalRegisterMemoryValue
			GetLocalMemoryRegisterValue
			CanSetIP
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_NATIVE_FRAME

inherit
	ICOR_DEBUG_FRAME

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	get_ip: INTEGER is
			-- get OffSet
		do
			last_call_success := cpp_get_ip (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_register_set: ICOR_DEBUG_REGISTER_SET is
			-- get OffSet
		local
			l_p: POINTER
		do
			last_call_success := cpp_get_register_set (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

feature {NONE} -- Implementation

	cpp_get_ip (obj: POINTER; a_p_offset: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugNativeFrame signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetIP"
		end

	cpp_get_register_set (obj: POINTER; a_p_register: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugNativeFrame signature(ICorDebugRegisterSet**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetRegisterSet"
		end



end -- class ICOR_DEBUG_NATIVE_FRAME

