-- Error when a redeclaration has an expanded type and its precursor not, or
-- when a redeclaration has a not an expanded type but the precursor does
-- Note that expanded type doen't refer to the simple types...

class VE02 obsolete "NOT DEFINED IN THE BOOK"

inherit

	VDRD51
		redefine
			code, subcode
		end
	
feature 

	code: STRING is "VDRD";
			-- Error code: should be added to VDRD validity rule

	subcode: INTEGER is 8;

end 
