indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	WM_SHELL_IMP

inherit

	WM_SHELL_I;

	MEL_WM_SHELL
		rename
			icon_mask as mel_icon_mask,	
			set_icon_mask as mel_set_icon_mask,
			icon_pixmap as mel_icon_pixmap,
			set_icon_pixmap as mel_set_icon_pixmap,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen
		end

feature -- Access

	widget_group: WIDGET

	icon_mask: PIXMAP is
			-- Bitmap that could be used by window manager
			-- to clip `icon_pixmap' bitmap to make the
			-- icon nonrectangular 
		do
		end;

	icon_pixmap: PIXMAP is
			-- Bitmap that could be used by the window manager
			-- as the application's icon
		local
			ext_name: ANY;
			pixmap_x: PIXMAP_IMP
		do
			if private_icon_pixmap = Void then
				!! private_icon_pixmap.make;
				pixmap_x ?= private_icon_pixmap.implementation;
				pixmap_x.increment_users;
				pixmap_x.set_default_pixmap (mel_icon_pixmap);
			end;
			Result := private_icon_pixmap
		end

feature -- Status Setting

	set_widget_group (a_widget: WIDGET) is
			-- Set `widget_group' to `a_widget'.
		do
		end;

	set_icon_mask (a_mask: PIXMAP) is
			-- Set `icon_mask' to `a_mask'.
		do
		end;

	set_icon_pixmap (a_pixmap: PIXMAP) is
			-- Set `icon_pixmap' to `a_pixmap'.
		local
			pixmap_implementation: PIXMAP_IMP
		do
			if private_icon_pixmap /= Void then
				pixmap_implementation ?= private_icon_pixmap.implementation;
				pixmap_implementation.decrement_users
			end;
			private_icon_pixmap := a_pixmap;
			pixmap_implementation ?= private_icon_pixmap.implementation;
			pixmap_implementation.increment_users;
			pixmap_implementation.allocate_bitmap;
			mel_set_icon_pixmap (pixmap_implementation.bitmap)
		end;

feature {PIXMAP_IMP} -- Implementation

	private_icon_pixmap: PIXMAP;
			-- Icon pixmap for Current Shell

	update_pixmap is
			-- Update the X pixmap after a change inside the Eiffel pixmap.
		local
			pixmap_implementation: PIXMAP_IMP
		do
			pixmap_implementation ?= private_icon_pixmap.implementation;
			mel_set_icon_pixmap (pixmap_implementation)
		end

end -- class WM_SHELL_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

