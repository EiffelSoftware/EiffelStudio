-- Error for calling a feature with the wrong number of arguments

class VUAR1 

inherit

	VUAR
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is 1;

	build_explain is
		do
			if called_feature /= Void then
				print_called_feature;
				put_string ("%NNumber of actuals: ");
				put_int (argument_count);
				put_string (" Number of formals: ");
				put_int (called_feature.argument_count);
				new_line;
			elseif called_local /= Void then
				put_string ("Local variable name: ");
				put_string (called_local);
				new_line
			elseif called_arg /= Void then
				put_string ("Argument name: ");
				put_string (called_arg);
				new_line
			end;
		end;

	argument_count: INTEGER;

	set_argument_count (i: INTEGER) is
		do
			argument_count := i
		end;

	called_local: STRING;

	set_local_name (s: STRING) is
		do
			called_local := s;
		end;

	called_arg: STRING;

	set_arg_name (s: STRING) is
		do
			called_arg := s;
		end;

end
