indexing

	description: 
		"Feature data denoting that it has been removed.";
	date: "$Date$";
	revision: "$Revision $"

class S_DELETED_FEATURE_DATA

inherit

	S_FEATURE_DATA_R331
		redefine
			is_deleted_since_last_re
		end

creation

	make

feature -- Properties

	is_deleted_since_last_re: BOOLEAN is True;
			-- Current feature is deleted since last re

end -- class S_DELETED_FEATURE_DATA
