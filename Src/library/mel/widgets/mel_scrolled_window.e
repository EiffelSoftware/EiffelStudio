indexing

	description:
			"Manager widget that provides scroll bars for the data display.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLLED_WINDOW

inherit

	MEL_SCROLLED_WINDOW_RESOURCES
		export
			{NONE} all
		end;

	MEL_MANAGER
		redefine
			create_callback_struct
		end

creation
	make, 
	make_with_automatic_scrolling, 
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled window.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY;
			w: POINTER
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_window (a_parent.screen_object,
									$widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			w := c_get_widget (screen_object, XmNclipWindow);
			if w /= default_pointer then	
				!! clip_window.make_from_existing (w, Current)
			end;
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

	make_with_automatic_scrolling (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled window with an automatic scrolling.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY;
			w: POINTER
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_window_with_automatic_scrolling
									(a_parent.screen_object, $widget_name);
			Mel_widgets.add (Current);
			w := c_get_widget (screen_object, XmNclipWindow);
			if w /= default_pointer then	
				!! clip_window.make_from_existing (w, Current)
			end;
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Access

	traverse_obscured_command: MEL_COMMAND_EXEC is
			-- Command set for the traverse obscured callback
		do
			Result := motif_command (XmNtraverseObscuredCallback)
		end

feature -- Status report

	clip_window: MEL_DRAWING_AREA;
			-- Clipping area 
			--| Implemented as a drawing area (6A-page298)

	horizontal_scroll_bar: MEL_SCROLL_BAR is
			-- Horizontal scroll_bar
		require
			exists: not is_destroyed
		local
			w: POINTER
		do
			w := c_get_widget (screen_object, XmNhorizontalScrollbar)
			if w /= default_pointer then	
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	vertical_scroll_bar: MEL_SCROLL_BAR is
			-- Vertical scroll_bar
		require
			exists: not is_destroyed
		local
			w: POINTER
		do
			w := c_get_widget (screen_object, XmNverticalScrollbar)
			if w /= default_pointer then	
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	is_scroll_bar_display_policy_static: BOOLEAN is
			-- Is the vertical scroll bar always shown?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNscrollBarDisplayPolicy) = XmSTATIC
		end;

	is_scroll_bar_display_policy_as_needed: BOOLEAN is
			-- Is the vertical scroll bar always shown?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char 	
				(screen_object, XmNscrollBarDisplayPolicy) = XmAS_NEEDED
		end;

	scroll_bar_placement_top_left: BOOLEAN is
			-- Are the scroll bars shown at the top and the left side?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNscrollBarPlacement) = XmTOP_LEFT
		end;

	scroll_bar_placement_bottom_left: BOOLEAN is
			-- Are the scroll bars shown at the bottom and the left side?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNscrollBarPlacement) = XmBOTTOM_LEFT
		end;

	scroll_bar_placement_top_right: BOOLEAN is
			-- Are the scroll bars shown at the top and the right side?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNscrollBarPlacement) = XmTOP_RIGHT
		end;

	scroll_bar_placement_bottom_right: BOOLEAN is
			-- Are the scroll bars shown at the bottom and the right side?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNscrollBarPlacement) = XmBOTTOM_RIGHT
		end;

	margin_height: INTEGER is
			-- Spacing at the top and bottom of Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNScrolledWindowMarginHeight)
		ensure
			margin_height_large_enough: Result >= 0
		end;

	margin_width: INTEGER is
			-- Spacing at the right and left sides of Current
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNScrolledWindowMarginWidth)
		ensure
			margin_width_large_enough: Result >= 0
		end;

	is_scrolling_policy_automatic: BOOLEAN is
			-- Is scrolling handled by Current?
		require	
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNscrollingPolicy) = XmAUTOMATIC
		end;

	spacing: INTEGER is
			-- Distance between each of the scrollbars and `work_window'.
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNspacing)
		ensure
			spacing_large_enough: Result >= 0
		end;

	is_visual_policy_constant: BOOLEAN is
			-- Is the viewing area clipped if needed?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNvisualPolicy) = XmCONSTANT
		end;

	work_window: MEL_WIDGET;
			-- Working area

feature -- Status setting

	set_horizontal_scroll_bar (a_scroll_bar: MEL_SCROLL_BAR) is
			-- Set `horizontal_scroll_bar' to `a_scroll_bar'.
		require
			exists: not is_destroyed;
			a_scroll_bar_exists: not a_scroll_bar.is_destroyed
		do
			set_xt_widget (screen_object, XmNhorizontalScrollBar, a_scroll_bar.screen_object)
		ensure
			horizontal_scroll_bar_set: horizontal_scroll_bar.is_equal (a_scroll_bar)
		end;

	set_vertical_scroll_bar (a_scroll_bar: MEL_SCROLL_BAR) is
			-- Set `vertical_scroll_bar' to `a_scroll_bar'.
		require
			exists: not is_destroyed;
			a_scroll_bar_exists: not a_scroll_bar.is_destroyed
		do
			set_xt_widget (screen_object, XmNverticalScrollBar, a_scroll_bar.screen_object)
		ensure
			vertical_scroll_bar_set: vertical_scroll_bar.is_equal (a_scroll_bar)
		end;

	set_scroll_bar_display_policy_static is
			-- Set `scroll_bar_display_policy_static' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNscrollBarDisplayPolicy, XmSTATIC)
		ensure
			display_policy_is_static: is_scroll_bar_display_policy_static 
		end;

	set_scroll_bar_display_policy_as_needed is
			-- Set `scroll_bar_display_policy_as_needed' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNscrollBarDisplayPolicy, XmAS_NEEDED)
		ensure
			display_policy_as_need: is_scroll_bar_display_policy_as_needed
		end;

	set_scroll_bar_placement_top_left is
			-- Set `scroll_bar_placement_top_left'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNscrollBarPlacement, XmTOP_LEFT)
		ensure
			scroll_bar_placement_set: scroll_bar_placement_top_left
		end;

	set_scroll_bar_placement_bottom_left is
			-- Set `scroll_bar_placement_bottom_left'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNscrollBarPlacement, XmBOTTOM_LEFT)
		ensure
			scroll_bar_placement_set: scroll_bar_placement_bottom_left
	   end;

	set_scroll_bar_placement_top_right is
			-- Set `scroll_bar_placement_top_right'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNscrollBarPlacement, XmTOP_RIGHT)
		ensure
			scroll_bar_placement_set: scroll_bar_placement_top_right
		end;

	set_scroll_bar_placement_bottom_right is
			-- Set `scroll_bar_placement_bottom_right'.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNscrollBarPlacement, XmBOTTOM_RIGHT)
		ensure
			scroll_bar_placement_set: scroll_bar_placement_bottom_right
		end;

	set_margin_height (a_height: INTEGER) is
			-- Set `margin_height' to `a_height'.
		require
			exists: not is_destroyed;
			a_height_large_enough: a_height > 0
		do
			set_xt_dimension (screen_object, XmNScrolledWindowMarginHeight, a_height)
		ensure
			margin_height_set: margin_height = a_height
		end;

	set_margin_width (a_width: INTEGER) is
			-- Set `margin_width' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width > 0
		do
			set_xt_dimension (screen_object, XmNScrolledWindowMarginWidth, a_width)
		ensure
			margin_width_set: margin_width = a_width
		end;

	set_spacing (a_distance: INTEGER) is
			-- Set `spacing' to `a_distance'.
		require
			exists: not is_destroyed;
			a_distance_large_enough: a_distance > 0
		do
			set_xt_dimension (screen_object, XmNspacing, a_distance)
		ensure
			spacing_set: spacing = a_distance
		end;

	set_work_window (a_widget: like work_window) is
			-- Set `work_window' to `a_widget'.
		require
			exists: not is_destroyed;
			a_widget_exists: not a_widget.is_destroyed;
			valid_widget_parent: a_widget.parent = Current
		do
			work_window := a_widget;
			set_xt_widget (screen_object, XmNworkWindow, a_widget.screen_object)
		ensure
			work_window_set: work_window.is_equal (a_widget)
		end;

	set_scroll_visible (a_widget: MEL_OBJECT; left_right_margin, top_bottom_margin: INTEGER) is
			-- Make `a_widget' visible and use the `left_right_margin' and `top_bottom_margin'
			-- if `clip_window' needs to be adjusted to make the `a_widget' visible.
		require
			valid_a_widget: a_widget /= Void and then not a_widget.is_destroyed;
			scrolling_policy_automatic: is_scrolling_policy_automatic;
			valid_margins: left_right_margin >= 0 and then top_bottom_margin >= 0 
		do
			xm_scroll_visible (screen_object, a_widget.screen_object, left_right_margin, top_bottom_margin)
		end;

feature -- Element change

	set_traverse_obscured_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the keyboard focus is
			-- moved to a widget of a gadget that is obscured from view.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNtraverseObscuredCallback, a_command, an_argument)
		ensure
			command_set: command_set 
				(traverse_obscured_command, a_command, an_argument)
		end;

feature -- Removal

	remove_traverse_obscured_callback is
			-- Remove the command for traverse obscured callback.
		do
			remove_callback (XmNtraverseObscuredCallback)
		ensure
			removed: traverse_obscured_command = Void
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER;
				resource_name: POINTER): MEL_TRAVERSE_OBSCURED_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	xm_create_scrolled_window (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/ScrolledW.h>"
		alias
			"XmCreateScrolledWindow"
		end

	xm_scroll_visible (scr, widget: POINTER; lm, rm: INTEGER) is
		external
			"C (Widget, Widget, Dimension, Dimension) | <Xm/ScrolledW.h>"
		alias
			"XmScrollVisible"
		end

	xm_create_scrolled_window_with_automatic_scrolling (a_parent, a_name: POINTER): POINTER is
		external
			"C"
		end

end -- class MEL_SCROLLED_WINDOW


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

