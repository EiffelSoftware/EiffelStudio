-- Error when the compiler cannot find a final name for a selection

class VMSS1 
	
inherit

	VDRS1
		redefine
			code
		end
	
feature 

	code: STRING is "VMSS";
			-- Error code

end 
