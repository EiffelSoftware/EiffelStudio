--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class TO_SPECIAL [T]

creation

	make_area

feature

	area: SPECIAL [T];
			-- Special data zone

feature {NONE}

	make_area (n: INTEGER) is
			-- Creates a special object for `n' entries.
		require
			positive_argument: n >= 0;
		do
			-- Built-in
		ensure
			area_allocated: area /= Void and then area.count = n
		end;

	set_area (other: like area) is
			-- Assign `other' to `area'
		do
			area := other
		end;

end
