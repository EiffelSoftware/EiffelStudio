indexing

	description: 
		"Error when an expanded class has a creation clause %
		%of several features or a feature with arguments.";
	date: "$Date$";
	revision: "$Revision $"

class VGCP4 

inherit

	VGCP21
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 4;

end -- class VGCP4
