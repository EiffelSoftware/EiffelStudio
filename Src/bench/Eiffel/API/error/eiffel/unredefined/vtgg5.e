-- Error for violation of the constrained genericity rule by a parent type

class VTGG5

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature 

	actual_type: TYPE_B;

	c_type: TYPE_B;

	set_actual_type (a_type: TYPE_B) is
		do
			actual_type := a_type;
		end;

	set_constraint_type (a_type: TYPE_B) is
		do
			c_type := a_type;
		end;

	build_explain is
			-- Build specific explanation explain for current error
			-- in `error_window'.
		do
			put_string ("In constraint genericity clause%NActual type: ");
			actual_type.append_clickable_signature (error_window);
			put_string ("%NType to which it should conform: ");
			c_type.append_clickable_signature (error_window);
			error_window.new_line;
		end;

	code: STRING is "VTCG";
			-- Error code

end
