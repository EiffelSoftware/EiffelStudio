--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- PRIMITIVE_M: implementation of primitive.

indexing

	date: "$Date$";
	revision: "$Revision$"

class PRIMITIVE_M 

inherit

	PRIMITIVE_R_M
		export
			{NONE} all
		end;

	WIDGET_M

feature 

	foreground: COLOR;
			-- Color used for the foreground

	set_foreground (a_color: COLOR) is
			-- Set `foreground' to `a_color'.
		require
			a_color_exists: not (a_color = Void)
		
		local
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if not (foreground = Void) then
				color_implementation ?= foreground.implementation;
				color_implementation.remove_object (Current)
			end;
			foreground := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mforeground.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		ensure
			foreground = a_color
		end;

feature {COLOR_X}

	update_foreground is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X
		do
			ext_name := Mforeground.to_c;
			color_implementation ?= foreground.implementation;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		end

end

