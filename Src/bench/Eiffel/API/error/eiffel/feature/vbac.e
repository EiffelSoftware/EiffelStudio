indexing

	description: "Error for invalid assigner call.";
	date: "$Date$";
	revision: "$Revision$"

deferred class VBAC

inherit
	FEATURE_ERROR
		undefine
			subcode
		end
	
feature -- Properties

	code: STRING is "VBAC"
			-- Error code

end
