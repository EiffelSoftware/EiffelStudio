indexing

	description:
			"Manager widget that allows selection from a range of values.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCALE

inherit

	MEL_SCALE_RESOURCES
		export
			{NONE} all
		end;

	MEL_MANAGER
		redefine
			create_callback_struct
		end;

	MEL_FONTABLE
		undefine
			clean_up, object_clean_up, destroy
		redefine
			create_callback_struct
		end;

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scale.
		require
			name_exists: a_name /= Void
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scale (a_parent.screen_object, $widget_name, default_pointer, 0);
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

	label: MEL_LABEL_GADGET is
			-- Label text widget of scale
		local
			c_list: FIXED_LIST [POINTER];
			i, c: INTEGER
		do
			if private_text_widget = Void then
				c := children_count;
				c_list := children;
				from
					c_list.start
				until		
					c_list.after or else Result /= Void
				loop
					if xm_is_label_gadget (c_list.item) then
						!! Result.make_from_existing (c_list.item, Current);
					end;
					c_list.forth
				end
				private_text_widget := Result
			end;
			Result := private_text_widget
		ensure
			non_void_result: Result /= Void
		end;

	scroll_bar: MEL_SCROLL_BAR is
			-- Scroll bar of scale
		local
			c_list: FIXED_LIST [POINTER]	
		do
			if private_sb_widget = Void then
				c_list := children;
				from
					c_list.start
				until		
					c_list.after or else Result /= Void
				loop
					if xm_is_scroll_bar (c_list.item) then
						!! Result.make_from_existing (c_list.item, Current);
					end;
					c_list.forth
				end
				private_sb_widget := Result
			end;
			Result := private_sb_widget
		ensure
			non_void_result: Result /= Void
		end;

	drag_command: MEL_COMMAND_EXEC is
			-- Command set for the drag callback
		do
			Result := motif_command (XmNdragCallback)
		end;

	value_changed_command: MEL_COMMAND_EXEC is
			-- Command set for the drag callback
		do
			Result := motif_command (XmNvalueChangedCallback)
		end;

