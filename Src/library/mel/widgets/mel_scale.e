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
		end

creation 
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scale.
		require
			a_name_exists: a_name /= Void
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scale (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			set_default;
			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed
		end;

feature -- Access

	text_widget: MEL_LABEL_GADGET is
			-- Text widget
		local
			w: POINTER;
			i, c: INTEGER
		do
			if private_text_widget = Void then
				c := children_count;
				from
					i := 1
				until		
					i > c 
				loop
					w := get_i_th_widget_child (screen_object, i - 1);
					if xm_is_label_gadget (w) then
						!! private_text_widget.make_from_existing (w);
						i := c 
					end;
					i := i + 1
				end
			end;
			Result := private_text_widget
		ensure
			non_void_result: Result /= Void
		end;

	scroll_bar_widget: MEL_LABEL_GADGET is
			-- Scroll bar
		local
			w: POINTER;
			i, c: INTEGER	
		do
			if private_sb_widget = Void then
				c := children_count;
				from
					i := 1
				until		
					i > c 
				loop
					w := get_i_th_widget_child (screen_object, i - 1);
					if xm_is_scroll_bar (w) then
						!! private_sb_widget.make_from_existing (w);
						i := c 
					end;
					i := i + 1
				end
			end;
			Result := private_sb_widget
		ensure
			non_void_result: Result /= Void
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

	is_highlighted_on_enter: BOOLEAN is
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
		ensure
			title_string_not_void: Result /= Void
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

	is_maximum_on_top: BOOLEAN is
			-- Is processing direction top?
		require
			exists: not is_destroyed
			vertical: not is_horizontal
		do
			Result := processing_direction = XmMAX_ON_TOP
		end;

	is_maximum_on_left: BOOLEAN is
			-- Is processing direction left?
		require
			exists: not is_destroyed
			is_horizontal: is_horizontal
		do
			Result := processing_direction = XmMAX_ON_LEFT
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

	set_highlighted_on_enter (b: BOOLEAN) is
			-- Set `is_highlighted_on_enter'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNhighlightOnEnter, b)
		ensure
			highlighted_on_enter: is_highlighted_on_enter = b
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
			-- Set `is_maximum_on_top' to `b'.
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
			is_horizontal: is_horizontal
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

	set_value_shown (b: BOOLEAN) is
			-- Set `is_value_shown' to `b'.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNshowValue, b)
		ensure
			is_value_shown: is_value_shown = b
		end;

feature -- Element change

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

feature -- Removal

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

	private_sb_widget: MEL_LABEL_GADGET;
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
			"C [macro <Xm/Scale.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateScale"
		end;

	xm_scale_get_value (widget, value_return: POINTER) is
		external
			"C [macro <Xm/Scale.h>] (Widget, int *)"
		alias
			"XmScaleGetValue"
		end

	xm_scale_set_value (widget: POINTER; a_value: INTEGER) is
		external
			"C [macro <Xm/Scale.h>] (Widget, int)"
		alias
			"XmScaleSetValue"
		end;

	xm_is_scroll_bar (widget: POINTER): BOOLEAN is
		external
			"C [macro <Xm/ScrollBar.h>] (Widget): EIF_BOOLEAN"
		alias
			"XmIsScrollBar"
		end;

	xm_is_label (widget: POINTER): BOOLEAN is
		external
			"C [macro <Xm/Label.h>] (Widget): EIF_BOOLEAN"
		alias
			"XmIsLabel"
		end;

	xm_is_label_gadget (widget: POINTER): BOOLEAN is
		external
			"C [macro <Xm/LabelG.h>] (Widget): EIF_BOOLEAN"
		alias
			"XmIsLabelGadget"
		end;

invariant

	value_small_enough: not is_destroyed implies value <= maximum;
	value_large_enough: not is_destroyed implies value >= minimum;
	valid_range: not is_destroyed implies minimum <= maximum

end -- class MEL_SCALE

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
