-- Error when there is twice or more a feature name in a selection clause

class VMSS3

inherit

	VDRS3
		redefine
			code, subcode
		end
	
feature 

	code: STRING is "VMSS";
			-- Error code

	subcode: INTEGER is
		do
			Result := 2
		end;

end
