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

	build_explain (st: STRUCTURED_TEXT) is
		do
			print_parent (st);
		end;

end -- class VLEL1
