indexing

	description: 
		"Error when two local variables (or more) have the same name.";
	date: "$Date$";
	revision: "$Revision $"

class VRLE2 

inherit

	VRLE1
		redefine
			subcode
		end;
	
feature -- Property

	subcode: INTEGER is 2;

end -- class VRLE2
