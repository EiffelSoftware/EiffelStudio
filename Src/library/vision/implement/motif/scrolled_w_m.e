indexing

	description: "Implementation of scrolled window";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_W_M

inherit

	SCROLLED_W_R_M;

	SCROLLED_W_R_M;

	MANAGER_M
		redefine
			set_background_color,
			update_background_color
		end;

	SCROLLED_W_I

creation

	make

feature {NONE} -- Creation

	make (a_scrolled_window: SCROLLED_W; man: BOOLEAN) is
			-- Create a motif scrolled window.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_scrolled_window.identifier.to_c;
			screen_object := create_scrolled_w ($ext_name,
				parent_screen_object (a_scrolled_window, widget_index),
				man);
	   end;

feature 

	working_area: WIDGET;
			-- Working area of window which will
			-- be moved using scrollbars

	set_working_area (a_widget: WIDGET) is
			-- Set work area of windon to `a_widget'.
		require else
			not_a_widget_void: not (a_widget = Void)
		do
			working_area := a_widget;
			set_xt_widget (screen_object, a_widget.implementation.screen_object, MworkWindow)
		ensure then
			working_area = a_widget
		end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY;
			pix: POINTER
		do
			if bg_pixmap /= Void then
				pixmap_implementation ?= bg_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				bg_pixmap := Void
			end;
			if bg_color /= Void then
				color_implementation ?= bg_color.implementation;
				color_implementation.remove_object (Current)
			end;
			bg_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			pix := color_implementation.pixel (screen);
			xm_change_bg_color (screen_object, pix);
			xm_change_bg_color (vertical_widget, pix);
			xm_change_bg_color (horizontal_widget, pix);
			xm_change_bg_color (clip_window, pix);
			if fg_color /= Void then
				update_foreground_color
			end
		end;

feature {COLOR_X}

	update_background_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			color_implementation: COLOR_X;
			pix: POINTER
		do
			color_implementation ?= background_color.implementation;
			pix := color_implementation.pixel (screen);
			xm_change_bg_color (screen_object, pix);
			xm_change_bg_color (horizontal_widget, pix);
			xm_change_bg_color (vertical_widget, pix);
			xm_change_bg_color (clip_window, pix);
			if fg_color /= Void then
				update_foreground_color
			end
		end;

feature {NONE}

	vertical_widget: POINTER is
		do
			Result := xt_widget (screen_object, MverticalScrollBar);
		end;

	horizontal_widget: POINTER is
		do
			Result := xt_widget (screen_object, MhorizontalScrollBar);
		end;

	clip_window: POINTER is
		do
			Result := xt_widget (screen_object, MclipWindow);
		end;

feature {NONE} -- External features

	create_scrolled_w (sw_name: POINTER; scr_obj: POINTER;
			man: BOOLEAN): POINTER is
		external
			"C"
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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
