indexing

	description: 
		"Error when an argument type of a redefinition violates %
		%the rule of signature conformance.";
	date: "$Date$";
	revision: "$Revision $"

class VDRD53 

inherit

	VDRD51
		redefine
			subcode
		end;

feature -- Properties

	subcode: INTEGER is 2;

end -- class VDRD53
