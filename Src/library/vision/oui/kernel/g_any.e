--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Parent of any oui graphic class.

indexing

	date: "$Date$";
	revision: "$Revision$"

class G_ANY

feature {NONE}

	init_toolkit: like toolkit is
			-- Init toolkit to desired implementation.
		do
		end; -- init_toolkit

	toolkit: TOOLKIT is
			-- Toolkit of implementation in the environment desired
		once
			Result := init_toolkit
		ensure
			not (Result = Void)
		end -- toolkit

end
