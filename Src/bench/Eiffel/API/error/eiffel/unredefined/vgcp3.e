-- Error when a feature name is more than once in a creation clause

class VGCP3 

inherit

	VGCP21
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 3;

end
