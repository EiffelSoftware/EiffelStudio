indexing

	description: 
		"Error when undefinition of a deferred feature.";
	date: "$Date$";
	revision: "$Revision $"

class VDUS3 

inherit

	VDUS2
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 3;

end -- class VDUS3
