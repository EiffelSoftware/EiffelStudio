indexing

	description: 
		"EiffelVision pict_color_b, gtk implementation.";
	status: "See notice at end of class";
	id: "$id: $";
	date: "$Date$";
	revision: "$Revision$"
	
class
	PICT_COLOR_B_IMP

inherit

	PICT_COLOR_B_I
		undefine
			-- using build from PUSH_B_IMP
			build
		end
	
	PUSH_B_IMP -- should this be BUTTON_IMP?
	
creation

	make	


feature -- Status report

	pixmap: PIXMAP is
			-- Pixmap for Current
		local
			ext_name: ANY;
			pixmap_x: PIXMAP_IMP
		do
			if private_pixmap = Void then
				!! private_pixmap.make;
				pixmap_x ?= private_pixmap.implementation;
				pixmap_x.increment_users;
--XX				pixmap_x.set_default_pixmap (mel_pixmap);
			end;
			Result := private_pixmap
		end;

	is_pressed: BOOLEAN
			-- Is the pict color button pressed?

feature -- Status setting

	set_pixmap (a_pixmap: PIXMAP) is
			-- Set pixmap to `a_pixmap'.
		local
			pixmap_implementation: PIXMAP_IMP;
			ext_name: ANY
		do
			if private_pixmap /= Void then
				pixmap_implementation ?= private_pixmap.implementation;
				pixmap_implementation.decrement_users
			end;
			private_pixmap := a_pixmap;
			pixmap_implementation ?= a_pixmap.implementation;
			pixmap_implementation.increment_users;
--XX			mel_set_pixmap (pixmap_implementation);
--XX			set_insensitive_pixmap (pixmap_implementation)
		end;

	set_pressed (b: like is_pressed) is
			-- Set `is_pressed' to `b'.
		local
			t_color, b_color: MEL_PIXEL
		do
			if is_pressed /= b then
				is_pressed := b
--XX				t_color := top_shadow_color;
--XX				b_color := bottom_shadow_color;
--XX				set_top_shadow_color (b_color);	
--XX				set_bottom_shadow_color (t_color);	
			end
		end;

feature {PIXMAP_IMP} -- Implementation

	private_pixmap: PIXMAP;
			-- Pixmap data

	update_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			pixmap_implementation: PIXMAP_IMP
		do
			pixmap_implementation ?= private_pixmap.implementation;
--XX			mel_set_pixmap (pixmap_implementation);
--XX			set_insensitive_pixmap (pixmap_implementation)
		end;

	set_background_color_from_imp (color_imp: COLOR_IMP) is
			-- Set the background color from implementation `color_imp'.
		do
--XX			mel_set_background_color (color_imp);
--XX			xm_change_color (screen_object, color_imp.identifier);
			if is_pressed then	
				set_pressed (False);
				is_pressed := True
			end;
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end;



end

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
