indexing

	description: 
		"EiffelVision implementation of a MOTIF manager widget.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MANAGER_M 

inherit

	COMPOSITE_M
		rename
			set_background_color as widget_set_background_color,
			update_background_color as widget_update_background_color
		end;

	COMPOSITE_M
		redefine
			set_background_color, update_background_color
		select
			set_background_color, update_background_color
		end;

	MEL_MANAGER
		rename
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen
		end

feature -- Access

	is_stackable: BOOLEAN is 
			-- Is the Current widget stackable?
		do
			Result := True;
		end;

feature -- Status Report

	foreground_color: COLOR is
			-- Color used for the foreground_color
		local
			fg_color_x: COLOR_X
		do
			if private_foreground_color = Void then
				!! private_foreground_color.make;
				fg_color_x ?= private_foreground_color.implementation;
				--fg_color_x.set_pixel (xt_pixel (screen_object, Mforeground_color));
			end;
			Result := private_foreground_color;
		ensure
			color_exists: Result /= Void
		end;

feature -- Status Setting

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		require
			a_color_exists: not (a_color = Void)
		local
			color_implementation: COLOR_X;	
			ext_name: ANY;
			pixel: POINTER
		do
			if private_foreground_color /= Void then
				color_implementation ?= private_foreground_color.implementation;
				color_implementation.remove_object (Current)
			end;
			private_foreground_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			--ext_name := Mforeground_color.to_c;
			pixel := color_implementation.pixel (screen);
			--c_set_color (screen_object, pixel, $ext_name)
			update_other_fg_color (pixel)
		ensure
			foreground_color = a_color
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
			--| Make sure to reset the foreground color
			--| if it has been set.
		local
			color_implementation: COLOR_X;
			ext_name: ANY;
			pixel: POINTER;
		do
			widget_set_background_color (a_color);
			color_implementation ?= private_background_color.implementation;
			pixel := color_implementation.pixel (screen);
			update_other_bg_color (pixel);
			if private_foreground_color /= Void then
				update_foreground_color
			end;
		end;

feature -- Update

	update_other_bg_color (pixel: POINTER) is
		do
		end;

	update_other_fg_color (pixel: POINTER) is
		do
		end;

feature {NONE} -- Implementation

	private_foreground_color: COLOR;
			-- foreground_color color

feature {COLOR_X} -- Implementation

	update_foreground_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X;	
			pixel: POINTER;
		do
			--ext_name := Mforeground_color.to_c;
			color_implementation ?= foreground_color.implementation;
			pixel := color_implementation.pixel (screen);
			--c_set_color (screen_object, pixel, $ext_name)
			update_other_fg_color (pixel);
		end

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			pixel: POINTER;
			color_implementation: COLOR_X
		do
			widget_update_background_color;
			color_implementation ?= private_background_color.implementation;
			pixel := color_implementation.pixel (screen);
			update_other_bg_color (pixel);
			if private_foreground_color /= Void then
				update_background_color
			end
		end;

end -- class MANAGER_M

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
