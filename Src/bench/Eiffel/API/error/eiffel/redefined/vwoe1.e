-- Error when bad conformance on first argument of an infix function

class VWOE1 

inherit

	VWOE
		redefine
			build_explain
		end
	
feature

	formal_type: TYPE_A;
			-- Formal argument type

	actual_type: TYPE_A;
			-- Actual type of the argument in the call

	set_formal_type (t: TYPE_A) is
			-- Assign `t' to `formal_type'.
		do
			formal_type := t;
		end;

	set_actual_type (t: TYPE_A) is
			-- Assign `t' to `actual_type'
		do
			actual_type := t;
		end;

	build_explain is
            -- Build specific explanation explain for current error
            -- in `error_window'.
        do
			put_string ("Formal type: ");
			formal_type.append_clickable_signature (error_window);
			put_string ("%NActual type: ");
			actual_type.append_clickable_signature (error_window);
			new_line;
		end;

end
