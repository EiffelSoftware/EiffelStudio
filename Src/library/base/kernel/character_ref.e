--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class CHARACTER_REF

inherit

	COMPARABLE
		redefine
			out
		end

feature

	item: CHARACTER;
			-- Character value

	out: STRING is
			-- Return a printable representation of `Current'.
		do
			Result := c_outc ($item)
		end;

feature -- Comparison

	infix "<" (other: CHARACTER_REF): BOOLEAN is
			-- Is `Current' less than `other'?
		require else
			other_exists: other /= Void
		do
			Result := item < other.item;
		end;

feature -- Code value

	code: INTEGER is
			-- Associated integer value
		do
			Result := chcode ($item)
		end;

feature {NONE}
			-- External

	c_outc (c: CHARACTER): STRING is
			-- Return a printable representation of `Current'.
		external
			"C"
		end;

	chcode (c: like item): INTEGER is
			-- Return associated integer value.
		external
			"C"
		end;

end -- class CHARACTER_REF
