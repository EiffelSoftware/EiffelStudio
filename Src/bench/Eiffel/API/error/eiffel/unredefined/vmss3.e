indexing

	description: 
		"Error when there is twice or more a feature name in a selection clause %
		%The error code is in fact VMSS2 !!!!";
	date: "$Date$";
	revision: "$Revision $"

class VMSS3

inherit

	VDRS3
		redefine
			code, subcode
		end
	
feature -- Properties

	code: STRING is "VMSS";
			-- Error code

	subcode: INTEGER is
		do
			Result := 2
		end;

end -- class VMSS3
