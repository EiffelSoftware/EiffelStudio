-- Error when a name of a creation clause is not a final name of the
-- associated class

class VGCP2 

inherit

	VGCP3
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 2;

end
