indexing

	description: 
		"Error when an attribute is redefined in something else %
		%that an attribute.";
	date: "$Date$";
	revision: "$Revision $"

class VDRD6 

inherit

	VDRD5
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 6;

end -- class VDRD6
