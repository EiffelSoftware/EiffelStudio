
-- SCROLLED_W_M: implementation of scrolled window.

indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_W_M

inherit

	SCROLLED_W_R_M
		export
			{NONE} all
		end;


	SCROLLED_W_R_M
		export
			{NONE} all
		end;

	MANAGER_M
		rename
			set_foreground as man_set_foreground,
			set_background_color as man_set_background_color
		end;

	MANAGER_M
		redefine
			set_foreground, set_background_color
		select
			set_foreground, set_background_color
		end;


	    SCROLLED_W_I
        export
            {NONE} all
        end

creation

    make

feature -- Creation

    make (a_scrolled_window: SCROLLED_W) is
            -- Create a motif scrolled window.
        local
            ext_name: ANY
        do
            ext_name := a_scrolled_window.identifier.to_c;
            screen_object := create_scrolled_w ($ext_name,
                    a_scrolled_window.parent.implementation.screen_object);
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
			ext_name: ANY
		do
			if not (background_pixmap = Void) then
				pixmap_implementation ?= background_pixmap.implementation;
				pixmap_implementation.remove_object (Current);
				background_pixmap := Void
			end;
			if not (background_color = Void) then
				color_implementation ?= background_color.implementation;
				color_implementation.remove_object (Current)
			end;
			bg_color := a_color;
			color_implementation ?= background_color.implementation;
			color_implementation.put_object (Current);
			ext_name := Mbackground.to_c;
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name);
			c_set_color (vertical_widget, color_implementation.pixel (screen), $ext_name);
			c_set_color (horizontal_widget, color_implementation.pixel (screen), $ext_name);
		end;

	set_foreground (a_color:  COLOR) is
			-- Set `foreground' to `a_color'.
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
			c_set_color (screen_object, color_implementation.pixel (screen), $ext_name);
			c_set_color (vertical_widget, color_implementation.pixel (screen), $ext_name);
			c_set_color (horizontal_widget, color_implementation.pixel (screen), $ext_name);
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


feature {NONE} -- External features

    create_scrolled_w (sw_name: ANY; scr_obj: POINTER): POINTER is
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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
