indexing

	description: 
		"Error when a result entity in used in a precondition.";
	date: "$Date$";
	revision: "$Revision $"

class VEEN2A 

inherit

	VEEN
		redefine
			build_explain, subcode
		end;

feature

	subcode: INTEGER is 21;

	build_explain (st: STRUCTURED_TEXT) is
		do
		end;

end -- class VEEN2A
