-- Error for special classes

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

creation

	make

feature

	error_case: STRING;
			-- Case of error

	make (case: STRING; c: CLASS_C) is
		do
			error_case := case;
			class_c := c;
		end;

	code: STRING is "Special_error";
			-- Error code

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string (error_case);
			ow.new_line;
		end;

end
