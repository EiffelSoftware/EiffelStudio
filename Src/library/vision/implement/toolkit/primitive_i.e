--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- General primitive implementation.

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class PRIMITIVE_I 

inherit

	WIDGET_I

feature 

	foreground: COLOR is
			-- Foreground color of primitive widget
		deferred
		end;

	set_foreground (new_color: COLOR) is
			-- Set foreground color to `new_color'.
		require
			color_not_void: not (new_color = Void)
		deferred
		ensure
			foreground= new_color
		end;

    update_foreground is
            -- Update the X color after a change inside the Eiffel color.
        deferred
        end;

end
