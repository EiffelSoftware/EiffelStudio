indexing

	description: 
		"Error when there is a positive value in an inspect instruction %
		%involving uniwue features.";
	date: "$Date$";
	revision: "$Revision $"

class VOMB5 

inherit

	VOMB
		redefine
			subcode, build_explain
		end

feature -- Properties

	subcode: INTEGER is 5;

	positive_value: INTEGER;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Non-Unique value: ");
			st.add_int (positive_value);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_positive_value (i: INTEGER) is
		do
			positive_value := i;
		end;

end -- class VOMB5
