indexing

	description: 
		"Keyword all in export clause is repeated more than once.";
	date: "$Date$";
	revision: "$Revision $"

class VLEL1 

inherit

	VLEL
		redefine
			subcode, build_explain
		end;

feature -- Properties

	subcode: INTEGER is 1;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			print_parent (ow);
		end;

end -- class VLEL1
