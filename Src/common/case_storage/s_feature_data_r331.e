class S_FEATURE_DATA_R331

inherit

	S_FEATURE_DATA
		redefine
			is_reversed_engineered, set_reversed_engineered
		end

creation

	make

feature

	is_reversed_engineered: BOOLEAN
			-- Is Current class reversed engineered?

	set_reversed_engineered is
			-- Set `is_reversed_engineered' to True.
		do
			is_reversed_engineered := True
		end

end
