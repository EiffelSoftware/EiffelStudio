indexing

	description: 
		"Error that interrupts a compilation.";
	date: "$Date$";
	revision: "$Revision $"

class INTERRUPT_ERROR

inherit

	ERROR

feature -- Output

	code: STRING is "INTERRPT";
			-- Interrupt code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			st.add_string ("Interrupt was invoked");
			st.add_new_line
		end;

end -- class INTERRUPT_ERROR
