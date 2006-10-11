indexing
	description: "implementation for DEBUGGER_MANAGER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_MANAGER_IMP

create {DEBUGGER_MANAGER}
	default_create

feature {DEBUGGER_MANAGER} -- Access

	environment_variables_table: HASH_TABLE [STRING_32, STRING_32] is
		local
			p: POINTER
			ws: WEL_STRING
			k,v: STRING_32
			s: STRING_32
			i, c: INTEGER
			lst: LIST [STRING_32]
		do

			p := cwin_get_environment_strings
			if p /= Default_pointer then
				create ws.share_from_pointer (p)
				lst := ws.null_separated_strings
				from
					create Result.make (lst.count)
					lst.start
				until
					lst.after
				loop
					s := lst.item
					if s /= Void and then not s.is_empty then
						i := s.index_of ('=', 1)
						if i > 1 then
							k := s.substring (1, i - 1)
							if i < s.count then
								v := s.substring (i + 1, s.count)
								Result.force (v, k)
							end
						end
					end
					lst.forth
				end
				cwin_free_environment_strings (p)
			end
		end

feature {NONE} -- Externals

	cwin_get_environment_strings: POINTER is
			-- GetEnvironmentStrings
		external
			"[
				C signature(): EIF_POINTER
				use "windows.h"
			]"
		alias
			"GetEnvironmentStrings"
		end

	cwin_free_environment_strings (p: POINTER) is
			-- GetEnvironmentStrings
		external
			"[
				C signature(LPTCH)
				use "windows.h"
			]"
		alias
			"FreeEnvironmentStrings"
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

end
