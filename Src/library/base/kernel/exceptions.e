indexing

	description: "[
		Facilities for adapting the exception handling mechanism.
		This class may be used as ancestor by classes needing its facilities.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class EXCEPTIONS

inherit

	EXCEP_CONST

feature -- Status report

	meaning (except: INTEGER): STRING is
			-- A message in English describing what `except' is
		external
			"C | %"eif_except.h%""
		alias
			"eename"
		end

	assertion_violation: BOOLEAN is
			-- Is last exception originally due to a violated
			-- assertion or non-decreasing variant?
		do
			Result :=
				(original_exception = Check_instruction) or else
				(original_exception = Class_invariant) or else
				(original_exception = Loop_invariant) or else
				(original_exception = Loop_variant) or else
				(original_exception = Postcondition) or else
				(original_exception = Precondition)
		end

	is_developer_exception: BOOLEAN is
			-- Is the last exception originally due to
			-- a developer exception?
		do
			Result := (original_exception = Developer_exception)
		end

	is_developer_exception_of_name (name: STRING): BOOLEAN is
			-- Is the last exception originally due to a developer
			-- exception of name `name'?
		do
			Result := is_developer_exception and then
						equal (name, developer_exception_name)
		end

	developer_exception_name: STRING is
			-- Name of last developer-raised exception
		require
			applicable: is_developer_exception
		do
			Result := original_tag_name
		end

	is_signal: BOOLEAN is
			-- Is last exception originally due to an external
			-- event (operating system signal)?
		do
			Result := (original_exception = Signal_exception)
		end

	is_system_exception: BOOLEAN is
			-- Is last exception originally due to an
			-- external event (operating system error)?
		do
			Result :=
				(original_exception = External_exception) or else
				(original_exception = Operating_system_exception)
		end

	tag_name: STRING is
			-- Tag of last violated assertion clause
		external
			"C | %"eif_except.h%""
		alias
			"eeltag"
		end

	recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by last exception
		external
			"C | %"eif_except.h%""
		alias
			"eelrout"
		end

	class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		external
			"C | %"eif_except.h%""
		alias
			"eelclass"
		end

	exception: INTEGER is
			-- Code of last exception that occurred
		external
			"C | %"eif_except.h%""
		alias
			"eelcode"
		end

	exception_trace: STRING is
			-- String representation of the exception trace
		external
			"C | %"eif_except.h%""
		alias
			"stack_trace_string"
		end

	original_tag_name: STRING is
			-- Assertion tag for original form of last
			-- assertion violation.
		external
			"C | %"eif_except.h%""
		alias
			"eeotag"
		end

	original_exception: INTEGER is
			-- Original code of last exception that triggered
			-- current exception
		external
			"C | %"eif_except.h%""
		alias
			"eeocode"
		end

	original_recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by original form of last exception
		external
			"C | %"eif_except.h%""
		alias
			"eeorout"
		end

	original_class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		external
			"C | %"eif_except.h%""
		alias
			"eeoclass"
		end

feature -- Status setting

	catch (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- caught. This is the default.
		external
			"C | %"eif_except.h%""
		alias
			"eecatch"
		end

	ignore (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		external
			"C | %"eif_except.h%""
		alias
			"eeignore"
		end

	raise (name: STRING) is
			-- Raise a developer exception of name `name'.
		local
			str: ANY
		do
			if name /= Void then
				str := name.to_c
			end
			exclear
			eraise ($str, Developer_exception)
		end

	die (code: INTEGER) is
			-- Terminate execution with exit status `code',
			-- without triggering an exception.
		external
			"C | %"eif_except.h%""
		alias
			"esdie"
		end

	new_die (code: INTEGER) is obsolete "Use ``die''"
			-- Terminate execution with exit status `code',
			-- without triggering an exception.
		external
			"C | %"eif_except.h%""
		alias
			"esdie"
		end

	message_on_failure is
			-- Print an exception history table
			-- in case of failure.
			-- This is the default.
		do
			c_trace_exception (True)
		end

	no_message_on_failure is
			-- Do not print an exception history table
			-- in case of failure.
		do
			c_trace_exception (False)
		end

feature {NONE} -- Implementation

	exclear is
		external
			"C | %"eif_except.h%""
		end

	eraise (str: POINTER; code: INTEGER) is
			-- Raise an exception
		external
			"C | %"eif_except.h%""
		end

	c_trace_exception (b: BOOLEAN) is
		external
			"C | %"eif_except.h%""
		alias
			"eetrace"
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class EXCEPTIONS


