--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Semantic information for constructs of the Polynomial language

class POLYNOM

feature {NONE}

	info: POLYNOM_INFO is
		once
			create Result.make
		end

end -- POLYNOM
