indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLLED_T_M

inherit

	TEXT_M
		undefine
			make, make_word_wrapped
		redefine
			action_target, 
			set_background_color,
			update_background_color,
			set_foreground_color,
			update_foreground_color,
			set_managed, managed, set_size, set_height,
			set_width
		end;

	SCROLLED_W_R_M;

	SCROLLED_T_I;

creation

	make, make_word_wrapped

feature {NONE} -- Creation

	make (a_scrolled_text: TEXT; man: BOOLEAN) is
			-- Create a motif scrolled text.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_scrolled_text.identifier.to_c;
			action_target := create_scrolled_text ($ext_name,
				parent_screen_object (a_scrolled_text, widget_index),
				man);
			screen_object := xt_parent (action_target);
			if not man then
				xt_unmanage_child (screen_object)
			end;
			a_scrolled_text.set_font_imp (Current)
		end;

	make_word_wrapped (a_scrolled_text: TEXT; man: BOOLEAN) is
			-- Create a motif scrolled text enabling word wrap.
		local
			ext_name: ANY
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_scrolled_text.identifier.to_c;
			action_target := create_scrolled_text_ww ($ext_name,
					parent_screen_object (a_scrolled_text, widget_index),
					man);
			screen_object := xt_parent (action_target);
			if not man then
				xt_unmanage_child (screen_object)
			end;
			a_scrolled_text.set_font_imp (Current)
		end;

feature -- Setting size

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		local
			ext_name_Mw, ext_name_Mh: ANY
			was_unmanaged: BOOLEAN
		do
			ext_name_Mw := Mwidth.to_c;
			ext_name_Mh := Mheight.to_c;
			if not managed then
				xt_manage_child (action_target);
				was_unmanaged := True
			end;
			set_dimension (screen_object, new_width, $ext_name_Mw);
			set_dimension (screen_object, new_height, $ext_name_Mh)
			if was_unmanaged then
				xt_unmanage_child (action_target)
			end
		end;

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		local
			ext_name_Mw: ANY;
			was_unmanaged: BOOLEAN
		do
			ext_name_Mw := Mwidth.to_c;
			if not managed then
				xt_manage_child (action_target);
				was_unmanaged := True
			end;
			set_dimension (screen_object, new_width, $ext_name_Mw)
			if was_unmanaged then
				xt_unmanage_child (action_target)
			end
		end;

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		local
			ext_name: ANY;
			was_unmanaged: BOOLEAN;
		do
			if not managed then
				xt_manage_child (action_target);
				was_unmanaged := True
			end;
			ext_name := Mheight.to_c;
			set_dimension (screen_object, new_height, $ext_name)
			if was_unmanaged then
				xt_unmanage_child (action_target)
			end
		end;

feature -- Managing

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		do
			if flag then
				xt_manage_child (screen_object)
				xt_manage_child (action_target)
			else
				xt_unmanage_child (screen_object)
				xt_unmanage_child (action_target)
			end
		end;

	managed: BOOLEAN is
			-- Is there geometry managment on X widget implementation
			-- perform by window manager of parent widget?
		do
			Result := xt_is_managed (action_target)
		end;

feature -- Color

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
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
			color_implementation ?= bg_color.implementation;
			color_implementation.put_object (Current);
			pix := color_implementation.pixel (screen);
			xm_change_bg_color (screen_object, pix);
			xm_change_bg_color (action_target, pix);
			xm_change_bg_color (vertical_widget, pix);
			if not is_word_wrap_mode then
					-- There are no horizontal_widget when
					-- Current is word wrapped.
				xm_change_bg_color (horizontal_widget, pix);
			end;
			if fg_color /= Void then
				update_foreground_color
			end
		end;

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
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
			c_set_color (action_target, color_implementation.pixel (screen), $ext_name)
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
			xm_change_bg_color (action_target, pix);
			if not is_word_wrap_mode then
					-- There are no horizontal_widget when
					-- Current is word wrapped.
				xm_change_bg_color (horizontal_widget, pix);
			end;
			xm_change_bg_color (vertical_widget, pix);
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
			c_set_color (action_target,
				color_implementation.pixel (screen), $ext_name)
		end;

feature

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

	create_scrolled_text (st_name: POINTER; scr_obj: POINTER; 
				is_man: BOOLEAN): POINTER is
		external
			"C"
		end;

	create_scrolled_text_ww (st_name: POINTER; scr_obj: POINTER; 
				is_man: BOOLEAN): POINTER is
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
