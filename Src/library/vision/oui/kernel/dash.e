--|---------------------------------------------------------------
--|	Copyright (C) Interactive Software Engineering, Inc.        --
--|	 270 Storke Road, Suite 7 Goleta, California 93117          --
--|						 (805) 685-1006                         --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- DASH: Description of a dash pattern.

indexing

	date: "$Date$";
	revision: "$Revision$"

class DASH 

inherit

	LINKED_LIST [INTEGER]

creation

	make

feature {NONE}

	max_offset: INTEGER is
			-- Sum of integers in the list
			-- `offset' must be less than `max_offset'
		do
			mark;
			from
				start
			until
				off
			loop
				Result := Result+item;
				forth
			end;
			return
		end;

feature 

	offset: INTEGER;
			-- How many pixels into the patterns the line should actually begin

	set_offset (new_offset: INTEGER) is
			-- Set `offset' to `new_offset'.
		require
			offset_large_enough: offset >= 0;
			offset_small_enough: (not empty) implies (offset < max_offset)
		do
			offset := new_offset
		ensure
			offset = new_offset
		end

invariant

	offset >= 0;
	(not empty) implies (offset <= max_offset)

end
