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
			print_called_feature;
			put_string ("%NNumber of actuals: ");
			put_int (argument_count);
			put_string (" Number of formals: ");
			put_int (called_feature.argument_count);
			new_line;
		end;

	argument_count: INTEGER;

	set_argument_count (i: INTEGER) is
		do
			argument_count := i
		end;

end
