--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Basic type with no exported feature.
-- Useful as arguments to be passed to external routines.


indexing

	date: "$Date$";
	revision: "$Revision$"

class POINTER_REF

inherit

	ANY
		redefine
			out
		end

feature -- Access

	item: POINTER;
			-- Pointer value

feature -- Ouput

	out: STRING is
			-- Return a printable representation of `Current'.
		do
			Result := c_outp ($item)
		end;

feature  {NONE} -- External, Ouput

	c_outp (p: POINTER): STRING is
			-- Return a printable representation of `Current'.
		external
			"C"
		end;

end -- class POINTER_REF
