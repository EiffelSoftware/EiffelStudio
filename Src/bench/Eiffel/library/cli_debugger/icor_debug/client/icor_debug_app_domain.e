indexing
	description: "[
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_APP_DOMAIN

inherit
	ICOR_DEBUG_CONTROLLER

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

	enumerate_assemblies: ICOR_DEBUG_ASSEMBLY_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_assemblies (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

	enumerate_breakpoints: ICOR_DEBUG_BREAKPOINT_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_breakpoints (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

	enumerate_steppers: ICOR_DEBUG_STEPPER_ENUM is
		local
			l_p: POINTER
		do
			last_call_success := cpp_enumerate_steppers (item, $l_p)
			if l_p /= default_pointer then
				create Result.make_by_pointer (l_p)
			end
		ensure
			success: last_call_success = 0
		end

	is_attached: BOOLEAN is
			-- IsAttached returns whether or not the debugger is attached to the 
			-- app domain
		local
			l_result: INTEGER
		do
			last_call_success := cpp_is_attached (item, $l_result)
			Result := l_result /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

	get_name: STRING is
			-- GetName returns the name of the app domain
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

	attach is
			-- Attach() should be called to attach to the app domain to 
			-- receive all app domain related events
		do
			last_call_success := cpp_attach (item)
		ensure
			success: last_call_success = 0
		end

	get_id: INTEGER is
			-- Get the ID of this app domain
		do
			last_call_success := cpp_get_id (item, $Result)
		ensure
			success: last_call_success = 0
		end

feature {EIFNET_DEBUGGER} -- Implementation

	frozen cpp_get_process (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAppDomain signature(ICorDebugProcess**): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetProcess"
		end

	frozen cpp_attach (obj: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAppDomain signature(): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"Attach"
		end

feature {NONE} -- Implementation

	frozen cpp_enumerate_assemblies (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAppDomain signature(ICorDebugAssemblyEnum **): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumerateAssemblies"
		end

	frozen cpp_enumerate_breakpoints (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAppDomain signature(ICorDebugBreakpointEnum **): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumerateBreakpoints"
		end

	frozen cpp_enumerate_steppers (obj: POINTER; a_p: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAppDomain signature(ICorDebugStepperEnum **): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"EnumerateSteppers"
		end

	frozen cpp_is_attached (obj: POINTER; a_pb_attached: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAppDomain signature(BOOL*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"IsAttached"
		end		

	frozen cpp_get_name (obj: POINTER; a_cchname: INTEGER; a_pcchname: POINTER; a_szname: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAppDomain signature(ULONG32, ULONG32 *, WCHAR*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetName"
		end		

	frozen cpp_get_id (obj: POINTER; a_p_id: POINTER): INTEGER is
		external
			"[
				C++ ICorDebugAppDomain signature(ULONG32*): EIF_INTEGER 
				use "cli_headers.h"
			]"
		alias
			"GetID"
		end

end -- class ICOR_DEBUG_APP_DOMAIN

