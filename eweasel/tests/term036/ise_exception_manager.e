note
	description: "[
		Exception manager
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_EXCEPTION_MANAGER

feature -- Access

	last_exception: EXCEPTION
			-- Last exception
		do
		end

feature -- Raise

	raise (a_exception: EXCEPTION)
			-- Raise `a_exception'.
			-- Raising `a_exception' by this routine makes `a_exception' accessable by `last_exception'
			-- in rescue clause. Hence causes removal of original `last_exception'.
			-- If the original `last_exception' needs to be reserved, `set_throwing_exception'
			-- on `a_exception' can be called.
		do
		end

feature -- Status setting

	ignore (a_exception: TYPE [EXCEPTION])
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		do
		end

	catch (a_exception: TYPE [EXCEPTION])
			-- Set type of `a_exception' `is_ignored'.
		do
		end

	set_is_ignored (a_exception: TYPE [EXCEPTION]; a_ignored: BOOLEAN)
			-- Set type of `a_exception' to be `a_ignored'.
		do
		end

feature -- Status report

	is_ignorable (a_exception: TYPE [EXCEPTION]): BOOLEAN
			-- If set, type of `a_exception' is ignorable.
		do
		end

	is_raisable (a_exception: TYPE [EXCEPTION]): BOOLEAN
			-- If set, type of `a_exception' is raisable.
		do
		end

	is_ignored (a_exception: TYPE [EXCEPTION]): BOOLEAN
			-- If set, type of `a_exception' is not raised.
		do
		end

	is_caught (a_exception: TYPE [EXCEPTION]): BOOLEAN
			-- If set, type of `a_exception' is raised.
		do
		end

feature {EXCEPTIONS} -- Compatibility support

	type_of_code (a_code: INTEGER): TYPE [EXCEPTION]
			-- Exception type of `a_code'
		do
		end

	exception_from_code (a_code: INTEGER): EXCEPTION
			-- Create exception object from `a_code'
		do
		end

feature {NONE} -- Access

	exception_data: TUPLE [code: INTEGER; signal_code: INTEGER; error_code: INTEGER; tag, recipient, eclass: STRING; rf_routine, rf_class: STRING; trace: STRING; line_number: INTEGER; is_invariant_entry: BOOLEAN]
			-- Exception data
			-- Used to store temporary exception information,
			-- which is used to create exception object later.
		do
		end

feature {NONE} -- Element change

	set_last_exception (a_last_exception: EXCEPTION)
			-- Set `last_exception' with `a_last_exception'.
		do
		end

	set_exception_data (code: INTEGER; new_obj: BOOLEAN; signal_code: INTEGER; error_code: INTEGER; tag, recipient, eclass: STRING;
						rf_routine, rf_class: STRING; trace: STRING; line_number: INTEGER; is_invariant_entry: BOOLEAN)
			-- Set exception data.
			-- When a stack overflow exception is caught, this is a critical session.
			-- Big memory allocation will fail.
		do
		end

feature {NONE} -- Implementation

	is_code_ignored (a_code: INTEGER): BOOLEAN
			-- Is exception of `a_code' ignored?
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

	developer_raise (a_code: INTEGER; a_meaning, a_message: POINTER)
			-- Raise an exception
		do
		end

end
