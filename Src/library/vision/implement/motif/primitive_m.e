indexing

	description: "Implementation of primitive";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class PRIMITIVE_M 

inherit

	PRIMITIVE_R_M;

	WIDGET_M
		rename
			set_background_color as widget_set_background_color,
			update_background_color as widget_update_background_color
		end;

	WIDGET_M
		redefine
			set_background_color, update_background_color
		select
			set_background_color, update_background_color
		end;

feature 

	foreground_color: COLOR is
			-- Color used for the foreground_color
		local
			fg_color_x: COLOR_X
		do
			if fg_color = Void then
				!! fg_color.make;
				fg_color_x ?= fg_color.implementation;
				fg_color_x.set_pixel (xt_pixel (screen_object, Mforeground_color));
			end;
			Result := fg_color;
		ensure
			color_exists: Result /= Void
		end;

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		require
			a_color_exists: a_color /= Void
		local
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if fg_color /= Void then
				color_implementation ?= fg_color.implementation;
				color_implementation.remove_object (Current)
			end;
			fg_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mforeground_color.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name)
		ensure
			foreground_color_set: foreground_color = a_color
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
			--| Make sure to reset the foreground color
			--| if it has been set.
		local
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			widget_set_background_color (a_color);
			if fg_color /= Void then
				update_foreground_color	
			end;	
		end;

feature {NONE} 

	fg_color: COLOR;
			-- foreground_color colour

feature {COLOR_X}

	update_background_color is
		do
			widget_update_background_color;
			if fg_color /= Void then
				update_foreground_color
			end
		end;

	update_foreground_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X
		do
			ext_name := Mforeground_color.to_c;
			color_implementation ?= foreground_color.implementation;
			c_set_color (screen_object, 
				color_implementation.pixel (screen), $ext_name)
		end;

feature

	is_stackable: BOOLEAN is 
		do
			Result := True;
		end;

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
