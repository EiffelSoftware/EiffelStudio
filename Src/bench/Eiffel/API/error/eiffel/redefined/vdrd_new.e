indexing

	description: "Error in feature redeclaration.";
	date: "$Date$";
	revision: "$Revision$"

deferred class VDRD_NEW

inherit
	FEATURE_CONFLICT_ERROR
		undefine
			subcode
		end

feature -- Access

	code: STRING is "ECMA-VDRD"
			-- Error code

end
