-- Error for join rule when one argument type is not the same

class VDJR2 

inherit

	VDJR1
	
feature

	argument_number: INTEGER;
			-- Argument number

	set_argument_number (i: INTEGER) is
			-- Assign `i' to `argument_number'.
		do
			argument_number := i;
		end;

end
