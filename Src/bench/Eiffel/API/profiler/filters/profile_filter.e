indexing

	description:
		"Abstract notion of a profile filter.";
	date: "$Date$";
	revision: "$Revision$"

deferred class PROFILE_FILTER

feature -- Checking

	check_item (item: PROFILE_DATA): BOOLEAN is
			-- Check if `item' matches values
		require
			no_ghosts: item /= Void
		deferred
		end

	filter (input_set: PROFILE_SET): PROFILE_SET is
			-- Filter all input
		require
			filtering_is_allowed: filtering_is_allowed
			no_ghosty_input: input_set /= Void
		deferred
		end

	filtering_is_allowed: BOOLEAN is
			-- May `filter' be called?
		deferred
		end

feature -- Adding

	extend (new_filter: PROFILE_FILTER) is
		deferred
		end

feature -- Value setting

	set_operator (new_operator: STRING) is
		require
			no_ghost_operator: new_operator /= Void
		deferred
		end

	set_value (new_value: COMPARABLE) is
		deferred
		end

	set_value_range (lower, upper: COMPARABLE) is
		require
			valid_interval: lower < upper;
		deferred
		end

end -- class PROFILE_FILTER
