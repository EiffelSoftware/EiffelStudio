indexing

	description: 
		"Updated version of S_FEATURE_DATA for versions 3.3.1 and up. %
		%In fact, everything has been put in R40; this R331 exists %
		%only for compatibility and will be removed, as well as %
		%S_NEW_FEATURE_DATA and S_DELETED_FEATURE_DATA";
	date: "$Date$";
	revision: "$Revision $"

class S_FEATURE_DATA_R331

inherit

	S_FEATURE_DATA
		redefine
			is_reversed_engineered,set_reversed_engineered
		end

creation
	make

feature -- Properties

	is_reversed_engineered: BOOLEAN
			-- Is Current class reversed engineered?

feature -- Setting

	set_reversed_engineered is
			-- Set `is_reversed_engineered' to True.
		do
			is_reversed_engineered := True
		end

end -- class S_FEATURE_DATA_R331
