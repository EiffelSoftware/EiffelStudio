indexing

	description: 
		"Error for calling a feature with the wrong number of arguments.";
	date: "$Date$";
	revision: "$Revision $"

class VUAR1 

inherit

	VUAR
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is 1;

	argument_count: INTEGER;

	called_local: STRING;

	called_arg: STRING;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if called_feature /= Void then
				print_called_feature (st);
				st.add_string ("%NNumber of actuals: ");
				st.add_int (argument_count);
				st.add_string (" Number of formals: ");
				st.add_int (called_feature.argument_count);
				st.add_new_line;
			elseif called_local /= Void then
				st.add_string ("Local variable name: ");
				st.add_string (called_local);
				st.add_new_line
			elseif called_arg /= Void then
				st.add_string ("Argument name: ");
				st.add_string (called_arg);
				st.add_new_line
			end;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_argument_count (i: INTEGER) is
		do
			argument_count := i
		end;

	set_local_name (s: STRING) is
		do
			called_local := s;
		end;

	set_arg_name (s: STRING) is
		do
			called_arg := s;
		end;

end -- class VUAR1
