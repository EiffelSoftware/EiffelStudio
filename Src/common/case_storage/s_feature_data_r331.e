indexing

	description: 
		"Updated version of S_FEATURE_DATA for versions 3.3.1 and up.";
	date: "$Date$";
	revision: "$Revision $"

class S_FEATURE_DATA_R331

inherit

	S_FEATURE_DATA
		redefine
			is_reversed_engineered, set_reversed_engineered
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
		ensure then
			is_reversed_engineered: is_reversed_engineered
		end

end -- class S_FEATURE_DATA_R331
