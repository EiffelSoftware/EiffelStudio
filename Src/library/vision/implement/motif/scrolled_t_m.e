
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_T_M

inherit

	TEXT_M
		rename
			enable_word_wrap as text_enable_word_wrap,
			disable_word_wrap as text_disable_word_wrap,
			set_foreground as text_set_foreground,
			set_background_color as text_set_background_color
		undefine
			make
		redefine
			action_target
		end;

	TEXT_M
		undefine
			make
		redefine
			action_target, disable_word_wrap, enable_word_wrap,
			set_foreground, set_background_color
		select
			disable_word_wrap, enable_word_wrap,
			set_foreground, set_background_color
		end;

	SCROLLED_W_R_M;

	SCROLLED_T_I;

creation

	make

feature -- Creation

	make (a_scrolled_text: TEXT) is
			-- Create a motif scrolled text.
		local
			ext_name: ANY
		do
			ext_name := a_scrolled_text.identifier.to_c;
			action_target := create_scrolled_text ($ext_name,
					a_scrolled_text.parent.implementation.screen_object);
			screen_object := xt_parent (action_target);
			a_scrolled_text.set_font_imp (Current)
		end;

feature -- Color

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
			c_set_color (action_target, color_implementation.pixel (screen), $ext_name);
			c_set_color (vertical_widget, color_implementation.pixel (screen), $ext_name);
			c_set_color (horizontal_widget, color_implementation.pixel (screen), $ext_name);
		end;

	set_foreground (a_color: COLOR) is
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
			c_set_color (action_target, color_implementation.pixel (screen), $ext_name);
			c_set_color (vertical_widget, color_implementation.pixel (screen), $ext_name);
			c_set_color (horizontal_widget, color_implementation.pixel (screen), $ext_name);
		end;


feature

	disable_word_wrap is
            -- Specify that lines are free to go off the right edge
            -- of the window.
		do
			show_horizontal_scrollbar;
           		text_disable_word_wrap; 
		end;
	
	enable_word_wrap is
            -- Specify that lines are to be broken at word breaks.
            -- The text does not go off the right edge of the window.
			-- The horizontal bar is not shown.
		do
			hide_horizontal_scrollbar;
			text_enable_word_wrap;
		ensure then
			not is_horizontal_scrollbar
		end;

	action_target: POINTER;
			-- Widget ID on which action must be applied

	hide_horizontal_scrollbar is
			-- Make horizontal scrollbar invisible.
		do
			xt_unmanage_child (horizontal_widget);
			--set_xt_boolean (screen_object, False, MscrollHorizontal);
		end;

	hide_vertical_scrollbar is
			-- Make vertical scrollbar invisible.
		do
			xt_unmanage_child (vertical_widget);
			--set_xt_boolean (screen_object, False, MscrollVertical);
		end;

	is_horizontal_scrollbar: BOOLEAN is
			-- Is horizontal scrollbar visible?
		do
            		Result := xt_is_managed (horizontal_widget);
            		--Result := xt_boolean (action_target, MscrollHorizontal);
		end;

	is_vertical_scrollbar: BOOLEAN is
			-- Is vertical scrollbar visible?
		do
			Result := xt_is_managed (vertical_widget);;
		end;

	show_horizontal_scrollbar is
			-- Make horizontal scrollbar visible.
		do
			xt_manage_child (horizontal_widget);
			--set_xt_boolean (screen_object, True, MscrollHorizontal);
		end;

	show_vertical_scrollbar is
			-- Make vertical scrollbar visible.
		do
			xt_manage_child (vertical_widget);
			--set_xt_boolean (screen_object, True, MscrollVertical);
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

feature {NONE} -- Externals

	create_scrolled_text (st_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
