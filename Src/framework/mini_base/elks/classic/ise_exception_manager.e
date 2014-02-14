note
	description: "[
		Exception manager. 
		The manager handles all common operations of exception mechanism and interaction with the ISE runtime.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_EXCEPTION_MANAGER

feature -- Access

	last_exception: detachable EXCEPTION
			-- Last exception
		do
		end

feature -- Settings

	set_last_exception (a_last_exception: detachable EXCEPTION)
			-- Set `last_exception' with `a_last_exception'.
		do
		end

feature {NONE} -- Implementation

	once_raise (a_exception: EXCEPTION)
			-- Called by runtime to raise saved exception for once routines.
		do
		end

	frozen init_exception_manager
			-- Call once routines to create objects beforehand,
			-- in case it goes into critical session (Stack overflow, no memory etc.)
			-- The creations doesn't fail.
		do
		end

	frozen free_preallocated_trace
		do
		end

	is_code_ignored (a_code: INTEGER): BOOLEAN
			-- Is exception of `a_code' ignored?
		do
		end

	set_exception_data (code: INTEGER; new_obj: BOOLEAN; signal_code: INTEGER; error_code: INTEGER; tag, recipient, eclass: STRING;
						rf_routine, rf_class: STRING; trace: STRING; line_number: INTEGER; is_invariant_entry: BOOLEAN)
			-- Set exception data.
		do
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
