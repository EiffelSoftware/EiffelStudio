-- Error when there is twice or more a feature name in a selection clause

class VMSS3 

inherit

	VDRS3
		redefine
			code
		end
	
feature 

	code: STRING is "VMSS";
			-- Error code

end
