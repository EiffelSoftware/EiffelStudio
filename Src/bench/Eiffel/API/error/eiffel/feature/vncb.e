-- Error for invalid assignment attempt for bits

class VNCB 

inherit

	VJAR
		redefine
			code
		end;
	
feature 

	code: STRING is "VNCB";
			-- Error code

end
