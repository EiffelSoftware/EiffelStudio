--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

expanded class CHARACTER

inherit

	CHARACTER_REF
		redefine
			infix "<",
			code
		end

feature	-- Comparison

	infix "<" (other: CHARACTER): BOOLEAN is
			-- Is `other' greater than Current ?
		do
			-- Built-in
		end;

feature -- Code value

	code: INTEGER is
			-- Associated integer value
		do
			-- Built-in
		end;

end -- class CHARACTER
