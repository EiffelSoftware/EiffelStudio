-- Error when the compiler cannot find a final name for a selection

class VMSS1 
	
inherit

	VMSS2
		redefine
			subcode
		end
	
feature 

	subcode: INTEGER is 1;
			-- Error code

end 
