-- Error for expanded that has more that more creation routines
-- or creation routine has arguments.

class VTEC2 

inherit

	VTEC1
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 2;

end
