-- Error when a redeclaration has an expanded type and its precursor not, or
-- when a redeclaration has a not an expanded type but the precursor does
-- Note that expanded type doen't refer to the simple types...

class VE02 

inherit

	VDRD51
		redefine
			code
		end
	
feature 

	code: STRING is "VE02";
			-- Error code: should be added to VDRD validity rule

end 
