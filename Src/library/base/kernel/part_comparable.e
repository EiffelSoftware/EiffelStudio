--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Elements that may be compared for a partial order relation

indexing

	names: part_comparable, comparison;
	date: "$Date$";
	revision: "$Revision$"

deferred class PART_COMPARABLE

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `Current' less than `other'?
		deferred
		end;

	infix "<=" (other: like Current): BOOLEAN is
			-- Is `Current' less than or equal to `other'?
		do
			Result := (Current < other) or else equal (Current, other)
		end;

	infix ">" (other: like Current): BOOLEAN is
			-- Is `Current' greater than `other'?
		do
			Result := other < Current
		end;

	infix ">=" (other: like Current): BOOLEAN is
			-- Is `Current' greater than or equal to `other'?
		do
			Result := (other < Current) or else equal (Current, other)
		end;

end -- class PART_COMPARABLE
