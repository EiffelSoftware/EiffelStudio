indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_STEPPER_ENUM

inherit

	ICOR_DEBUG_ENUM_WITH_NEXT [ICOR_DEBUG_STEPPER]

create 
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

--	next (a_celt: INTEGER): ARRAY [ICOR_DEBUG_STEPPER] is
--		require
--			celt_positive: a_celt > 0
--		local
--			l_p: POINTER
--			p_celt_fetched: INTEGER
--			mp_tab: MANAGED_POINTER
--			i: INTEGER
--			l_icor: ICOR_DEBUG_STEPPER
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
				C++ ICorDebugStepperEnum signature(ULONG,ICorDebugStepper**, ULONG*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Next"
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

end -- class ICOR_DEBUG_STEPPER_ENUM

