--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

class SIZE_MAN_O
	
feature {NONE}

	allow_recompute_size is
			-- Allow current button to recompute its  size according to
			-- some changes on its text.
		do
			recompute_size := TRUE;
		end;

	forbid_recompute_size is
			-- Forbid current button to recompute its size according to
			-- some changes on its text.
		do
			recompute_size := FALSE;
		end; 

	recompute_size: BOOLEAN;

end 
