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
			ip: POINTER
			psize: INTEGER
			cs: C_STRING
			s: STRING
			i: INTEGER
			k, v: STRING_32
		do
			p := c_environ
			if p /= Default_pointer then 
				psize := (create {PLATFORM}).pointer_bytes
				create Result.make (5)
				from
					ip := c_environ_next (p)
				until
					ip = Default_pointer
				loop
					create cs.make_by_pointer (ip)
					s := cs.string
					if s /= Void and then s.count > 1 then
						i := s.index_of ('=', 1)
						if i > 1 then
							k := s.substring (1, i - 1).as_string_32
							if i < s.count then
								v := s.substring (i + 1, s.count).as_string_32
								Result.force (v, k)
							end
						end
					end
					ip := c_environ_next (p)
				end
			end
		end

feature -- external

	c_environ: POINTER is
		external
			"C inline use <unistd.h>"
		alias
			"[
				#if defined(environ) 
					extern char** environ;
					return (EIF_POINTER) &environ;
				#else
					return (EIF_POINTER) NULL;
				#endif
			]"
		end

	c_environ_next (p: POINTER): POINTER is
		external
			"C inline use <unistd.h>"
		alias
			"[
				char*** env_p;
				char* res;
				env_p = (char***) $p;
				res = **env_p;
				*env_p = *env_p + 1;

				return (EIF_POINTER) res;
			]"
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
