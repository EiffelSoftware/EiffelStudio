indexing

	description: 
		"Error when a C++ external is redefined into a non-C++ function (external or %
		%internal) or the opposite."

	date: "$Date$";
	revision: "$Revision $"

class VDRD71

inherit

	VDRD5
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 71;

end -- class VDRD71
