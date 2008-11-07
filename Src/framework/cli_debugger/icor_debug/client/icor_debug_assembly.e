indexing
	description: "[
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_ASSEMBLY

inherit
	ICOR_OBJECT

create 
	make_by_pointer
	
feature {ICOR_EXPORTER} -- Access

	get_process: ICOR_DEBUG_PROCESS is
			-- Reference to the ICorDebugProcess
		local
			p: POINTER
		do
			last_call_success := cpp_get_process (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_app_domain: ICOR_DEBUG_APP_DOMAIN is
			-- Reference to the ICorDebugAppDomain
		local
			p: POINTER
		do
			last_call_success := cpp_get_app_domain (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	enumerate_modules: ICOR_DEBUG_MODULE_ENUM is
		local
			p: POINTER
		do
			last_call_success := cpp_enumerate_modules (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_name: STRING is
			-- GetName returns the name of the assembly
		local
			p_cchname: NATURAL_32
			mp_name: MANAGED_POINTER
		do
			create mp_name.make (256 * 2)
			
			last_call_success := cpp_get_name (item, 256, $p_cchname, mp_name.item)
			if mp_name.item /= default_pointer then
				Result := (create {UNI_STRING}.make_by_pointer (mp_name.item)).string
			end
		ensure
--			success: last_call_success = 0
		end

feature {ICOR_EXPORTER} -- Implementation

	frozen cpp_get_process (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugAssembly signature(ICorDebugProcess**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetProcess"
		end		

	frozen cpp_get_app_domain (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugAssembly signature(ICorDebugAppDomain**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetAppDomain"
		end		

	frozen cpp_enumerate_modules (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugAssembly signature(ICorDebugModuleEnum **): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateModules"
		end

	frozen cpp_get_name (obj: POINTER; a_cchname: NATURAL_32; a_pcchname: TYPED_POINTER [NATURAL_32]; a_szname: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAssembly signature(ULONG32, ULONG32 *, WCHAR*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetName"
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

end -- class ICOR_DEBUG_ASSEMBLY

