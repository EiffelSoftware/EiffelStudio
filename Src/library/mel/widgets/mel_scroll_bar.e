indexing

	description:
			"Widget to controll the scrolling of the viewing area in another widget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLL_BAR

inherit

	MEL_SCROLL_BAR_RESOURCES
		export
			{NONE} all
		end;

	MEL_PRIMITIVE
		redefine
			create_callback_struct
		end

creation 
	make, 
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrollbar.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scroll_bar (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent = a_parent;
			name_set: name.is_equal (a_name)
		end;

feature -- Status report

	value: INTEGER is
			-- Value of the current slider position
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNvalue)
		ensure
			value_large_enough: Result >= minimum;
			value_small_enough: Result <= maximum
		end;

	increment: INTEGER is
			-- Amount `value' changes when a move action occurs
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNincrement)
		ensure
			granularity_large_enough: Result >= 1;
			granularity_small_enough: Result <= (maximum - minimum)
		end;

	initial_delay: INTEGER is
			-- Number of milliseconds to wait before triggering continuous slider movement
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNinitialDelay)
		ensure
			initial_delay_large_enough: Result > 0
		end;

	is_horizontal: BOOLEAN is
			-- Is scrollbar orientation horizontal?
		require
			exists: not is_destroyed
		do
			Result := orientation = XmHORIZONTAL
		end;

	is_maximum_on_top: BOOLEAN is
			-- Is `maximum' placed at the top?
		require
			exists: not is_destroyed
			vertical: not is_horizontal
		do
			Result := processing_direction = XmMAX_ON_TOP
		end;

	is_maximum_on_left: BOOLEAN is
			-- Is `maximum' placed at the left?
		require
			exists: not is_destroyed
			is_horizontal: is_horizontal
		do
			Result := processing_direction = XmMAX_ON_LEFT
		end;

	maximum: INTEGER is
			-- Maximum value
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNmaximum)
		ensure
			maximum_greater_than_minimum: Result >= minimum
		end;

	minimum: INTEGER is
			-- Minimum value
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNminimum)
		ensure
			minimum_smaller_than_maximum: Result <= maximum
		end;

	page_increment: INTEGER is
			-- Amount `value' changes when a page move action occurs
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNpageIncrement)
		ensure
			page_increment_large_enough: Result >= 1;
			page_increment_small_enough: Result <= (maximum - minimum)
		end;

	repeat_delay: INTEGER is
			-- Number of milliseconds to wait between subsequent
			-- slider movements after the initial delay
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNrepeatDelay)
		ensure
			positive_delay: Result > 0
		end;

	are_arrows_shown: BOOLEAN is
			-- Are arrows shown?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNshowArrows)
		end;

	slider_size: INTEGER is
			-- Size of slider
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNsliderSize)
		ensure
			slider_size_small_enough: Result <= (maximum - minimum);
			slider_size_large_enough: Result >= 0
		end;

	trough_color: MEL_PIXEL is
			-- Color of the slider's trough.
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNtroughColor)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.shared
		end;

