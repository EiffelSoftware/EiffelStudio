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

	build_explain is
            -- Build specific explanation image for current error
            -- in `error_window'.
        do
			put_string (error_case);
			new_line;
		end;

end
