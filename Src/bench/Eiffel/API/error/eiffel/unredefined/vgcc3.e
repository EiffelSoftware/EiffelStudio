-- Error when the creation type of a creation instruction is an expanded
-- type, a none type or a simple type

class VGCC3 

inherit

	VGCC
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 3

end
