--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Information given by ArchiVision when a part of a window becomes
-- visible.
-- X event associated: `Expose'. Raised by `expose action' too.

indexing

	date: "$Date$";
	revision: "$Revision$"

class EXPOSE_DATA 

inherit

	CONTEXT_DATA
		rename
			make as context_data_make
		end

creation

	make

feature 

	clip: CLIP;
			-- Exposed region

	make (a_widget: WIDGET; a_clip: CLIP) is
			-- Create a context_data for `Expose' event.
		do
			widget := a_widget;
			clip := a_clip
		end

end
