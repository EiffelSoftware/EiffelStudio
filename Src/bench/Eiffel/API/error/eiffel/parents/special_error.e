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

	error_case: INTEGER;
			-- Case of error

	make (case: INTEGER; id: INTEGER) is
		do
			error_case := case;
			class_id := id;
		end;

	code: STRING is "Special error";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation image for current error
            -- in `a_clickable'.
        do
			a_clickable.put_string ("%TSpecial error: case [");
			a_clickable.put_string (error_case.out);
			a_clickable.put_string ("]%N");
		end;

end
