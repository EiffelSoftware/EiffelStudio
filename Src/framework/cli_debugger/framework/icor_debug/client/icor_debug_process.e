note
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_PROCESS

inherit
	ICOR_DEBUG_CONTROLLER
		export
			{ANY} item
		end

create
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	get_id: INTEGER
			-- Win32 Process ID of the process
		do
			last_call_success := cpp_get_id (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_handle: POINTER
			-- GetHandle returns a handle to the process
		do
			last_call_success := cpp_get_handle (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_thread (a_thread_id: INTEGER): ICOR_DEBUG_THREAD
			-- Debuggee Thread for `a_thread_id'
		local
			p: POINTER
		do
			last_call_success := cpp_get_thread (item, a_thread_id, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	enumerate_app_domains: ICOR_DEBUG_APP_DOMAIN_ENUM
		local
			p: POINTER
		do
			last_call_success := cpp_enumerate_app_domains (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_helper_thread_id: INTEGER
			-- Win32 Thread ID of the HelperThread
		do
			last_call_success := cpp_get_helper_thread_id (item, $Result)
		ensure
			success: last_call_success = 0
		end

feature {ICOR_EXPORTER} -- Get Handle

	frozen cpp_get_handle (obj: POINTER; a_p_handle: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(HPROCESS *): EIF_INTEGER
				use "cli_debugger_headers.h"
			]"
		alias
			"GetHandle"
		ensure
			is_class: class
		end

feature {NONE} -- Implementation

	cpp_get_id (obj: POINTER; a_p_id: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(DWORD*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetID"
		ensure
			is_class: class
		end

	cpp_get_thread (obj: POINTER; a_thread_id: INTEGER; a_p_thread: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(DWORD, ICorDebugThread**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetThread"
		ensure
			is_class: class
		end

	cpp_enumerate_app_domains (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(ICorDebugAppDomainEnum **): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateAppDomains"
		ensure
			is_class: class
		end

	cpp_get_helper_thread_id (obj: POINTER; a_p_id: TYPED_POINTER [INTEGER]): INTEGER
		external
			"[
				C++ ICorDebugProcess signature(DWORD*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetHelperThreadID"
		ensure
			is_class: class
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
