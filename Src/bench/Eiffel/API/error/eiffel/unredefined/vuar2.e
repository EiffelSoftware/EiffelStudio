indexing

	description: 
		"Error for a feature call: type mismatch one one argument.";
	date: "$Date$";
	revision: "$Revision $"

class VUAR2 

inherit

	VUAR
		redefine
			build_explain, subcode
		end

feature -- Properties

	subcode: INTEGER is 2;

	argument_name: STRING;
			-- Name of the involved argument

	argument_position: INTEGER;

	formal_type: TYPE_A;
			-- Formal type of the argument

	actual_type: TYPE_A;
			-- Actual type of the call

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			print_called_feature (ow);
			ow.put_string ("Argument name: ");
			ow.put_string (argument_name);
			ow.put_string ("%NArgument position: ");
			ow.put_int (argument_position);
			ow.put_string ("%NActual argument type: ");
			actual_type.append_to (ow);
			ow.put_string ("%NFormal argument type: ");
			formal_type.append_to (ow);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_argument_name (n: STRING) is
			-- Assign `n' to `argument_name'.
		do
			argument_name := n;
		end;

	set_argument_position (i: INTEGER) is
		do
			argument_position := i
		end;

	set_formal_type (t: TYPE_A) is
			-- Assign `t' to `formal_type'.
		do
			formal_type := t;
		end;

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a;
		end;

end -- class VUAR2