feature  -- Status setting

	set_value (a_value: INTEGER) is
			-- Set `value' to `a_value'.
		require
			exists: not is_destroyed;
			value_small_enough: a_value <= maximum;
			value_large_enough: a_value >= minimum
		do
			set_xt_int (screen_object, XmNvalue, a_value)
		ensure
			value_set: value = a_value
		end;

	set_increment (new_granularity: INTEGER) is
			-- Set `increment' to `new_granularity'.
		require
			exist: not is_destroyed;
			increment_large_enough: new_granularity >= 1;
			increment_small_enough: new_granularity <= (maximum - minimum)
		do
			set_xt_int (screen_object, XmNincrement, new_granularity)
		ensure
			 increment_set: increment = new_granularity
		end;

	set_initial_delay (new_delay: INTEGER) is
			-- Set `initial_delay' to `new_delay'.
		require
			exists: not is_destroyed;
			positive_delay: new_delay > 0
		do
			set_xt_int (screen_object, XmNinitialDelay, new_delay)
		ensure
			delay_set: initial_delay = new_delay
		end;

	set_horizontal (b: BOOLEAN) is
			-- Set `is_horizontal' to `b'.
		require
			exists: not is_destroyed
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNorientation, XmHORIZONTAL)
			else
				set_xt_unsigned_char (screen_object, XmNorientation, XmVERTICAL)
			end
		ensure
			value_set: is_horizontal = b
		end;

	set_maximum_on_top (b: BOOLEAN) is
			-- Set `maximum_on_top' to `b'.
		require
			exists: not is_destroyed;
			vertical: not is_horizontal
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNprocessingDirection, XmMAX_ON_TOP)
			else
				set_xt_unsigned_char (screen_object, XmNprocessingDirection, XmMAX_ON_BOTTOM)
			end
		ensure
			value_set: is_maximum_on_top = b
		end

	set_maximum_on_left (b: BOOLEAN) is
			-- Set `is_maximum_on_left' to `b'.
		require
			exists: not is_destroyed;
			horizontal: is_horizontal
		do
			if b then
				set_xt_unsigned_char (screen_object, XmNprocessingDirection, XmMAX_ON_LEFT)
			else
				set_xt_unsigned_char (screen_object, XmNprocessingDirection, XmMAX_ON_RIGHT)
			end
		ensure
			value_set: is_maximum_on_left = b
		end

	set_maximum (a_maximum: INTEGER) is
			-- Set `maximum' to `a_maximum'.
		require
			exists: not is_destroyed;
			a_maximum_greater_than_minimum: a_maximum > minimum
		do
			set_xt_int (screen_object, XmNmaximum, a_maximum)
		ensure
			maximum_set: maximum = a_maximum
		end;

	set_minimum (a_minimum: INTEGER) is
			-- Set `minimum' to `a_minimum'.
		require
			exists: not is_destroyed;
			a_minimum_smaller_than_maximum: a_minimum < maximum
		do
			set_xt_int (screen_object, XmNminimum, a_minimum)
		ensure
			minimum_set: minimum = a_minimum
		end;

	set_page_increment (a_value: INTEGER) is
			-- Set `page_increment' to `a_value'.
		require
			exists: not is_destroyed;
			page_increment_large_enough: a_value >= 1;
			page_increment_small_enough: a_value <= (maximum - minimum)
		do
			set_xt_int (screen_object, XmNpageIncrement, a_value)
		ensure
			page_increment_set: page_increment = a_value
		end;

	set_repeat_delay (a_delay: INTEGER) is
			-- Set `repeat_delay' to `a_delay'.
		require
			exists: not is_destroyed;
			positive_delay: a_delay > 0
		do
			set_xt_int (screen_object, XmNrepeatDelay, a_delay)
		ensure
			delay_set: repeat_delay = a_delay
		end;

	set_arrows_shown (b: BOOLEAN) is
			-- Set `are_arrows_shown' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNshowArrows, b)
		ensure
			arrows_displayed : are_arrows_shown = b
		end;

	set_slider_size (a_size: INTEGER) is
			-- Set `slider_size' to `a_size'.
		require
			exists: not is_destroyed;
			a_size_small_enough: a_size <= (maximum - minimum);
			a_size_large_enough: a_size >= 1
		do
			set_xt_int (screen_object, XmNsliderSize, a_size)
		ensure
			slider_size_set: slider_size = a_size
		end;

	set_trough_color (a_color: MEL_PIXEL) is
			-- Set `trough_color' to `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNtroughColor, a_color)
		ensure
			trough_color_set: trough_color.is_equal (a_color)
		end;

feature  -- Element change

	add_drag_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the slider is being dragged.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNdragCallback, a_callback, an_argument)
		end;

	add_value_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the position of the slider has changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNvalueChangedCallback, a_callback, an_argument)
		end;

	add_decrement_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the value of the scrollbar
			-- decreases by one increment.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNdecrementCallback, a_callback, an_argument)
		end;

	add_increment_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the value of the scrollbar
			-- increases by one increment.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNincrementCallback, a_callback, an_argument)
		end;

	add_page_decrement_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the value of the scrollbar
			-- decreases by one page increment.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNpageDecrementCallback, a_callback, an_argument)
		end;

	add_page_increment_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the value of the scrollbar
			-- increases by one page increment.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNpageIncrementCallback, a_callback, an_argument)
		end;

	add_to_bottom_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the slider is moved to the maximum value
			-- of the scrollbar.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNtoBottomCallback, a_callback, an_argument)
		end;

	add_to_top_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the slider is moved to the minimum value
			-- of the scrollbar.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNtoTopCallback, a_callback, an_argument)
		end;

feature  -- Removal

	remove_drag_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the slider is being dragged.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNdragCallback, a_callback, an_argument)
		end;

	remove_value_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the position of the slider has changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNvalueChangedCallback, a_callback, an_argument)
		end;

	remove_increment_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the value of the scrollbar
			-- increases by one increment.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNincrementCallback, a_callback, an_argument)
		end;

	remove_page_decrement_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the value of the scrollbar
			-- decreases by one page increment.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNpageDecrementCallback, a_callback, an_argument)
		end;

	remove_page_increment_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the value of the scrollbar
			-- increases by one page increment.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNpageIncrementCallback, a_callback, an_argument)
		end;

	remove_to_bottom_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the slider is moved to the maximum value
			-- of the scrollbar.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNtoBottomCallback, a_callback, an_argument)
		end;

	remove_to_top_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the slider is moved to the minimum value
			-- of the scrollbar.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNtoTopCallback, a_callback, an_argument)
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr, 
				resource_name: POINTER): MEL_SCROLL_BAR_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;


feature {NONE} -- Implementation

	processing_direction: INTEGER is
			-- Position at which to display Current's maximum and minimum values
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNprocessingDirection)
		end;

	orientation: INTEGER is
			-- Direction in which the widget is displayed
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNorientation)
		end;

	xm_create_scroll_bar (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
	   external
			"C [macro <Xm/ScrollBar.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateScrollBar"
		end

invariant

	value_small_enough: not is_destroyed implies value <= maximum;
	value_large_enough: not is_destroyed implies value >= minimum;
	valid_range: not is_destroyed implies minimum <= maximum

end -- class MEL_SCROLL_BAR

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
