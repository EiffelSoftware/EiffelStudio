note
	description: "[
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ICOR_DEBUG_APP_DOMAIN

inherit
	ICOR_DEBUG_I

feature {ICOR_EXPORTER} -- Access

	get_process: ICOR_DEBUG_PROCESS
			-- Reference to the ICorDebugProcess
		local
			p: POINTER
		do
			set_last_call_success (cpp_get_process (item, $p))
			if p /= default_pointer then
				Result := new_process (p)
			end
		ensure
			success: last_call_success = 0
		end

	enumerate_assemblies: ICOR_DEBUG_ASSEMBLY_ENUM
		local
			p: POINTER
		do
			set_last_call_success (cpp_enumerate_assemblies (item, $p))
			if p /= default_pointer then
				Result := new_assembly_enum (p)
			end
		ensure
			success: last_call_success = 0
		end

	enumerate_breakpoints: ICOR_DEBUG_BREAKPOINT_ENUM
		local
			p: POINTER
		do
			set_last_call_success (cpp_enumerate_breakpoints (item, $p))
			if p /= default_pointer then
				Result := new_breakpoint_enum (p)
			end
		ensure
			success: last_call_success = 0
		end

	enumerate_steppers: ICOR_DEBUG_STEPPER_ENUM
		local
			p: POINTER
		do
			set_last_call_success (cpp_enumerate_steppers (item, $p))
			if p /= default_pointer then
				Result := new_stepper_enum (p)
			end
		ensure
			success: last_call_success = 0
		end

	is_attached: BOOLEAN
			-- IsAttached returns whether or not the debugger is attached to the
			-- app domain
		local
			r: INTEGER
		do
			set_last_call_success (cpp_is_attached (item, $r))
			Result := r /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

	get_name: detachable STRING_32
			-- GetName returns the name of the app domain
		local
			p_cchname: NATURAL_32
			mp_name: MANAGED_POINTER
		do
			create mp_name.make (256 * 2)

			set_last_call_success (cpp_get_name (item, 256, $p_cchname, mp_name.item))
			if mp_name.item /= default_pointer then
				Result := (create {CLI_STRING}.make_by_pointer (mp_name.item)).string_32
			end
		ensure
--			success: last_call_success = 0
		end

	attach
			-- Attach() should be called to attach to the app domain to
			-- receive all app domain related events
		do
			set_last_call_success (cpp_attach (item))
		ensure
			success: last_call_success = 0
		end

	get_id: NATURAL_32
			-- Get the ID of this app domain
		do
			set_last_call_success (cpp_get_id (item, $Result))
		ensure
			success: last_call_success = 0
		end

feature {ICOR_EXPORTER} -- Implementation

	frozen cpp_get_process (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugAppDomain signature(ICorDebugProcess**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetProcess"
		ensure
			is_class: class
		end

	frozen cpp_attach (obj: POINTER): INTEGER
		external
			"[
				C++ ICorDebugAppDomain signature(): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"Attach"
		ensure
			is_class: class
		end

	frozen cpp_is_attached (obj: POINTER; a_pb_attached: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugAppDomain signature(BOOL*): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"IsAttached"
		ensure
			is_class: class
		end

feature {NONE} -- Implementation

	frozen cpp_enumerate_assemblies (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugAppDomain signature(ICorDebugAssemblyEnum **): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateAssemblies"
		ensure
			is_class: class
		end

	frozen cpp_enumerate_breakpoints (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugAppDomain signature(ICorDebugBreakpointEnum **): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateBreakpoints"
		ensure
			is_class: class
		end

	frozen cpp_enumerate_steppers (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugAppDomain signature(ICorDebugStepperEnum **): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateSteppers"
		ensure
			is_class: class
		end

	frozen cpp_get_name (obj: POINTER; a_cchname: NATURAL_32; a_pcchname: TYPED_POINTER [NATURAL_32]; a_szname: POINTER): INTEGER
		external
			"[
				C++ ICorDebugAppDomain signature(ULONG32, ULONG32 *, WCHAR*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetName"
		ensure
			is_class: class
		end

	frozen cpp_get_id (obj: POINTER; a_p_id: TYPED_POINTER [NATURAL_32]): INTEGER
		external
			"[
				C++ ICorDebugAppDomain signature(ULONG32*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetID"
		ensure
			is_class: class
		end

end
