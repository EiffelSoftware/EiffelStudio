note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_STRING_VALUE

inherit
	ICOR_DEBUG_HEAP_VALUE

feature {ICOR_EXPORTER} -- Access

	get_length: NATURAL_32
			-- GetLength
		do
			set_last_call_success (cpp_get_length (item, $Result))
		end

	get_string (a_len: NATURAL_32): detachable STRING_32
			-- GetString
		local
			p_nbfetched: NATURAL_32
			mp_name: MANAGED_POINTER
			ws: CLI_STRING
		do
			create mp_name.make ((1 + a_len.as_integer_32) * sizeof_WCHAR)

			set_last_call_success (cpp_get_string (item, a_len, $p_nbfetched, mp_name.item))
			if mp_name.item /= default_pointer then
				create ws.make_by_pointer (mp_name.item)
				Result := ws.string_32 -- ubstring (1, a_len.min (p_nbfetched.to_integer_32))
			end
		end

feature {NONE} -- Implementation

	cpp_get_length (obj: POINTER; a_result: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugStringValue signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetLength"
		end

	cpp_get_string (obj: POINTER; a_cchstring: NATURAL_32; a_pcchstring: TYPED_POINTER [NATURAL_32]; a_pstring: POINTER): INTEGER
		external
			"[
				C++ ICorDebugStringValue signature(ULONG32, ULONG32*, WCHAR*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetString"
		end

end
