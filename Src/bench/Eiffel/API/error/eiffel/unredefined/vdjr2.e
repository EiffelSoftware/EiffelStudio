indexing

	description: 
		"Error for join rule when one argument type is not the same.";
	date: "$Date$";
	revision: "$Revision $"

class VDJR2 

inherit

	VDJR1
		redefine
			build_explain
		end;

feature -- Properties

	argument_number: INTEGER;
			-- Argument number

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Argument number: ");
			st.add_int (argument_number);
			st.add_new_line;
			print_types (st);
			print_signatures (st);
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_argument_number (i: INTEGER) is
			-- Assign `i' to `argument_number'.
		do
			argument_number := i;
		end;

end -- class VDJR2
