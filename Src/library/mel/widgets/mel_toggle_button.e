indexing

	description:
			"Button widget that maintains a boolean state.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_TOGGLE_BUTTON

inherit

	MEL_TOGGLE_BUTTON_RESOURCES
		export
			{NONE} all
		end;

	MEL_LABEL
		redefine
			make, create_callback_struct
		end

creation 
	make,
	make_from_existing

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif toggle button.
		local
			widget_name: ANY
		do
			parent := a_parent;	
			widget_name := a_name.to_c;
			screen_object := xm_create_toggle_button (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.add (Current);
			set_default;
			if do_manage then
				manage
			end
		end;

feature -- Status report

	state: BOOLEAN is
			-- Is Current selected?
		require
			exists: not is_destroyed
		do
			Result := xm_toggle_button_get_state (screen_object);
		end;

	filled_on_select: BOOLEAN is
			-- Will the indicator be filled with `select_color' to indicate selection?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNfillOnSelect)
		end;

	is_indicator_visible: BOOLEAN is
			-- Is the indicator visible?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNindicatorOn)
		end;

	indicator_size: INTEGER is
			-- Size of the indicator
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNindicatorSize)
		ensure
			indicator_size_large_enough: Result >= 0
		end;

	is_indicator_n_of_many: BOOLEAN is
			-- Is the indicator part of `n of many' group?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNindicatorType) = XmN_OF_MANY
		end;

	is_indicator_one_of_many: BOOLEAN is
			-- Is the indicator part of `one of many' group?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char 	
					(screen_object, XmNindicatorType) = XmONE_OF_MANY
		end;

	select_color: MEL_PIXEL is
			-- Color used to indicate selected state
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixel (Current, XmNselectColor)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	select_insensitive_pixmap: MEL_PIXMAP is
			-- The insensitive Pixmap
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNselectInsensitivePixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	select_pixmap: MEL_PIXMAP is
			-- The select Pixmap
		require
			exists: not is_destroyed
		do
			Result := get_xt_pixmap (Current, XmNselectPixmap)
		ensure
			valid_Result: Result /= Void and then Result.is_valid;
			Result_has_same_display: Result.same_display (display);
			Result_is_shared: Result.is_shared
		end;

	spacing: INTEGER is
			-- Distance between the indicator and the label
		require
			exists: not is_destroyed
		do
			Result := get_xt_dimension (screen_object, XmNspacing)
		ensure
			spacing_large_enough: Result >= 0
		end;

	is_indicator_visible_when_off: BOOLEAN is
			-- Is the toggle indicator visible when `state' is false?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNvisibleWhenOff)
		end;

feature -- Status setting

	set_toggle_on is
			-- Set `state' to True.
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, True, False)
		ensure
			state_is_true: state
		end;

	set_toggle_off is
			-- Set `state' to False.
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, False, False)
		ensure
			state_is_false: not state
		end;

	arm is
			-- Set `state' to True and call the appropriate callback.
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, True, True)
		ensure
			state_is_true: state
		end;

	disarm is
			-- Set `state' to False and call the appropriate callback.
		require
			exists: not is_destroyed
		do
			xm_toggle_button_set_state (screen_object, False, True)
		ensure
			state_is_false: not state
		end;

	fill_on_select is
			-- Set `filled_on_select' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNfillOnSelect, True)
		ensure
			filled_on_select: filled_on_select 
		end;

	no_fill_on_select is
			-- Set `filled_on_select' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNfillOnSelect, False)
		ensure
			is_not_filled_on_select: not filled_on_select 
		end;

	set_indicator_visible is
			-- Set `is_indicator_visible' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNindicatorOn, True)
		ensure
			indicator_is_visible: is_indicator_visible 
		end;

	set_indicator_invisible is
			-- Set `is_indicator_invisible' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNindicatorOn, False)
		ensure
			indicator_is_invisible: not is_indicator_visible 
		end;

	set_indicator_size (a_width: INTEGER) is
			-- Set `indicator_size' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNindicatorSize, a_width)
		ensure
			value_set: indicator_size = a_width
		end;

	set_indicator_to_n_to_many is
			-- Set `is_indicator_n_of_many' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNindicatorType, XmN_OF_MANY)
		ensure
			indicator_square_is_n_of_many: is_indicator_n_of_many
		end;

	set_indicator_to_one_to_many is
			-- Set `is_indicator_one_of_many' to True.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNindicatorType, XmONE_OF_MANY)
		ensure
			indicator_square_is_one_of_many: is_indicator_one_of_many
		end;

	set_select_color (a_color: MEL_PIXEL) is
			-- Set `select_color' to `a_color'.
		require
			exists: not is_destroyed;
			valid_color: a_color /= Void and then a_color.is_valid;
			same_display: a_color.same_display (display)
		do
			set_xt_pixel (screen_object, XmNselectColor, a_color)
		ensure
			select_color_set: select_color.is_equal (a_color)
		end;

	set_select_insensitive_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `select_insensitive_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			is_pixmap: a_pixmap.is_pixmap;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNselectInsensitivePixmap, a_pixmap)
		ensure
			select_insensitive_pixmap_set: select_insensitive_pixmap.is_equal (a_pixmap)
		end;	

	set_select_pixmap (a_pixmap: MEL_PIXMAP) is
			-- Set `select_pixmap' to `a_pixmap'.
		require
			exists: not is_destroyed;
			valid_pixmap: a_pixmap /= Void and then a_pixmap.is_valid;
			is_pixmap: a_pixmap.is_pixmap;
			same_display: a_pixmap.same_display (display)
		do
			set_xt_pixmap (screen_object, XmNselectPixmap, a_pixmap)
		ensure
			select_pixmap_set: select_pixmap.is_equal (a_pixmap)
		end;

	set_spacing (a_width: INTEGER) is
			-- Set `spacing' to `a_width'.
		require
			exists: not is_destroyed;
			a_width_large_enough: a_width >= 0
		do
			set_xt_dimension (screen_object, XmNspacing, a_width)
		ensure
			value_set: spacing = a_width
		end;

	enable_indicator_visible_when_off is
			-- Set `is_indicator_visible_when_off' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNvisibleWhenOff, True)
		ensure
			indicator_is_visible_when_off_enabled: is_indicator_visible_when_off 
		end;

	disable_indicator_visible_when_off is
			-- Set `is_indicator_visible_when_off' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNvisibleWhenOff, False)
		ensure
			indicator_is_visible_when_off_disabled: not is_indicator_visible_when_off 
		end;

