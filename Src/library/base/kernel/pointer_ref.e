--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

class POINTER_REF

inherit

	ANY
		redefine
			out
		end

feature

	item: POINTER;
			-- Pointer value

	out: STRING is
			-- Return a printable representation of `Current'.
		do
			Result := c_outp ($item)
		end;

feature {NONE}
			-- External

	c_outp (p: POINTER): STRING is
			-- Return a printable representation of `Current'.
		external
			"C"
		end;

end -- class POINTER_REF
