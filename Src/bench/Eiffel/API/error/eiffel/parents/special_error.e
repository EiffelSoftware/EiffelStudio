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
		end

creation {CLASS_C}

	make

feature {NONE} -- Initialization

	make (case: STRING; c: CLASS_C) is
		require
			valid_c: c /= Void
		do
			error_case := case;
			e_class := c.e_class;
		end;

feature -- Properties

	error_case: STRING;
			-- Case of error

	code: STRING is "Special_error";
			-- Error code

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string (error_case);
			ow.new_line;
		end;

end -- class SPECIAL_ERROR
