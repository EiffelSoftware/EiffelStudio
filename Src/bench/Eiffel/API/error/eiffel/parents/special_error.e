indexing

	description: 
		"Error for special classes.";
	date: "$Date$";
	revision: "$Revision $"

class SPECIAL_ERROR 

inherit

	EIFFEL_ERROR	
		redefine
			build_explain
		end;
	SPECIAL_CONST
		export
			{NONE} all
		undefine
			is_equal
		end

creation {CLASS_C}

	make

feature {NONE} -- Initialization

	make (case: STRING; c: CLASS_C) is
		require
			valid_c: c /= Void
		do
			error_case := case;
			class_c := c
		end;

feature -- Properties

	error_case: STRING;
			-- Case of error

	code: STRING is "Special_error";
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_string (error_case);
			st.add_new_line;
		end;

end -- class SPECIAL_ERROR
