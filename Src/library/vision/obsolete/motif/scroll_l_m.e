indexing

	description:
		"Rectangle with scrollbars or not which contains a list of %
		%selectable strings";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	SCROLL_L_M 

inherit

	SCROLL_L_I;

	FONTABLE_IMP;

	PRIMITIVE_COMPOSITE_IMP
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
			set_no_event_propagation, clean_up, object_clean_up
		redefine
			set_size, set_height, set_width,
			set_background_color_from_imp, set_managed, parent
		end;

	MEL_SCROLLED_LIST
		rename
			make as mel_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
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
			set_height, set_width, set_size, parent
		select
			list_make_from_existing, mel_make
		end
		
creation

	make

feature {NONE} -- Initialization

	make (a_list: SCROLL_LIST; man, is_fixed: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif list, get screen_object value of srolled
			-- window which contains current list.
		local
			ext_name: ANY;
			sb: MEL_SCROLL_BAR;
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			ext_name := a_list.identifier.to_c;
			if is_fixed then
				make_constant (a_list.identifier, mc, man)
			else
				make_resize_if_possible (a_list.identifier, mc, man)
			end;
			set_navigation_to_exclusive_tab_group;
			sb := parent.vertical_scroll_bar;
			sb.set_navigation_to_exclusive_tab_group;
			sb := parent.horizontal_scroll_bar;
			if sb /= Void then
				sb.set_navigation_to_exclusive_tab_group;
			end;
			a_list.set_list_imp (Current);
			a_list.set_font_imp (Current);
		end;

feature -- Access

	parent: MEL_SCROLLED_WINDOW;
			-- Dialog shell parent

	main_widget: MEL_SCROLLED_WINDOW is
			-- Main widget of scroll list (scrolled window)
		do
			Result := parent
		end

feature -- Status setting

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		do
			if flag then
				parent.manage;
				manage;
			else
				parent.unmanage;
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
			parent.set_size (new_width, new_height)
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
			parent.set_width (new_width)
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
			parent.set_height (new_height);
			if was_unmanaged then
				unmanage
			end
		end;

	set_background_color_from_imp (color_imp: COLOR_IMP) is
			-- Set the background color from implementation `color_imp'.
		local
			w: MEL_WIDGET
		do
			mel_set_background_color (color_imp);
			update_colors;
			parent.set_background_color (color_imp)
			w := parent.vertical_scroll_bar;
			if w /= Void then
				w.set_background_color (color_imp);
				w.update_colors
			end;
			w := parent.horizontal_scroll_bar;
			if w /= Void then
				w.set_background_color (color_imp);
				w.update_colors
			end;
			if private_foreground_color /= Void then
				update_foreground_color
			end
		end

end -- class SCROLL_L_M


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

