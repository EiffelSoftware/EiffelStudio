indexing
	description: "[
		ICorDebugStringValue
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_STRING_VALUE

inherit
	ICOR_DEBUG_VALUE
--		redefine
--			init_icor
--		end
--
--create 
--	make_by_pointer
--	
--
--feature {NONE} -- Initialization
--
--	init_icor is
--			-- 
--		do
--			Precursor
--			length := get_length
--			string := get_string (length)			
--		end
--		
--feature {ICOR_EXPORTER} -- Properties
--
--	length: INTEGER
--	
--	string: STRING
--	
--feature {ICOR_EXPORTER} -- Access
--
--	get_length: INTEGER is
--			-- GetLength
--		do
--			last_call_success := cpp_get_length (item, $Result)
--		ensure
----			success: last_call_success = 0
--		end
--
--	get_string (a_len: INTEGER): STRING is
--			-- GetString
--		local
--			p_nbfetched: INTEGER
--			mp_name: MANAGED_POINTER
--		do
--			create mp_name.make (( 1 + a_len ) * sizeof_WCHAR)
--			
--			last_call_success := cpp_get_string (item, a_len, $p_nbfetched, mp_name.item)
--			if mp_name.item /= default_pointer then
--				Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string
--			end
--		ensure
----			success: last_call_success = 0
--		end
--
--feature {NONE} -- Implementation
--
--	cpp_get_length (obj: POINTER; a_result: POINTER): INTEGER is
--		external
--			"[
--				C++ ICorDebugStringValue signature(ULONG32*): EIF_INTEGER 
--				use "cli_headers.h"
--			]"
--		alias
--			"GetLength"
--		end
--
--	cpp_get_string (obj: POINTER; a_cchstring: INTEGER; a_pcchstring: POINTER; a_pstring: POINTER): INTEGER is
--		external
--			"[
--				C++ ICorDebugStringValue signature(ULONG32, ULONG32*, WCHAR*): EIF_INTEGER 
--				use "cli_headers.h"
--			]"
--		alias
--			"GetString"
--		end
--
end -- class ICOR_DEBUG_STRING_VALUE

