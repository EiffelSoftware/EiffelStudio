indexing

	description: 
		"Error when an old expression is not an expression: i.e procedure.";
	date: "$Date$";
	revision: "$Revision $"

class VAOL2 

inherit

	VAOL1
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 2;

end -- class VAOL2