feature -- Status report

	value: INTEGER is
			-- Value of the slider position along the scale
		require
			exists: not is_destroyed
		do
			xm_scale_get_value (screen_object, $Result)
		ensure
			value_large_enough: Result >= minimum;
			value_small_enough: Result <= maximum
		end;

	decimal_points: INTEGER is
			-- Number of decimal places to shift
		require
			exists: not is_destroyed
		do
			Result := get_xt_short (screen_object, XmNdecimalPoints)
		ensure
			decimal_points_larger_enough: Result >= 0
		end

	is_highlighted_on_entry: BOOLEAN is
			-- Is Current highlighted when the input focus enters Current's window?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNhighlightOnEnter)
		end

	highlight_thickness: INTEGER is
			-- Thickness of the highlighting rectangle
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNhighlightThickness)
		end

	scale_width: INTEGER is
			-- Width of the slider area
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNscaleWidth)
		end

	scale_height: INTEGER is
			-- Height of the slider area
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNscaleHeight)
		end

	title_string: MEL_STRING is
			-- Scale text
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNtitleString)
		end;

	scale_multiple: INTEGER is
			-- Distance to move slider when the user moves it by a multiple increment
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNscaleMultiple)
		end;

	is_horizontal: BOOLEAN is
			-- Is scale orientation horizontal?
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
			-- Is processing direction top?
		require
			exists: not is_destroyed;
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

	is_maximum_on_left: BOOLEAN is
			-- Is processing direction left?
		require
			exists: not is_destroyed;
			is_horizontal: is_horizontal
		do
			Result := processing_direction = XmMAX_ON_LEFT
		end;

	is_maximum_on_right: BOOLEAN is
			-- Is processing direction right?
		require
			exists: not is_destroyed;
			is_horizontal: is_horizontal
		do
			Result := processing_direction = XmMAX_ON_RIGHT
		end;

	is_value_shown: BOOLEAN is
			-- Is `value' shown on the screen?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNshowvalue)
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

feature -- Status setting

	set_decimal_points (a_number : INTEGER) is
			-- Set `decimal_points' to `a_number'.
		require
			exists: not is_destroyed
			position_large_enough: a_number >= 0
		do
			set_xt_int (screen_object, XmNdecimalPoints, a_number)
		ensure
			value_set: decimal_points = a_number
		end

	set_scale_multiple (a_granularity: INTEGER) is
			-- Set `scale_multiple' to `a_granularity'.
		require
			exists: not is_destroyed
			granularity_large_enough: a_granularity >= 1;
			granularity_small_enough: a_granularity <= (maximum - minimum)
		do
			set_xt_int (screen_object, XmNscaleMultiple, a_granularity)
		ensure
			value_set: scale_multiple = a_granularity
		end;

	set_highlight_on_entry is
			-- Set `is_highlighted_on_entry' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNhighlightOnEnter, True)
		ensure
			highlighted_on_enter: is_highlighted_on_entry
		end;

	no_highlight_on_entry is
			-- Set `is_highlighted_on_entry' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNhighlightOnEnter, False)
		ensure
			do_not_highlight_on_enter: not is_highlighted_on_entry 
		end;

	set_highlight_thickness (a_thickness: INTEGER) is
			-- Set `highlight_thickness' to `a_thickness'.
		require
			exists: not is_destroyed
			thickness_large_enough: a_thickness >= 0
		do
			set_xt_dimension (screen_object, XmNhighlightThickness, a_thickness)
		ensure
			thickness_set: highlight_thickness = a_thickness
		end;

	set_scale_size (a_width, a_height: INTEGER) is
			-- Set `scale_width' to `a_width' and `scale_height' to `a_height'.
		require
			exists: not is_destroyed;
			width_large_enough: a_width >= 0;
			height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNscaleWidth, a_width);
			set_xt_dimension (screen_object, XmNscaleHeight, a_height)
		ensure
			scale_width_set: scale_width = a_width;
			scale_height_set: scale_height = a_height
		end;

	set_scale_width (a_width: INTEGER) is
			-- Set `scale_width' to `a_width'.
		require
			exists: not is_destroyed;
			width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNscaleWidth, a_width)
		ensure
			width_set: scale_width = a_width
		end;

	set_scale_height (a_height: INTEGER) is
			-- Set `scale_height' to `a_height'.
		require
			exists: not is_destroyed;
			height_large_enough: a_height >= 0
		do
			set_xt_dimension (screen_object, XmNscaleHeight, a_height)
		ensure
			height_set: scale_height = a_height
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
			maximum_greater_than_minimum: a_maximum > minimum
		do
			set_xt_int (screen_object, XmNmaximum, a_maximum)
		ensure
			value_set: maximum = a_maximum
		end;

	set_minimum (a_minimum: INTEGER) is
			-- Set `minimum' to `a_minimum'.
		require
			exists: not is_destroyed;
			minimum_smaller_than_maximum: a_minimum < maximum
		do
			set_xt_int (screen_object, XmNminimum, a_minimum)
		ensure
			value_set: minimum = a_minimum
		end;

	set_title_string (a_compound_string: MEL_STRING) is
			-- Set `title_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNtitlestring, a_compound_string)
		ensure
			title_set: title_string.is_equal (a_compound_string)
		end;

	set_value (a_value: INTEGER) is
			-- Set `value' to `a_value'.
		require
			exists: not is_destroyed
			value_small_enough: a_value <= maximum;
			value_large_enough: a_value >= minimum
		do
			xm_scale_set_value (screen_object, a_value)
		ensure
			value_set: value = a_value
		end;

	show_value is
			-- Set `is_value_shown' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNshowValue, True)
		ensure
			value_is_shown: is_value_shown 
		end;

	hide_value is
			-- Set `is_value_shown' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNshowValue, False)
		ensure
			value_is_hidden: not is_value_shown 
		end;

feature -- Element change

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

feature -- Removal

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

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER
			resource_name: POINTER): MEL_SCALE_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	private_text_widget: MEL_LABEL_GADGET;
			-- Private text widget

	private_sb_widget: MEL_SCROLL_BAR;
			-- Private Scroll Bar widget

	processing_direction: INTEGER is
			-- Position at which to display the slider's maximum and minimum values
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

	xm_create_scale (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/Scale.h>"
		alias
			"XmCreateScale"
		end;

	xm_scale_get_value (widget, value_return: POINTER) is
		external
			"C (Widget, int *) | <Xm/Scale.h>"
		alias
			"XmScaleGetValue"
		end

	xm_scale_set_value (widget: POINTER; a_value: INTEGER) is
		external
			"C (Widget, int) | <Xm/Scale.h>"
		alias
			"XmScaleSetValue"
		end;

invariant

	value_small_enough: not is_destroyed implies value <= maximum;
	value_large_enough: not is_destroyed implies value >= minimum;
	valid_range: not is_destroyed implies minimum <= maximum

end -- class MEL_SCALE


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

