indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred
class
	ICOR_DEBUG_ENUM_WITH_NEXT [G -> ICOR_OBJECT create make_by_pointer end]

inherit
	ICOR_DEBUG_ENUM

--create 
--	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	i_th (i: INTEGER): G is
			-- i_th item of the enum items.
		require
			valid_index: i > 0 and i <= get_count
		local
			arr: like next
		do
			reset
			skip (i - 1)
			arr := next (1)
			Result := arr.item (1)
		end

	next (a_celt: INTEGER): ARRAY [G] is
			-- Array of `a_celt' fetched items.
			-- index start at '1'
		require
			celt_positive: a_celt > 0
		local
			l_p: POINTER
			p_celt_fetched: INTEGER
			mp_tab: MANAGED_POINTER
			i: INTEGER
			l_icor: G
			retried: BOOLEAN
			l_pointer_size: INTEGER
		do
			l_pointer_size := (create {PLATFORM}).Pointer_bytes

			if not retried then
				create mp_tab.make (a_celt * l_pointer_size)
				last_call_success := call_cpp_next (item, a_celt, mp_tab.item, $p_celt_fetched)
				if p_celt_fetched > 0 then
					from
						i := 1
						create Result.make (1, p_celt_fetched)
					until
						i > p_celt_fetched
					loop
						l_p := mp_tab.read_pointer((i - 1) * l_pointer_size)
						l_icor := icor_object_made_by_pointer (l_p)
						Result.put (l_icor, i)
						i := i + 1
					end
				end
			end
		rescue
			debug ("debugger_icor_data")
				io.error.put_string ("Error in IcorDebugXyzEnum->Next() %N")
			end
			Result := Void
			retried := True
			retry
		end

feature {NONE} -- Implementation

	icor_object_made_by_pointer (a_p: POINTER): G is
			-- 
		do
			create Result.make_by_pointer (a_p)
		end
		
	call_cpp_next (obj: POINTER; a_celt: INTEGER; a_p: POINTER; a_pceltfetched: POINTER): INTEGER is
		deferred
		end

--		external
--			"[
--				C++ ICorDebugAppDomainEnum signature(ULONG,ICorDebugAppDomain**, ULONG*): EIF_INTEGER 
--				use "cli_headers.h"
--			]"
--		alias
--			"Next"
--		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class ICOR_DEBUG_APP_DOMAIN_ENUM

