indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_CHAIN_ENUM

inherit
	ICOR_DEBUG_ENUM_WITH_NEXT [ICOR_DEBUG_CHAIN]

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

--	next (a_celt: INTEGER): ARRAY [ICOR_DEBUG_CHAIN] is
--		require
--			celt_positive: a_celt > 0
--		local
--			l_p: POINTER
--			p_celt_fetched: INTEGER
--			mp_tab: MANAGED_POINTER
--			i: INTEGER
--			l_icor: ICOR_DEBUG_CHAIN
--		do
--			create mp_tab.make (a_celt * feature {PLATFORM}.pointer_bytes)
--			last_call_success := cpp_next (item, a_celt, mp_tab.item, $p_celt_fetched)
--			if p_celt_fetched > 0 then
--				from
--					i := 1
--					create Result.make (1, p_celt_fetched)
--				until
--					i > p_celt_fetched
--				loop
--					l_p := mp_tab.read_pointer(i - 1)
--					create l_icor.make_by_pointer (l_p)
--					l_icor.add_ref
--					Result.put (l_icor, i)
--					i := i + 1
--				end
--			end
--		ensure
--			success: last_call_success = 0
--		end

feature {NONE} -- Implementation

	call_cpp_next (obj: POINTER; a_celt: INTEGER; a_p: POINTER; a_pceltfetched: POINTER): INTEGER is
		do
			Result := cpp_next (obj, a_celt, a_p, a_pceltfetched)
		end

	cpp_next (obj: POINTER; a_celt: INTEGER; a_p: POINTER; a_pceltfetched: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugChainEnum signature(ULONG,ICorDebugChain**, ULONG*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Next"
		end

end -- class ICOR_DEBUG_CHAIN_ENUM

