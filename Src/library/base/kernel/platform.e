--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- With 'GENERAL' as its single parent, introduces a few
-- constant attributes such as Integer_bits denoting
-- constant  values which depend on the local platform


indexing

	date: "$Date$";
	revision: "$Revision$"

class PLATFORM

inherit

	GENERAL

feature -- Access

	Character_bits: INTEGER is 8;

	Integer_bits: INTEGER is 32;

	Real_bits: INTEGER is 32;

	Double_bits: INTEGER is 64;

end -- class PLATFORM
