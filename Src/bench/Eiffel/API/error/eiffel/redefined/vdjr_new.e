indexing

	description: "Error describing a violation of join rule.";
	date: "$Date$";
	revision: "$Revision$"

deferred class VDJR_NEW

inherit
	FEATURE_CONFLICT_ERROR
		undefine
			subcode
		end

feature -- Access

	code: STRING is "ECMA-VDJR"
			-- Error code

end
