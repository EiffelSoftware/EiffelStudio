-- Interval has values of bad type

class VOMB2 

inherit

	VOMB1
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 2;

end
