indexing

	description: 
		"EiffelVision implementation of a Motif scrolled window.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	SCROLLED_W_M

inherit

	SCROLLED_W_I;

	MANAGER_M
		undefine
			create_callback_struct
		redefine
			set_background_color,
			update_background_color
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
            screen as mel_screen
        end

creation

	make

feature {NONE} -- Initialization

	make (a_scrolled_window: SCROLLED_W; man: BOOLEAN) is
			-- Create a motif scrolled window.
		do
			widget_index := widget_manager.last_inserted_position;
            make_with_automatic_scrolling (a_scrolled_window.identifier,
                    mel_parent (a_scrolled_window, widget_index),
                    man);
	   end;

feature -- Status report

	working_area: WIDGET is
			-- Working area of window which will
			-- be moved using scrollbars
		local
			widget_m: WIDGET_M
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

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			ext_name: ANY;
			pix: POINTER
		do
			if private_background_pixmap /= Void then
				pixmap_implementation ?= private_background_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				private_background_pixmap := Void
			end;
			if private_background_color /= Void then
				color_implementation ?= private_background_color.implementation;
				color_implementation.remove_object (Current)
			end;
			private_background_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			pix := color_implementation.pixel (screen);
			--xm_change_bg_color (screen_object, pix);
			--xm_change_bg_color (vertical_widget, pix);
			--xm_change_bg_color (horizontal_widget, pix);
			--xm_change_bg_color (clip_window, pix);
			if private_foreground_color /= Void then
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
			--xm_change_bg_color (screen_object, pix);
			--xm_change_bg_color (horizontal_widget, pix);
			--xm_change_bg_color (vertical_widget, pix);
			--xm_change_bg_color (clip_window, pix);
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end;

end -- class SCROLLED_W_M

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
