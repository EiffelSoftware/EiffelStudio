--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Elements that may be compared for a total order relation

indexing

	names: comparable, comparison;
	date: "$Date$";
	revision: "$Revision$"

deferred class COMPARABLE inherit

	PART_COMPARABLE
		redefine
			infix "<", infix "<=",
			infix ">", infix ">="
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is `Current' less than `other'?
		deferred
--		ensure then
--			Result implies not (Current >= other)
		end;

	infix "<=" (other: like Current): BOOLEAN is
			-- Is `Current' less than or equal to `other'?
		do
			Result := not (other < Current)
		ensure then
			Result implies not (Current > other)
		end;

	infix ">" (other: like Current): BOOLEAN is
			-- Is `Current' greater than `other'?
		do
			Result := other < Current
		ensure then
			Result implies not (Current <= other)
		end;

	infix ">=" (other: like Current): BOOLEAN is
			-- Is `Current' greater than or equal to `other'?
		do
			Result := not (Current < other)
		ensure then
			Result implies not (Current < other)
		end;

end
