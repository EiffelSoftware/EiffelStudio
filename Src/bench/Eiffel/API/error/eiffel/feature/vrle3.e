indexing
	description:
		"Error when an access to Result is invalid: invariant or procedure.";
	date: "$Date$";
	revision: "$Revision $"

class VRLE3

inherit
	FEATURE_ERROR
		redefine
			subcode
		end;

feature -- Property

	code: STRING is "VEEN"
			-- Error code

	subcode: INTEGER is 2

end
