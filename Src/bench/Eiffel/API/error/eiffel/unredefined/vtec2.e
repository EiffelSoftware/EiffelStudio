indexing

	description: 
		"Error for expanded that does not have `default_create' from ANY as %
		%creation procedure";
	date: "$Date$";
	revision: "$Revision $"

class VTEC2 

inherit

	VTEC1
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 2;

end -- class VTEC2
