indexing

	description: 
		"Error for expanded that has more that more creation routines %
		%or creation routine has arguments";
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
