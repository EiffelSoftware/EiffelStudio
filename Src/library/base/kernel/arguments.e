indexing

	description: "Access to command-line arguments.";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ARGUMENTS

feature -- Access 

	argument (i: INTEGER): STRING is
			-- Command line argument number `i'
			-- (the command name if `i' = 0)
		require
			0 <= i ; i < argument_count
		do
			Result := arg_option (i) 
		end;

feature -- Measurement

	argument_count: INTEGER is
			-- Number of arguments on the command line
			-- (including command name)
		once
			Result := arg_number
		end;

feature {NONE} -- Implementation

	arg_number: INTEGER is
		external
			"C"
		end;

	arg_option (i: INTEGER): STRING is
		external
			"C"
		end;

end -- class ARGUMENTS 


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
