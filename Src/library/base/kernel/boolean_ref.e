--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class BOOLEAN_REF

inherit

	ANY
		redefine
			out
		end

feature	-- Characteristic

	item: BOOLEAN;
			-- Boolean value

	set_item (b: BOOLEAN) is
			-- Assign `b' to `item'.
		do
			item := b;
		end;

	out: STRING is
			-- Return a printable representation of `Current'.
		do
			Result := c_outb ($item)
		end;

feature -- Boolean

	infix "and" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean conjunction of `Current' and `other'
		require
			other_exists: other /= Void
		do
			!!Result;
			Result.set_item (item and other.item)
		end;

	infix "and then" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean semi-strict conjunction of `Current' and `other'
		require
			other_exists: other /= Void
		do
			!!Result;
			Result.set_item (item and then other.item)
		end;

	infix "implies" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean implication of `Current' and `other'
			-- (semi-strict)
		require
			other_exists: other /= Void
		do
			!!Result;
			Result.set_item (item implies other.item)
		end;

	prefix "not" : BOOLEAN_REF is
			-- Negation of `Current'
		do
			!!Result;
			Result.set_item (not item)
		end;

	infix "or" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean disjunction of `Current' and `other'
		require
			other_exists: other /= Void
		do
			!!Result;
			Result.set_item (item or other.item)
		end;

	infix "or else" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean semi-strict disjunction of `Current' and `other'
		require
			other_exists: other /= Void
		do
			!!Result;
			Result.set_item (item or else other.item)
		end;

	infix "xor" (other: BOOLEAN_REF): BOOLEAN_REF is
			-- Boolean exclusive or of `Current' and `other'
		require
			other_exists: other /= Void
		do
			!!Result;
			Result.set_item (item xor other.item)
		end;

feature {NONE}
			-- External

	c_outb (b: BOOLEAN): STRING is
			-- Return a prinatable representation of `Current'.
		external
			"C"
		end;

end -- class BOOLEAN_REF
