-- Error when a feature name in an undefining clause is not a final name
-- of the associated parent

class VDUS1 

inherit

	VDRS1
		redefine
			code
		end
	
feature 

	code: STRING is "VDUS";
			-- Error code

end 
