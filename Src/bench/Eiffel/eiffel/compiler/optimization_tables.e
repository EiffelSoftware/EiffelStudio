class OPTIMIZATION_TABLES

creation

	make

feature {NONE}

	minimum_size: INTEGER is 300;

	make is
		do
			!!feature_set.make;
			feature_set.compare_objects;
			!!set_argument.make (0, minimum_size);
		end;

feature -- ARRAY optimization

	feature_set: TWO_WAY_SORTED_SET [OPTIMIZE_UNIT];
			-- Set of the `optimize_units' of the features using loops
			-- (class id, body_index)

feature -- Inlining

	set_argument: ARRAY [BOOLEAN];


end
