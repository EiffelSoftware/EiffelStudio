-- Error when an argument of a redeclaration is expanded (resp. not expanded)
-- and the precursor argument is not argument (resp. expanded).

class VE02A 

inherit

	VE02
	
feature

	argument_number: INTEGER;
			-- Argument number

	set_argument_number (i: INTEGER) is
			-- Assign `i' to `argument_number'.
		do
			argument_number := i;
		end;

end
