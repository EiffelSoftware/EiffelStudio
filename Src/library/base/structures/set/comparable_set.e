--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Sets whose elements may be compared

indexing

	names: comparable_set, comparable_struct;
	access: membership, min, max;
	contents: generic;
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARABLE_SET [G -> PART_COMPARABLE] inherit

	SET [G];

	COMPARABLE_STRUCT [G]
		rename
			min as cs_min,
			max as cs_max
		export
			{NONE}
				all
		end

feature -- Access

	min: G is
			-- Minimum in `Current'
		require
			not_empty: not empty
		do
			Result := cs_min
		ensure
		--	is_minimum:
				-- for all `elements in `Current': `Result <= element'
		end;

	max: G is
			-- Maximum in `Current'
		require
			not_empty: not empty
		do
			Result := cs_max
		ensure
		--	is_maximum:
				-- for all `elements in `Current': `element <= Result'
		end;

end
