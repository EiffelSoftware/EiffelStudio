-- Error when the creation type of an instruction is a formal
-- generic parameter

class VGCC1 

inherit

	VGCC
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 1

end
