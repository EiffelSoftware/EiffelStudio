indexing

	description: 
		"Error for invalid assignment attempt for bits.";
	date: "$Date$";
	revision: "$Revision $"

class VNCB 

inherit

	VJAR
		redefine
			code
		end;
	
feature -- Property

	code: STRING is "VNCB";
			-- Error code

end -- class VNCB
