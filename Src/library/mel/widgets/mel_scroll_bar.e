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

feature -- Access

	drag_command: MEL_COMMAND_EXEC is
			-- Command set for the drag callback
		do
			Result := motif_command (XmNdragCallback)
		end;

	value_changed_command: MEL_COMMAND_EXEC is
			-- Command set for the value changed callback
		do
			Result := motif_command (XmNvalueChangedCallback)
		end;

	increment_command: MEL_COMMAND_EXEC is
			-- Command set for the increment callback
		do
			Result := motif_command (XmNincrementCallback)
		end;

	decrement_command: MEL_COMMAND_EXEC is
			-- Command set for the decrement callback
		do
			Result := motif_command (XmNdecrementCallback)
		end;

	page_decrement_command: MEL_COMMAND_EXEC is
			-- Command set for the page decrement callback
		do
			Result := motif_command (XmNpageDecrementCallback)
		end;

	page_increment_command: MEL_COMMAND_EXEC is
			-- Command set for the page increment callback
		do
			Result := motif_command (XmNvalueChangedCallback)
		end;

	to_bottom_command: MEL_COMMAND_EXEC is
			-- Command set for the to bottom callback
		do
			Result := motif_command (XmNtoBottomCallback)
		end;

	to_top_command: MEL_COMMAND_EXEC is
			-- Command set for the to top callback
		do
			Result := motif_command (XmNtoTopCallback)
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

	is_vertical: BOOLEAN is
			-- Is scale orientation vertical?
		require
			exists: not is_destroyed
		do
			Result := orientation = XmVERTICAL
		end;

	is_maximum_on_top: BOOLEAN is
			-- Is `maximum' placed at the top?
		require
			exists: not is_destroyed
			vertical: not is_horizontal
		do
			Result := processing_direction = XmMAX_ON_TOP
		end;

	is_maximum_on_bottom: BOOLEAN is
			-- Is processing direction bottom?
		require
			exists: not is_destroyed;
			vertical: not is_horizontal
		do
			Result := processing_direction = XmMAX_ON_BOTTOM
		end;

	is_maximum_on_right: BOOLEAN is
			-- Is processing direction right?
		require
			exists: not is_destroyed;
			is_horizontal: is_horizontal
		do
			Result := processing_direction = XmMAX_ON_RIGHT
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
			Result_is_shared: Result.is_shared
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

	set_horizontal is
			-- Set `is_horizontal' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNorientation, XmHORIZONTAL)
		ensure
			is_horizontal: is_horizontal
		end;

	set_vertical is
			-- Set `is_horizontal' to False.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNorientation, XmVERTICAL)
		ensure
			is_vertical: is_vertical
		end;

	set_maximum_on_top is
			-- Set `is_maximum_on_top' to True.
		require
			exists: not is_destroyed;
			vertical: not is_horizontal
		do
			set_xt_unsigned_char (screen_object, XmNprocessingDirection, XmMAX_ON_TOP)
		ensure
			is_maximum_on_top: is_maximum_on_top
		end

	set_maximum_on_bottom is
			-- Set `is_maximum_on_bottom' to True.
		require
			exists: not is_destroyed;
			vertical: not is_horizontal
		do
			set_xt_unsigned_char (screen_object, XmNprocessingDirection, XmMAX_ON_BOTTOM)
		ensure
			is_maximum_on_bottom: is_maximum_on_bottom
		end

	set_maximum_on_left is
			-- Set `is_maximum_on_left' to True.
		require
			exists: not is_destroyed;
			is_horizontal: is_horizontal
		do
			set_xt_unsigned_char (screen_object, XmNprocessingDirection, XmMAX_ON_LEFT)
		ensure
			is_maximum_on_left: is_maximum_on_left
		end

	set_maximum_on_right is
			-- Set `is_maximum_on_right' to True.
		require
			exists: not is_destroyed;
			is_horizontal: is_horizontal
		do
			set_xt_unsigned_char (screen_object, XmNprocessingDirection, XmMAX_ON_RIGHT)
		ensure
			is_maximum_on_right: is_maximum_on_right
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

	show_arrows is
			-- Set `are_arrows_shown' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNshowArrows, True)
		ensure
			arrows_displayed: are_arrows_shown 
		end;

	hide_arrows is
			-- Set `are_arrows_shown' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNshowArrows, False)
		ensure
			arrows_hidden: not are_arrows_shown 
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

	set_drag_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the slider is
			-- being dragged.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNdragCallback, a_command, an_argument)
		ensure
			command_set: command_set (drag_command, a_command, an_argument)
		end;

	set_value_changed_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the slider value changes.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNvalueChangedCallback, a_command, an_argument);
		ensure
			command_set: command_set (value_changed_command, a_command, an_argument)
		end;

	set_decrement_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the slider value 
			-- descreases by one increment.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNdecrementCallback, a_command, an_argument)
		ensure
			command_set: command_set (decrement_command, a_command, an_argument)
		end;

	set_increment_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the slider value 
			-- increases by one increment.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNincrementCallback, a_command, an_argument)
		ensure
			command_set: command_set (increment_command, a_command, an_argument)
		end;

	set_page_decrement_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the slider value 
			-- decreases by one page increment.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNpageDecrementCallback, a_command, an_argument)
		ensure
			command_set: command_set (page_decrement_command, a_command, an_argument)
		end;

	set_page_increment_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the slider value 
			-- increases by one page increment.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNpageIncrementCallback, a_command, an_argument)
		ensure
			command_set: command_set (page_increment_command, a_command, an_argument)
		end;

	set_to_bottom_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the slider is moved
			-- to the maximum value of the scrollbar.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNtoBottomCallback, a_command, an_argument)
		ensure
			command_set: command_set (to_bottom_command, a_command, an_argument)
		end;

	set_to_top_callback (a_command: MEL_COMMAND; an_argument: ANY) is
			-- Set `a_command' to be executed when the slider is moved
			-- to the minimum value of the scrollbar.
			-- `argument' will be passed to `a_command' whenever it is
			-- invoked as a callback.
		require
			command_not_void: a_command /= Void
		do
			set_callback (XmNtoTopCallback, a_command, an_argument)
		ensure
			command_set: command_set (to_top_command, a_command, an_argument)
		end;

