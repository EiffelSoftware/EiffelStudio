note
	description: "[
		/*
		 * StepComplete is called when a step has completed.  The stepper
		 * may be used to continue stepping if desired (except for TERMINATE 
		 * reasons.)
		 *
		 * STEP_NORMAL means that stepping completed normally, in the same
		 *		function.
		 *
		 * STEP_RETURN means that stepping continued normally, after the function
		 *		returned.
		 *
		 * STEP_CALL means that stepping continued normally, at the start of 
		 *		a newly called function.
		 *
		 * STEP_EXCEPTION_FILTER means that control passed to an exception filter
		 *		after an exception was thrown.
		 * 
		 * STEP_EXCEPTION_HANDLER means that control passed to an exception handler
		 *		after an exception was thrown.
		 *
		 * STEP_INTERCEPT means that control passed to an interceptor.
		 * 
		 * STEP_EXIT means that the thread exited before the step completed.
		 *		No more stepping can be performed with the stepper.
		 */
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	COR_DEBUG_STEP_REASON_ENUM

feature -- enum CorDebugStepReason

	frozen enum_cor_debug_step_reason__STEP_NORMAL: INTEGER
			-- that stepping completed normally, in the same function.
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STEP_NORMAL"
		end

	frozen enum_cor_debug_step_reason__STEP_RETURN: INTEGER
			-- that stepping continued normally, after the function returned.
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STEP_RETURN"
		end

	frozen enum_cor_debug_step_reason__STEP_CALL: INTEGER
			-- that stepping continued normally, at the start of a newly called function.
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STEP_CALL"
		end

	frozen enum_cor_debug_step_reason__STEP_EXCEPTION_FILTER: INTEGER
			-- that control passed to an exception filter after an exception was thrown.
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STEP_EXCEPTION_FILTER"
		end

	frozen enum_cor_debug_step_reason__STEP_EXCEPTION_HANDLER: INTEGER
			-- that control passed to an exception handler after an exception was thrown.
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STEP_EXCEPTION_HANDLER"
		end

	frozen enum_cor_debug_step_reason__STEP_INTERCEPT: INTEGER
			-- that control passed to an interceptor.
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STEP_INTERCEPT"
		end

	frozen enum_cor_debug_step_reason__STEP_EXIT: INTEGER
			-- that the thread exited before the step completed.
			-- No more stepping can be performed with the stepper
		external
			"C++ macro use %"cli_debugger_headers.h%" "
		alias
			"STEP_EXIT"
		end

feature -- To String

	enum_cor_debug_step_reason_to_string (e: INTEGER): STRING
			-- String representation for the enum entry `e'
		do
			if e = enum_cor_debug_step_reason__STEP_NORMAL then
				Result := "STEP_NORMAL"
			elseif e = enum_cor_debug_step_reason__STEP_RETURN then
				Result := "STEP_RETURN"
			elseif e = enum_cor_debug_step_reason__STEP_CALL then
				Result := "STEP_CALL"
			elseif e = enum_cor_debug_step_reason__STEP_EXCEPTION_FILTER then
				Result := "STEP_EXCEPTION_FILTER"
			elseif e = enum_cor_debug_step_reason__STEP_EXCEPTION_HANDLER then
				Result := "STEP_EXCEPTION_HANDLER"
			elseif e = enum_cor_debug_step_reason__STEP_INTERCEPT then
				Result := "STEP_INTERCEPT"
			elseif e = enum_cor_debug_step_reason__STEP_EXIT then
				Result := "STEP_EXIT"
			else
				Result := "Unknown"
			end
		ensure
			Result_attached: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class EIFNET_STEP_REASON_CONSTANTS
