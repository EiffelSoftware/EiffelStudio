indexing

	description: 
		"rror for frozen and deferred feature.";
	date: "$Date$";
	revision: "$Revision $"

class VFFD4 

inherit

	VFFD
		redefine
			subcode
		end;
	
feature -- Properties

	subcode: INTEGER is 4;

end -- class VFFD4
