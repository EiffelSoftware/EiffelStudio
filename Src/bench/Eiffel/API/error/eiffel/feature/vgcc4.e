-- Error when there a is a creation call when there are feature in the
-- creation clause in the class of the instance to create

class VGCC4

inherit

	VGCC
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 4;

end
