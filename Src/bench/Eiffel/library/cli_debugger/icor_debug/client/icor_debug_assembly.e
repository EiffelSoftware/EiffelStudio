indexing
	description: "[
		]"
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
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_modules (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

	get_name: STRING is
			-- GetName returns the name of the assembly
		local
			p_cchname: INTEGER
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

	frozen cpp_get_process (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAssembly signature(ICorDebugProcess**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetProcess"
		end		

	frozen cpp_get_app_domain (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAssembly signature(ICorDebugAppDomain**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetAppDomain"
		end		

	frozen cpp_enumerate_modules (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAssembly signature(ICorDebugModuleEnum **): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumerateModules"
		end

	frozen cpp_get_name (obj: POINTER; a_cchname: INTEGER; a_pcchname: POINTER; a_szname: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAssembly signature(ULONG32, ULONG32 *, WCHAR*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetName"
		end		

		
end -- class ICOR_DEBUG_ASSEMBLY

