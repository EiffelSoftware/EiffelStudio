indexing

	description: 
		"EiffelVision implementation of a Motif scrolled window.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	SCROLLED_W_IMP

inherit

	SCROLLED_W_I;

	MANAGER_IMP
		rename
			is_shown as shown
		undefine
			create_callback_struct
		redefine
			set_background_color_from_imp
		end;

	MEL_SCROLLED_WINDOW
		rename
			make as mel_scrolled_w_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			is_shown as shown
		end

creation

	make

feature {NONE} -- Initialization

	make (a_scrolled_window: SCROLLED_W; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif scrolled window.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			make_with_automatic_scrolling (a_scrolled_window.identifier, mc, man)
	   end;

feature -- Status report

	working_area: WIDGET is
			-- Working area of window which will
			-- be moved using scrollbars
		local
			widget_m: WIDGET_IMP
		do
			widget_m ?= work_window;
			Result := widget_m.widget_oui
		end;

feature -- Status setting

	set_working_area (a_widget: WIDGET) is
			-- Set work area of windon to `a_widget'.
		local
			mo: MEL_WIDGET
		do
			mo ?= a_widget.implementation;
			set_work_window (mo)
		end;

    set_background_color_from_imp (color_imp: COLOR_IMP) is
            -- Set the background color from implementation `color_imp'.
		local
			w: MEL_WIDGET
			g: MEL_GADGET
		do
			mel_set_background_color (color_imp);
			w := vertical_scroll_bar;
			if w /= Void then
				w.set_background_color (color_imp);
				w.update_colors
			end;
			w := horizontal_scroll_bar;
			if w /= Void then
				w.set_background_color (color_imp);
				w.update_colors
			end;
			w := clip_window;
			if w /= Void then
				w.set_background_color (color_imp)
			end;
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end;

end -- class SCROLLED_W_IMP


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

