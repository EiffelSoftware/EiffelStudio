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
	make, make_with_automatic_scrolling, make_from_existing

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled window.
		require
			a_name_exists: a_name /= Void;
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_window (a_parent.screen_object,
									$widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed
		end;

	make_with_automatic_scrolling (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled window with an automatic scrolling.
		require
			a_name_exists: a_name /= Void;
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_window_with_automatic_scrolling
									(a_parent.screen_object, $widget_name);
			Mel_widgets.put (Current, screen_object);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed
		end;

feature -- Status report

	clip_window: MEL_OBJECT is
			-- Clipping area
		require
			exists: not is_destroyed
		local
			w: POINTER
		do
			w := c_get_widget (screen_object, XmNclipWindow);
			if w /= default_pointer then	
				Result := Mel_widgets.item (w);
				if Result = Void then
					!MEL_WIDGET! Result.make_from_existing (w)
				end
			end
		end;

	horizontal_scroll_bar: MEL_SCROLL_BAR is
			-- Horizontal scrollbar
		require
			exists: not is_destroyed
		local
			w: POINTER
		do
			w := c_get_widget (screen_object, XmNhorizontalScrollbar)
			if w /= default_pointer then	
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w)
				end
			end
		end;

	vertical_scroll_bar: MEL_SCROLL_BAR is
			-- Vertical scrollbar
		require
			exists: not is_destroyed
		local
			w: POINTER
		do
			w := c_get_widget (screen_object, XmNverticalScrollbar)
			if w /= default_pointer then	
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w)
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

	set_scroll_bar_display_policy_static (b: BOOLEAN) is
			-- Set `scroll_bar_display_policy_static' to `b'.
		require
			exists: not is_destroyed
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNscrollBarDisplayPolicy, XmSTATIC)
			else
				set_xt_unsigned_char (screen_object, XmNscrollBarDisplayPolicy, XmAS_NEEDED)
			end
		ensure
			display_policy_set: is_scroll_bar_display_policy_static = b
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
			a_widget_exists: not a_widget.is_destroyed
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

	add_traverse_obscured_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the keyboard focus is moved to
			-- a widget or a gadget that is obscured from view.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNtraverseObscuredCallback, a_callback, an_argument)
		end;

feature -- Removal

	remove_traverse_obscured_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the keyboard focus is moved to
			-- a widget or a gadget that is obscured from view.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNtraverseObscuredCallback, a_callback, an_argument)
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
			"C [macro <Xm/ScrolledW.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateScrolledWindow"
		end

	xm_scroll_visible (scr, widget: POINTER; lm, rm: INTEGER) is
		external
			"C [macro <Xm/ScrolledW.h>] (Widget, Widget, Dimension, Dimension)"
		alias
			"XmScrollVisible"
		end

	xm_create_scrolled_window_with_automatic_scrolling (a_parent, a_name: POINTER): POINTER is
		external
			"C"
		end

end -- class MEL_SCROLLED_WINDOW

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------
