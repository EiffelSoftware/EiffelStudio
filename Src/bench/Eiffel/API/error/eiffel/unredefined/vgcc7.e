-- The target of a creation instruction can only be an attribute, a local
-- variable of a Result

class VGCC7 obsolete "NOT IN THE BOOK"

inherit

	VGCC
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 7;

end
