-- Error when a deferred class has a creation clause

class VGCP1

inherit

	VGCP
		redefine
			subcode
		end;

feature 

	subcode: INTEGER is 1;

end 
