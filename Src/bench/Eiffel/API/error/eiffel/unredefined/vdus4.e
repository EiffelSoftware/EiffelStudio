-- Error when there is twice or more a feature name in an undefining clause

class VDUS4 

inherit

	VDRS3
		redefine
			code
		end
	
feature 

	code: STRING is "VDUS";
			-- Error code

end 
