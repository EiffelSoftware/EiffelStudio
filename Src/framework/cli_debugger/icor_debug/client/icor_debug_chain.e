indexing
	description: "[
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_CHAIN

inherit
	ICOR_OBJECT

	COR_DEBUG_CHAIN_REASON_ENUM
		undefine
			out
		end

create
	make_by_pointer

feature {ICOR_EXPORTER} -- Access

	get_thread: ICOR_DEBUG_THREAD is
			-- Debuggee Thread for `a_thread_id'
		local
			p: POINTER
		do
			last_call_success := cpp_get_thread (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_active_frame: ICOR_DEBUG_FRAME is
		local
			p: POINTER
		do
			last_call_success := cpp_get_active_frame (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_caller: ICOR_DEBUG_CHAIN is
		local
			p: POINTER
		do
			last_call_success := cpp_get_caller (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_callee: ICOR_DEBUG_CHAIN is
		local
			p: POINTER
		do
			last_call_success := cpp_get_callee (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_previous: ICOR_DEBUG_CHAIN is
		local
			p: POINTER
		do
			last_call_success := cpp_get_previous (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_next: ICOR_DEBUG_CHAIN is
		local
			p: POINTER
		do
			last_call_success := cpp_get_next (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	is_managed: BOOLEAN is
		local
			r: INTEGER
		do
			last_call_success := cpp_is_managed (item, $r)
			Result := r /= 0 --| TRUE = 1 , FALSE = 0
		ensure
			success: last_call_success = 0
		end

	enumerate_frames: ICOR_DEBUG_FRAME_ENUM is
		local
			p: POINTER
		do
			last_call_success := cpp_enumerate_frames (item, $p)
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			success: last_call_success = 0
		end

	get_reason: INTEGER is
			-- CHAIN_NONE              = 0x000,
			-- CHAIN_CLASS_INIT        = 0x001,
			-- CHAIN_EXCEPTION_FILTER  = 0x002,
			-- CHAIN_SECURITY          = 0x004,
			-- CHAIN_CONTEXT_POLICY    = 0x008,
			-- CHAIN_INTERCEPTION      = 0x010,
			-- CHAIN_PROCESS_START     = 0x020,
			-- CHAIN_THREAD_START      = 0x040,
			-- CHAIN_ENTER_MANAGED     = 0x080,
			-- CHAIN_ENTER_UNMANAGED   = 0x100,
			-- CHAIN_DEBUGGER_EVAL     = 0x200,
			-- CHAIN_CONTEXT_SWITCH    = 0x400,
			-- CHAIN_FUNC_EVAL         = 0x800,
		do
			last_call_success := cpp_get_reason (item, $Result)
		ensure
			success: last_call_success = 0
		end

	get_reason_to_string: STRING is
		do
			Result := enum_cor_debug_chain_reason_to_string (get_reason)
		end

feature {NONE} -- Implementation

	cpp_get_thread (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugChain signature(ICorDebugThread**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetThread"
		end

	cpp_get_active_frame (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugChain signature(ICorDebugFrame**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetActiveFrame"
		end

	cpp_get_caller (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugChain signature(ICorDebugChain**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCaller"
		end

	cpp_get_callee (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugChain signature(ICorDebugChain**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetCallee"
		end

	cpp_get_previous (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugChain signature(ICorDebugChain**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetPrevious"
		end

	cpp_get_next (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugChain signature(ICorDebugChain**): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetNext"
		end

	cpp_is_managed (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugChain signature(BOOL*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"IsManaged"
		end

	cpp_enumerate_frames (obj: POINTER; a_p: TYPED_POINTER [POINTER]): INTEGER is
		external
			"[
				C++ ICorDebugChain signature(ICorDebugFrameEnum **): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"EnumerateFrames"
		end

	cpp_get_reason (obj: POINTER; a_result: TYPED_POINTER [INTEGER]): INTEGER is
		external
			"[
				C++ ICorDebugChain signature(CorDebugChainReason*): EIF_INTEGER 
				use "cli_debugger_headers.h"
			]"
		alias
			"GetReason"
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

end -- class ICOR_DEBUG_CHAIN

