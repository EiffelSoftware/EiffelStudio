-- Error for join rule when one argument type is not the same

class VDJR2 

inherit

	VDJR1
		redefine
			build_explain
		end;

feature

	argument_number: INTEGER;
			-- Argument number

	set_argument_number (i: INTEGER) is
			-- Assign `i' to `argument_number'.
		do
			argument_number := i;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Argument number: ");
			ow.put_int (argument_number);
			ow.new_line;
			print_types (ow);
			print_signatures (ow);
		end;

end
