-- Error when a specified type of a creation instruction doesn't
-- conform to the type of the target to create

class VGCC31 

inherit

	VGCC
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 32;

end
