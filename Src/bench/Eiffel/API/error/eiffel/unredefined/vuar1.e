indexing

	description: 
		"Error for calling a feature with the wrong number of arguments.";
	date: "$Date$";
	revision: "$Revision $"

class VUAR1 

inherit

	VUAR
		redefine
			subcode, is_defined, build_explain
		end

feature -- Properties

	subcode: INTEGER is 1;

	argument_count: INTEGER;

	called_local: STRING;

	called_arg: STRING;

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then is_feature_defined and then
				(called_feature /= Void or else called_arg /= Void or else called_local /= Void)
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if called_feature /= Void then
				print_called_feature (st);
				st.add_new_line;
				st.add_string ("Number of actuals: ");
				st.add_int (argument_count);
				st.add_string (" Number of formals: ");
				st.add_int (called_feature.argument_count);
			elseif called_local /= Void then
				st.add_string ("Local variable name: ");
				st.add_string (called_local);
			elseif called_arg /= Void then
				st.add_string ("Argument name: ");
				st.add_string (called_arg);
			end;
			st.add_new_line
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
