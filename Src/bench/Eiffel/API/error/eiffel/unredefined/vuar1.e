-- Error for calling a feature with the wrong number of arguments

class VUAR1 

inherit

	VUAR
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is 1;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if called_feature /= Void then
				print_called_feature (ow);
				ow.put_string ("%NNumber of actuals: ");
				ow.put_int (argument_count);
				ow.put_string (" Number of formals: ");
				ow.put_int (called_feature.argument_count);
				ow.new_line;
			elseif called_local /= Void then
				ow.put_string ("Local variable name: ");
				ow.put_string (called_local);
				ow.new_line
			elseif called_arg /= Void then
				ow.put_string ("Argument name: ");
				ow.put_string (called_arg);
				ow.new_line
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
