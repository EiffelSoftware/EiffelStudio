indexing

	description: "[
		Constants used for exception handling.
		This class may be used as ancestor by classes needing its facilities.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EXCEP_CONST

feature -- Access

	Void_call_target: INTEGER is 1
			-- Exception code for feature applied to void reference

	No_more_memory: INTEGER is 2
			-- Exception code for failed memory allocation

	Precondition: INTEGER is 3
			-- Exception code for violated precondition

	Postcondition: INTEGER is 4
			-- Exception code for violated postcondition

	Floating_point_exception: INTEGER is 5
			-- Exception code for floating point exception

	Class_invariant: INTEGER is 6
			-- Exception code for violated class invariant

	Check_instruction: INTEGER is 7
			-- Exception code for violated check

	Routine_failure: INTEGER is 8
			-- Exception code for failed routine

	Incorrect_inspect_value: INTEGER is	9
			-- Exception code for inspect value which is not one
			-- of the inspect constants, if there is no Else_part

	Loop_variant: INTEGER is 10
			-- Exception code for non-decreased loop variant

	Loop_invariant: INTEGER is 11
			-- Exception code for violated loop invariant

	Signal_exception: INTEGER is 12
			-- Exception code for operating system signal

	Rescue_exception: INTEGER is 14
			-- Exception code for exception in rescue clause

	External_exception: INTEGER is 18
			-- Exception code for operating system error
			-- which does not set the `errno' variable
			-- (Unix-specific)

	Void_assigned_to_expanded: INTEGER is 19
			-- Exception code for assignment of void value
			-- to expanded entity

	Io_exception: INTEGER is 21
			-- Exception code for I/O error

	Operating_system_exception: INTEGER is 22
			-- Exception code for operating system error
			-- which sets the `errno' variable
			-- (Unix-specific)

	Retrieve_exception: INTEGER is 23
			-- Exception code for retrieval error
			-- may be raised by `retrieved' in `IO_MEDIUM'.

	Developer_exception: INTEGER is 24
			-- Exception code for developer exception

	Runtime_io_exception: INTEGER is 27
			-- Exception code for I/O error raised by runtime functions
			-- such as store/retrieve, file access...

	Com_exception: INTEGER is 28;
			-- Exception code for a COM error.

	number_of_codes: INTEGER is 28
			-- How many codes are there to represent exceptions?

	valid_code (c: INTEGER): BOOLEAN is
			-- Is `c' a valid code to represent some kind of exceptions?
		do
			Result := c >= 1 and c <= number_of_codes
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

end -- class EXCEP_CONST


