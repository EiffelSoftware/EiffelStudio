indexing

	description: 
		"Error when a local entity is used in a precondition %
		%or a postcondition.";
	date: "$Date$";
	revision: "$Revision $"

class VEEN2B 

inherit

	VEEN
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 22;

end -- class VEEN2B
