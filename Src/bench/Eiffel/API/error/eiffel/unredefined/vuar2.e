-- Error for a feature call: type mismatch one one argument

class VUAR2 

inherit

	VUAR
		redefine
			build_explain, subcode
		end

feature 

	subcode: INTEGER is 2;

	argument_name: STRING;
			-- Name of the involved argument

	formal_type: TYPE_A;
			-- Formal type of the argument

	actual_type: TYPE_A;
			-- Actual type of the call

	set_argument_name (n: STRING) is
			-- Assign `n' to `argument_name'.
		do
			argument_name := n;
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

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			print_called_feature;
			put_string ("Argument name: `");
			put_string (argument_name);
			put_string ("'%NTarget: ");
			put_string (formal_type.dump);
			put_string ("%NSource: ");
			put_string (actual_type.dump);
			new_line;
		end;

end

