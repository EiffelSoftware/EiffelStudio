--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Generator of a widget manager.

indexing

	date: "$Date$";
	revision: "$Revision$"

class W_MAN_GEN

feature {NONE}

	widget_manager: W_MANAGER is
			-- EiffelVision widget manager 
		once
			!! Result.make
		ensure
			Valid_result: Result /= Void
		end

end