feature -- Element change

	add_value_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the value of the button has
			-- been changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNvalueChangedCallback, a_callback, an_argument)
		end;

	add_arm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button is pressed.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNarmCallback, a_callback, an_argument)
		end;

	add_disarm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Add the callback `a_callback' with argument `an_argument'
			-- to the callbacks called when the button is released.
		require
			a_callback_not_void: a_callback /= Void
		do
			add_callback (XmNdisarmCallback, a_callback, an_argument)
		end;

feature -- Removal

	remove_value_changed_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the value of the button has
			-- been changed.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNvalueChangedCallback, a_callback, an_argument)
		end;

	remove_arm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button is pressed.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNarmCallback, a_callback, an_argument)
		end;

	remove_disarm_callback (a_callback: MEL_CALLBACK; an_argument: ANY) is
			-- Remove the callback `a_callback' with argument `an_argument'
			-- from the callbacks called when the button is released.
		require
			a_callback_not_void: a_callback /= Void
		do
			remove_callback (XmNdisarmCallback, a_callback, an_argument)
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr: POINTER;
				resource_name: POINTER): MEL_TOGGLE_BUTTON_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			!! Result.make (Current, a_callback_struct_ptr)
		end;

feature {NONE} -- Implementation

	xm_toggle_button_set_state (scr_obj: POINTER; value1, value2: BOOLEAN) is
		external
			"C (Widget, Boolean, Boolean) | <Xm/ToggleB.h>"
		alias
			"XmToggleButtonSetState"
		end;

	xm_toggle_button_get_state (scr_obj: POINTER): BOOLEAN is
		external
			"C (Widget): EIF_BOOLEAN | <Xm/ToggleB.h>"
		alias
			"XmToggleButtonGetState"
		end;

	xm_create_toggle_button (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/ToggleB.h>"
		alias
			"XmCreateToggleButton"
		end;

end -- class MEL_TOGGLE_BUTTON

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
