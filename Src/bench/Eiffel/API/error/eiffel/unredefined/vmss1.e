indexing

	description: 
		"Error when the compiler cannot find a final name for a selection.";
	date: "$Date$";
	revision: "$Revision $"

class VMSS1 
	
inherit

	VMSS2
		redefine
			subcode
		end
	
feature -- Properties

	subcode: INTEGER is 1;
			-- Error code

end -- class VMSS1
