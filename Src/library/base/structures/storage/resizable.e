--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Resizable data structures; number of items may vary

indexing

	names: resizable, storage;
	size: resizable;
	date: "$Date$";
	revision: "$Revision$"

deferred class RESIZABLE inherit

	BOUNDED;

	BASIC_ROUTINES
		export
			{NONE} all
		end

feature -- Number of elements

	automatic_grow is
			-- Change the capacity of `Current' to
			-- accommodate at least `Growth_percentage' more items.
			--| Trade space for time:
			--| allocate large chunks of memory but not very often.
		do
			grow (capacity + capacity * Growth_percentage // 100 + 1)
		ensure
	--		capacity >= old capacity + old capacity * Growth_percentage // 100 + 1
		end;

	grow (i: INTEGER) is
			-- Change the capacity of `Current' to at least `i'.
		deferred
		ensure
			new_capacity: capacity >= i
		end;
	
	additional_space: INTEGER is
			-- Proposed number of additional elements
			--| Return a "reasonable" value:
			--| compromise between time and space
		do
			Result := max (capacity // Extra_percentage, Minimal_increase)
		end;

	Growth_percentage: INTEGER is 50;
			-- Percentage by which `Current' grows automatically

	Extra_percentage: INTEGER is 50;
			-- Growth percentage for proposition

	Minimal_increase: INTEGER is 5;
			-- Minimal number of additional elements

end -- class RESIZABLE

