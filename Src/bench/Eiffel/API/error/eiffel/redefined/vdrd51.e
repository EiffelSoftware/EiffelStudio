indexing

	description: 
		"Error for non-conformance of Result types for redefinitions.";
	date: "$Date$";
	revision: "$Revision $"

class VDRD51 

inherit

	VDRD5
		redefine
			subcode
		end;
	
feature -- Properties

	subcode: INTEGER is 
			-- Error code
		do
			Result := 2;
		end;

end -- class VDRD51
