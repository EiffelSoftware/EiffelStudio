indexing

	description: 
		"Error for a feature call: type mismatch on one argument.";
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

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			print_called_feature (st);
			st.add_string ("Argument name: ");
			st.add_string (argument_name);
			st.add_new_line;
			st.add_string ("Argument position: ");
			st.add_int (argument_position);
			st.add_new_line;
			st.add_string ("Actual argument type: ");
			actual_type.append_to (st);
			st.add_new_line;
			st.add_string ("Formal argument type: ");
			formal_type.append_to (st);
			st.add_new_line;
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