feature  -- Removal

	remove_drag_callback is
			-- Remove the command for the drag callback.
		do
			remove_callback (XmNdragCallback)
		ensure
			removed: drag_command = Void
		end;

	remove_value_changed_callback is
			-- Remove the command for the value changed callback.
		do
			remove_callback (XmNvalueChangedCallback)
		ensure
			removed: value_changed_command = Void
		end;

	remove_increment_callback is
			-- Remove the command for the increment callback.
		do
			remove_callback (XmNincrementCallback)
		ensure
			removed: increment_command = Void
		end;

	remove_decrement_callback is
			-- Remove the command for the decrement callback.
		do
			remove_callback (XmNdecrementCallback)
		ensure
			removed: decrement_command = Void
		end;

	remove_page_decrement_callback is
			-- Remove the command for the page decrement callback.
		do
			remove_callback (XmNpageDecrementCallback)
		ensure
			removed: page_decrement_command = Void
		end;

	remove_page_increment_callback is
			-- Remove the command for the page increment callback.
		do
			remove_callback (XmNpageIncrementCallback)
		ensure
			removed: page_increment_command = Void
		end;

	remove_to_bottom_callback is
			-- Remove the command for the to bottom callback.
		do
			remove_callback (XmNtoBottomCallback)
		ensure
			removed: to_bottom_command = Void
		end;

	remove_to_top_callback is
			-- Remove the command for the to top callback.
		do
			remove_callback (XmNtoTopCallback)
		ensure
			removed: to_top_command = Void
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
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/ScrollBar.h>"
		alias
			"XmCreateScrollBar"
		end

invariant

	value_small_enough: not is_destroyed implies value <= maximum;
	value_large_enough: not is_destroyed implies value >= minimum;
	valid_range: not is_destroyed implies minimum <= maximum

end -- class MEL_SCROLL_BAR


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

