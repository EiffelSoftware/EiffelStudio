indexing

	description: 
		"Error for invalid equality.";
	date: "$Date$";
	revision: "$Revision $"

class VWEQ 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature -- Properties

	left_type: TYPE_A;
			-- Left type of the equality

	right_type: TYPE_A;
			-- Right type of the equality

	code: STRING is "VWEQ";
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_string ("Left-hand type: ");
			left_type.append_to (st);
			st.add_new_line;
			st.add_string ("Right-hand type: ");
			right_type.append_to (st);
			st.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_right_type (t: TYPE_A) is
		do
			right_type := t;
		end;

	set_left_type (t: TYPE_A) is
		do
			left_type := t;
		end;

end -- class VWEQ
