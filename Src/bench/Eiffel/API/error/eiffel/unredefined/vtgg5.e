indexing

	description: 
		"Error for violation of the constrained genericity %
		%rule by a parent type.";
	date: "$Date$";
	revision: "$Revision $"

class VTGG5

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	actual_type: TYPE_A;

	c_type: TYPE_A;

	code: STRING is "VTCG";
			-- Error code

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		do
			ow.put_string ("In constraint genericity clause%NActual type: ");
			actual_type.append_to (ow);
			ow.put_string ("%NType to which it should conform: ");
			c_type.append_to (ow);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_actual_type (a_type: TYPE_A) is
		do
			actual_type := a_type;
		end;

	set_constraint_type (a_type: TYPE_A) is
		do
			c_type := a_type;
		end;

end -- class VTGG5
