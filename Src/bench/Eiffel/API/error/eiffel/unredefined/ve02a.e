indexing

	description: 
		"Error when an argument of a redeclaration is expanded %
		%(resp. not expanded) and the precursor argument is %
		%not argument (resp. expanded).";
	date: "$Date$";
	revision: "$Revision $"

class VE02A obsolete "NOT DEFINED IN THE BOOK"

inherit

	VE02
	
feature -- Properties

	argument_number: INTEGER;
			-- Argument number

feature {COMPILER_EXPORTER} -- Setting

	set_argument_number (i: INTEGER) is
			-- Assign `i' to `argument_number'.
		do
			argument_number := i;
		end;

end -- class VE02A
