--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- PRIMITIVE_O: implementation of primitive.

indexing

	date: "$Date$";
	revision: "$Revision$"

class PRIMITIVE_O 

inherit

	PRIMITIVE_R_O
		export
			{NONE} all
		end;

	WIDGET_O

feature {COLOR_X}

	fg_color: COLOR;
			-- Color used for the foreground.
			-- Void after creation.

	foreground: COLOR is
			-- Color used for the foreground.
		local
			x_fg_color: COLOR_X
		do
			if fg_color = Void then
				!!fg_color.make;
				x_fg_color ?= fg_color.implementation;
				x_fg_color.set_pixel (xt_pixel (screen_object, "foreground"));
			end;
			Result := fg_color;
		ensure
			not (Result = Void)
		end;

	set_foreground (a_color: COLOR) is
			-- Set `foreground' to `a_color'.
		require
			a_color_exists: not (a_color = Void)
		
		local
			forg_name: ANY;
			color_implementation: COLOR_X
		do
			if not (fg_color = Void) then
				color_implementation ?= fg_color.implementation;
				color_implementation.remove_object (Current)
			end;
			fg_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			forg_name := Oforeground.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $forg_name)
		ensure
			foreground = a_color
		end; 

	update_foreground is
			-- Update the X color after a change inside the Eiffel color.
		
		local
			forg_name: ANY;
			color_implementation: COLOR_X
		do
			forg_name := Oforeground.to_c;
			color_implementation ?= foreground.implementation;
			c_set_color (screen_object, 
						color_implementation.pixel (screen), 
						$forg_name)
		end;


end 
