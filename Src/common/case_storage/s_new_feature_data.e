indexing

	description: 
		"Class data for new features created under eiffelcase.";
	date: "$Date$";
	revision: "$Revision $"

class S_NEW_FEATURE_DATA

inherit

	S_FEATURE_DATA_R331
		redefine
			is_new_since_last_re
		end

creation

	make

feature -- Properties

	is_new_since_last_re: BOOLEAN is True;
			-- Current feature is new since last re

end -- class S_NEW_FEATURE_DATA
