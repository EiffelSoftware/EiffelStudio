indexing

	description:
		"Constants used for exception handling.%
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EXCEP_CONST

feature -- Access

	Check_instruction: INTEGER is 7;
			-- Exception code for violated check

	Class_invariant: INTEGER is 6;
			-- Exception code for violated class invariant

	Incorrect_inspect_value: INTEGER is	9;
			-- Exception code for inspect value which is not one
			-- of the inspect constants, if there is no Else_part

	Loop_invariant: INTEGER is 11;
			-- Exception code for violated loop invariant

	Loop_variant: INTEGER is 10;
			-- Exception code for non-decreased loop variant

	No_more_memory: INTEGER is 2;
			-- Exception code for failed memory allocation

	Postcondition: INTEGER is 4;
			-- Exception code for violated postcondition

	Precondition: INTEGER is 3;
			-- Exception code for violated precondition

	Routine_failure: INTEGER is 8;
			-- Exception code for failed routine

	Void_assigned_to_expanded: INTEGER is 19;
			-- Exception code for assignment of void value
			-- to expanded entity

	Void_call_target: INTEGER is 1;
			-- Exception code for feature applied to void reference

	Rescue_exception: INTEGER is 14;
			-- Exception code for exception in rescue clause

	Floating_point_exception: INTEGER is 5;
			-- Exception code for floating point exception

	Signal_exception: INTEGER is 12;
			-- Exception code for operating system signal

	Io_exception: INTEGER is 21;
			-- Exception code for I/O error

	Retrieve_exception: INTEGER is 23;
			-- Exception code for retrieval error;
			-- may be raised by `retrieved' in `IO_MEDIUM'.

	Developer_exception: INTEGER is 24;
			-- Exception code for developer exception

	Operating_system_exception: INTEGER is 22;
			-- Exception code for operating system error
			-- which sets the `errno' variable
			-- (Unix-specific)

	External_exception: INTEGER is 18;
			-- Exception code for operating system error
			-- which does not set the `errno' variable
			-- (Unix-specific)

end -- class EXCEP_CONST

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------

