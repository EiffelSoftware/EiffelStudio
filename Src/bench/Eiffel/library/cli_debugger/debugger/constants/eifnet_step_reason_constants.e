indexing
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
	EIFNET_STEP_REASON_CONSTANTS

feature {NONE} -- Initialization

	Step_normal: INTEGER is 0
			-- that stepping completed normally, in the same function.

	Step_return: INTEGER is 1
			-- that stepping continued normally, after the function returned.

	Step_call: INTEGER is 2
			-- that stepping continued normally, at the start of a newly called function.

	Step_exception_filter: INTEGER is 3
			-- that control passed to an exception filter after an exception was thrown.

	Step_exception_handler: INTEGER is 4
			-- that control passed to an exception handler after an exception was thrown.

	Step_intercept: INTEGER is 5
			-- that control passed to an interceptor.  

	Step_exit: INTEGER is 6
			-- that the thread exited before the step completed. 
			-- No more stepping can be performed with the stepper

feature -- To String

	step_id_to_string (step_id: INTEGER): STRING is
			-- 
		do
			inspect step_id
			when  Step_normal then
				Result := "normal"
			when  Step_return then
				Result := "return"
			when  Step_call then
				Result := "call"
			when  Step_exception_filter then
				Result := "exception_filter"
			when  Step_exception_handler then
				Result := "exception_handler"
			when  Step_intercept then
				Result := "intercept"
			when  Step_exit then
				Result := "exit"				
			else
				Result := "Unknown"				
			end
		end
		
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

end -- class EIFNET_STEP_REASON_CONSTANTS
