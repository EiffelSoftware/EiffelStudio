--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Universal features. All classes inherit from ANY
-- which inherits from PLATFORM, itself an heir of GENERAL.

indexing

	date: "$Date$";
	revision: "$Revision$"

class ANY

inherit

	PLATFORM

end -- class ANY
