indexing

	description:
		"Rectangle with scrollbars or not which contains a list of %
		%selectable strings";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCROLL_L_M 

inherit

	SCROLL_L_I;

	PRIMITIVE_COMPOSITE_M
		undefine
			set_no_event_propagation
		redefine
			set_size, set_height, set_width
		end;

	LIST_MAN_M
		rename
			is_shown as shown
		undefine
			height, real_x, real_y, realized, shown, width,
			x, y, hide, lower, propagate_event, raise,
			realize, set_x, set_x_y, set_y, show, unrealize,
			make_from_existing, create_callback_struct,
			clean_up, set_no_event_propagation
		redefine
			set_size, set_height, set_width,
			update_background_color, update_foreground_color,
			set_background_color, set_foreground_color,
			set_managed
		end;

	FONTABLE_M;

	MEL_SCROLLED_LIST
		rename
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			screen as mel_screen,
			item_count as count,
			selected_item_count as selected_count,
			selected_items as mel_selected_items,
			deselect_all_items as deselect_all,
			select_item as mel_select_item,
			index_of as mel_index_of,
            is_shown as shown
		undefine
			height, real_x, real_y, realized, width,
			x, y, hide, lower, propagate_event, raise,
			realize, set_x, set_x_y, set_y, show, unrealize
		redefine	
			set_height, set_width, set_size
		select
			list_make_from_existing, make_variable
		end
		
creation

	make

feature {NONE} -- Initialization

	make (a_list: SCROLL_LIST; man, is_fixed: BOOLEAN) is
			-- Create a motif list, get screen_object value of srolled
			-- window which contains current list.
		local
			ext_name: ANY;
			sb: MEL_SCROLL_BAR
		do
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_list.identifier.to_c;
			if is_fixed then
				make_constant (a_list.identifier,
						mel_parent (a_list, widget_index),
						man);
			else
				make_resize_if_possible (a_list.identifier,
						mel_parent (a_list, widget_index),
						man);
			end;
			set_navigation_to_exclusive_tab_group;
			sb := scrolled_window.vertical_scroll_bar;
			sb.set_navigation_to_exclusive_tab_group;
			sb := scrolled_window.horizontal_scroll_bar;
			if sb /= Void then
				sb.set_navigation_to_exclusive_tab_group;
			end;
			a_list.set_list_imp (Current);
		end;

feature -- Access

	main_widget: MEL_SCROLLED_WINDOW is
			-- Main widget of scroll list (scrolled window)
		do
			Result := scrolled_window
		end

feature -- Status setting

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		do
			if flag then
				scrolled_window.manage;
				manage;
			else
				scrolled_window.unmanage;
				unmanage;
			end
		end;

	set_size (new_width:INTEGER; new_height: INTEGER) is
			-- Set both width and height to `new_width'
			-- and `new_height'.
		local
			was_shown, was_unmanaged: BOOLEAN
		do
			if not managed then
				manage;
				was_unmanaged := True
			end;
			scrolled_window.set_size (new_width, new_height)
			if was_unmanaged then
				manage
			end
		end;

	set_width (new_width :INTEGER) is
			-- Set width to `new_width'.
		local
			was_unmanaged: BOOLEAN
		do
			if not managed then
				manage
				was_unmanaged := True
			end;
			scrolled_window.set_width (new_width)
			if was_unmanaged then
				unmanage
			end
		end;

	set_height (new_height: INTEGER) is
			-- Set height to `new_height'.
		local
			was_unmanaged: BOOLEAN;
		do
			if not managed then
				manage
				was_unmanaged := True
			end;
			scrolled_window.set_height (new_height);
			if was_unmanaged then
				unmanage
			end
		end;

	set_foreground_color (a_color: COLOR) is
			-- Set `foreground_color' to `a_color'.
		local
			color_implementation: COLOR_X;
			ext_name: ANY
		do
			if private_foreground_color /= Void then
				color_implementation ?= private_foreground_color.implementation;
				color_implementation.remove_object (Current)
			end;
			private_foreground_color := a_color;
			color_implementation ?= a_color.implementation;
			color_implementation.put_object (Current);
			--ext_name := Mforeground_color.to_c;
			--c_set_color (action_target, color_implementation.pixel (screen), $ext_name)
	   end;

	set_background_color (a_color: COLOR) is
			-- Set background_color to `a_color'.
		local
			pixmap_implementation: PIXMAP_X;
			color_implementation: COLOR_X;
			pix: POINTER;
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
			color_implementation ?= private_background_color.implementation;
			color_implementation.put_object (Current);
			pix := color_implementation.pixel (screen);
			--xm_change_bg_color (screen_object, pix); 
			--xm_change_bg_color (list_screen_object, pix); 
			--xm_change_bg_color (horizontal_widget, pix); 
			--xm_change_bg_color (vertical_widget, pix); 
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end;

feature {COLOR_X} -- Implementation

	update_background_color is 
			-- Update the X color after a change inside the Eiffel color.  
		local 
			ext_name: ANY; 
			color_implementation: COLOR_X; 
			pix: POINTER
		do
		--	ext_name := Mbackground.to_c;
			color_implementation ?= background_color.implementation;
			pix := color_implementation.pixel (screen);
			--xm_change_bg_color (screen_object, pix);
			--xm_change_bg_color (list_screen_object, pix);  
			--xm_change_bg_color (horizontal_widget, pix); 
			--xm_change_bg_color (vertical_widget, pix); 
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end;

	update_foreground_color is
			-- Update the X color after a change inside the Eiffel color.
		local
			ext_name: ANY;
			color_implementation: COLOR_X
		do
			--ext_name := Mforeground_color.to_c;
			color_implementation ?= foreground_color.implementation;
			--c_set_color (action_target,
				--color_implementation.pixel (screen), $ext_name)
		end;

end -- class SCROLL_L_M

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
