-- Error when a creation feature doesn't satisfy the export validity

class VGCC8 

inherit

	VGCC5
		redefine
			subcode
		end;

feature
		subcode: INTEGER is 8

end
