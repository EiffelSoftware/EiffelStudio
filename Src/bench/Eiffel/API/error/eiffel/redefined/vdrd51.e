-- Error for non-conformance of Result types for redefinitions

class VDRD51 

inherit

	VDRD5
		redefine
			subcode
		end;
	
feature 

	subcode: INTEGER is 
			-- Error code
		do
			Result := 2;
		end;

end
