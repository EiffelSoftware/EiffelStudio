indexing
	description: "Target of a creation instruction can only be an attribute, a local or Result.";
	date: "$Date$";
	revision: "$Revision$"

class VGCC7

inherit
	VGCC
		redefine
			subcode
		end

feature -- Properties

	subcode: INTEGER is 7

end -- class VGCC7
